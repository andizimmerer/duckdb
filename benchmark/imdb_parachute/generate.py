import os
import sqlparse

SETUP_FILE = "benchmark/imdb_parachute/init/parachute_setup.sql"

imdb_alias_mapping = {
    "aka_name": "an",
    "aka_title": "at",
    "cast_info": "ci",
    "char_name": "cha",
    "comp_cast_type": "cct",
    "company_name": "cn",
    "company_type": "ct",
    "complete_cast": "cc",
    "info_type": "it",
    "keyword": "k",
    "kind_type": "kt", 
    "link_type": "lt",
    "movie_companies": "mc",
    "movie_info_idx": "mi_idx",
    "movie_keyword": "mk",
    "movie_link": "ml",
    "name": "n",
    "role_type": "rt",
    "title": "t",
    "movie_info": "mi",
    "person_info": "pi",
}

def get_alias_map(parsed_sql):
    alias_map = {}
    for stmt in parsed_sql:
        if isinstance(stmt, sqlparse.sql.IdentifierList):
            for i in stmt.tokens:
                if isinstance(i, sqlparse.sql.Identifier):
                    alias_map[i.get_alias()] = i.get_real_name()
    return alias_map


def find_base_table_predicates(alias_map, parsed_sql):
    """Find predicates related to the base table in the WHERE clause."""
    base_tale_predicates = {}
    join_predicates = {}
    for stmt in parsed_sql:
        if isinstance(stmt, sqlparse.sql.Where):
            # In the WHERE clause, we check the conditions
            for condition in stmt.tokens:
                if isinstance(condition, sqlparse.sql.Comparison) or isinstance(condition, sqlparse.sql.Parenthesis):
                    # here, we either have join conditions or comparisons or parenthesis containing comparisons
                    flattened_condition = [str(t) for t in condition.flatten()]
                    aliases = alias_map.keys()
                    found_aliases = [alias in flattened_condition for alias in aliases]
                    if found_aliases.count(True) == 1:
                        # this is a base table predicate because only one table is referenced
                        aidx = found_aliases.index(True)
                        found_table = list(alias_map.keys())[aidx]
                        base_tale_predicates.setdefault(found_table,[]).append(str(condition))
                    if found_aliases.count(True) == 2:
                        # this is a join predicate
                        lhs_aidx = found_aliases.index(True)
                        found_aliases.reverse()
                        rhs_aidx = len(found_aliases) - found_aliases.index(True) - 1
                        lhs_table = list(alias_map.keys())[lhs_aidx]
                        rhs_table = list(alias_map.keys())[rhs_aidx]
                        join_predicates.setdefault(lhs_table,[]).append((rhs_table, str(condition)))
                        join_predicates.setdefault(rhs_table,[]).append((lhs_table, str(condition)))
    return base_tale_predicates, join_predicates


def compute_optimal_parachute(query_id, sql_text, table_names):
    parsed_sql = sqlparse.parse(sql_text)[0]
    alias_map = get_alias_map(parsed_sql)
    base_table_predicates, join_predicates = find_base_table_predicates(alias_map, parsed_sql)

    setup_script = ""
    modified_sql = sql_text.rstrip('\n').rstrip(';') + '\n-- parachute columns\n'
    
    for base_table_alias in table_names:
        if base_table_alias in base_table_predicates:
            base_table_predicate_str = " AND ".join(base_table_predicates[base_table_alias])

            for (joinable_table_alias, join_condition) in join_predicates[base_table_alias]:
                parachute_column = f'optimal_parachute_q{query_id}_{alias_map[base_table_alias]}'
                setup_script += (f"""
ALTER TABLE {alias_map[joinable_table_alias]} ADD COLUMN IF NOT EXISTS {parachute_column} BOOLEAN DEFAULT false;
UPDATE {alias_map[joinable_table_alias]} {joinable_table_alias}
SET {parachute_column} = true
FROM {alias_map[base_table_alias]} {base_table_alias}
WHERE {join_condition} -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    {base_table_predicate_str}
);
""")
                modified_sql += f'  AND {joinable_table_alias}.{parachute_column} = true\n'
    
    modified_sql += ';'
    return modified_sql, setup_script



def get_joinable_tables(base_table):
    join_graph = {
        "title": ["aka_title", "cast_info", "movie_companies", "movie_info", "movie_info_idx", "movie_keyword", "movie_link"],
        "cast_info": ["name", "role_type", "title"],
        "movie_companies": ["company_name", "company_type", "title"],
        "name": ["aka_name", "cast_info", "person_info"],
        "movie_info": ["info_type", "title"],
        "movie_info_idx": ["info_type", "title"],
        "movie_keyword": ["keyword", "title"],
        "movie_link": ["link_type", "title"]
    }
    return join_graph.get(base_table, [])


def read_sql_file(query_id):
    file_path = os.path.join("benchmark/imdb_plan_cost/queries", f"{query_id}.sql")
    with open(file_path, "r") as f:
        return f.read()

def store_modified_query(query_id, sql_text):
    file_path = os.path.join("benchmark/imdb_parachute/queries", f"{query_id}.sql")
    with open(file_path, "w") as f:
        f.write(sql_text)

def append_setup(query_id, s):
    with open(SETUP_FILE, "a") as f:
        f.write(f"""
                
-------------
-- {query_id}
-------------
""")
        f.write(s)

def create_benchmark_file(query_id):
    file_path = os.path.join("benchmark/imdb_parachute/", f"{query_id}.benchmark")
    with open(file_path, "w") as f:
        f.write(f"""# name: benchmark/imdb_parachute/{query_id}.benchmark
# description: Run query {query_id} from the imdb benchmark (single-threaded)
# group: [imdb]

template benchmark/imdb_parachute/imdb_parachute.benchmark.in
QUERY_NUMBER={query_id}
QUERY_NUMBER_PADDED={query_id}
""")
        
def init_setup_file():
    with open(SETUP_FILE, "w") as f:
        f.write("""
CREATE TABLE aka_name AS SELECT * FROM read_parquet('https://github.com/duckdb/duckdb-data/releases/download/v1.0/job_aka_name.parquet');
CREATE TABLE aka_title AS SELECT * FROM read_parquet('https://github.com/duckdb/duckdb-data/releases/download/v1.0/job_aka_title.parquet');
CREATE TABLE cast_info AS SELECT * FROM read_parquet('https://github.com/duckdb/duckdb-data/releases/download/v1.0/job_cast_info.parquet');
CREATE TABLE char_name AS SELECT * FROM read_parquet('https://github.com/duckdb/duckdb-data/releases/download/v1.0/job_char_name.parquet');
CREATE TABLE comp_cast_type AS SELECT * FROM read_parquet('https://github.com/duckdb/duckdb-data/releases/download/v1.0/job_comp_cast_type.parquet');
CREATE TABLE company_name AS SELECT * FROM read_parquet('https://github.com/duckdb/duckdb-data/releases/download/v1.0/job_company_name.parquet');
CREATE TABLE company_type AS SELECT * FROM read_parquet('https://github.com/duckdb/duckdb-data/releases/download/v1.0/job_company_type.parquet');
CREATE TABLE complete_cast AS SELECT * FROM read_parquet('https://github.com/duckdb/duckdb-data/releases/download/v1.0/job_complete_cast.parquet');
CREATE TABLE info_type AS SELECT * FROM read_parquet('https://github.com/duckdb/duckdb-data/releases/download/v1.0/job_info_type.parquet');
CREATE TABLE keyword AS SELECT * FROM read_parquet('https://github.com/duckdb/duckdb-data/releases/download/v1.0/job_keyword.parquet');
CREATE TABLE kind_type AS SELECT * FROM read_parquet('https://github.com/duckdb/duckdb-data/releases/download/v1.0/job_kind_type.parquet');
CREATE TABLE link_type AS SELECT * FROM read_parquet('https://github.com/duckdb/duckdb-data/releases/download/v1.0/job_link_type.parquet');
CREATE TABLE movie_companies AS SELECT * FROM read_parquet('https://github.com/duckdb/duckdb-data/releases/download/v1.0/job_movie_companies.parquet');
CREATE TABLE movie_info AS SELECT * FROM read_parquet('https://github.com/duckdb/duckdb-data/releases/download/v1.0/job_movie_info.parquet');
CREATE TABLE movie_info_idx AS SELECT * FROM read_parquet('https://github.com/duckdb/duckdb-data/releases/download/v1.0/job_movie_info_idx.parquet');
CREATE TABLE movie_keyword AS SELECT * FROM read_parquet('https://github.com/duckdb/duckdb-data/releases/download/v1.0/job_movie_keyword.parquet');
CREATE TABLE movie_link AS SELECT * FROM read_parquet('https://github.com/duckdb/duckdb-data/releases/download/v1.0/job_movie_link.parquet');
CREATE TABLE name AS SELECT * FROM read_parquet('https://github.com/duckdb/duckdb-data/releases/download/v1.0/job_name.parquet');
CREATE TABLE person_info AS SELECT * FROM read_parquet('https://github.com/duckdb/duckdb-data/releases/download/v1.0/job_person_info.parquet');
CREATE TABLE role_type AS SELECT * FROM read_parquet('https://github.com/duckdb/duckdb-data/releases/download/v1.0/job_role_type.parquet');
CREATE TABLE title AS SELECT * FROM read_parquet('https://github.com/duckdb/duckdb-data/releases/download/v1.0/job_title.parquet');

-- Disable bloom filter because we sometimes get a wrong result and we certainly don't want that here during setup
set hash_join_bloom_filter=false;


-- Algorithm:
-- 1. Get the list of tables with a bloom-filter, i.e., tables that are on probe sides and where the build side was large enough
-- 2. Check if the query text had a base-table-predicate on that table
-- 3. If yes, add a parachute to all tables that are joined with that table with that filter predicate

""")
    
def handle_query(query_id, tables):
    sql_text = read_sql_file(query_id)
    modified_sql, setup = compute_optimal_parachute(query_id, sql_text, tables)
    store_modified_query(query_id, modified_sql)
    append_setup(query_id, setup)
    create_benchmark_file(query_id)
    


init_setup_file()

handle_query("01a", ["t"])
handle_query("01b", [])
handle_query("01c", [])
handle_query("01d", [])
handle_query("02a", ["mc", "cn", "t"])
handle_query("02b", ["mc", "cn", "t"])
handle_query("02c", ["mc", "cn"])
handle_query("02d", ["mc", "cn", "t"])
handle_query("03a", ["mc", "mi"])
handle_query("03b", ["t", "mk", "k"])
handle_query("03c", ["mk", "mi"])
handle_query("04a", ["t", "mk", "k"])
handle_query("04b", ["t", "mk", "k"])
handle_query("04c", ["t", "mk", "k"])
handle_query("05a", ["t"])
handle_query("05b", ["t"])
handle_query("05c", ["t", "mi"])
handle_query("06a", ["n"])
handle_query("06b", ["mk"])
handle_query("06c", [])
handle_query("06d", ["mk", "ci"])
handle_query("06e", ["n"])
handle_query("06f", ["mk", "ci"])
handle_query("07a", ["n", "ml", "lt", "t"])
handle_query("07b", ["an", "n", "ml", "lt", "t"])
handle_query("07c", ["n", "pi", "ci", "ml", "t"])
handle_query("08a", ["mc", "cn", "n1", "t"])
handle_query("08b", ["t", "mc"])
handle_query("08c", ["ci", "a1", "n1", "t"])
handle_query("08d", ["ci", "an1", "n1", "t"])
handle_query("09a", ["t", "ci", "n", "an"])
handle_query("09b", ["n", "mc", "cn", "t"])
handle_query("09c", ["ci", "n", "an", "t"])
handle_query("09d", ["ci", "n", "an", "t"])
handle_query("10a", ["t", "ci"])
handle_query("10b", ["t", "ci"])
handle_query("10c", ["t", "ci"])
handle_query("11a", ["lt", "mc", "cn", "t"])
handle_query("11b", ["k"])
handle_query("11c", ["mc", "t", "mk", "k"])
handle_query("11d", ["t", "mc", "cn", "mk", "k"])
handle_query("12a", ["t", "mc", "mi"])
handle_query("12b", ["t", "mi_idx"])
handle_query("12c", ["t", "mc", "mi"])
handle_query("13a", ["miidx", "t", "mi"])
handle_query("13b", ["miidx", "t", "mi"])
handle_query("13c", ["t"])
handle_query("13d", ["miidx", "t", "mi"])
handle_query("14a", ["t", "mi", "mk", "k"])
handle_query("14b", ["t"])
handle_query("14c", ["t", "mi", "mk", "k"])
handle_query("15a", ["at", "t", "mi", "mk", "k"])
handle_query("15b", ["at"])
handle_query("15c", ["at", "t", "mi", "mk", "k"])
handle_query("15d", ["at", "t", "mi", "mk", "k"])
handle_query("16a", ["t", "mc", "cn", "an", "n"])
handle_query("16b", ["mc", "cn", "ci", "an", "n", "t"])
handle_query("16c", ["t", "mc", "cn", "ci", "an", "n"])
handle_query("16d", ["t", "mc", "cn", "ci", "an", "n"])
handle_query("17a", ["mc", "cn", "ci", "n", "t"])
handle_query("17b", ["mc", "cn", "ci", "n", "t"])
handle_query("17c", ["ci", "n", "mc", "cn", "t"])
handle_query("17d", ["ci", "n", "mc", "cn", "t"])
handle_query("17e", ["ci", "n", "mc", "cn", "t"])
handle_query("17f", ["ci", "n", "mc", "cn", "t"])
handle_query("18a", ["ci", "n", "mi", "t"])
handle_query("18b", ["ci", "n", "mi", "t"])
handle_query("18c", ["ci", "n", "mi", "t"])
handle_query("19a", ["ci", "n", "mi", "t", "an"])
handle_query("19b", ["t"])
handle_query("19c", ["t", "mi", "ci", "n", "an"])
handle_query("19d", ["t", "ci", "an", "n", "mi"])
handle_query("20a", ["t", "mk", "k", "ci"])
handle_query("20b", ["t", "mk", "k", "ci", "n"])
handle_query("20c", ["t", "mk", "k", "ci", "n"])
handle_query("21a", ["lt", "mc", "cn", "t", "mi"])
handle_query("21b", ["lt", "mc", "cn", "t"])
handle_query("21c", ["lt", "mc", "cn", "t", "mi"])
handle_query("22a", ["t", "mc", "cn", "mi", "mk", "k"])
handle_query("22b", ["t", "mc", "cn", "mi", "mk", "k"])
handle_query("22c", ["t", "mc", "cn", "mi", "mk", "k"])
handle_query("22d", ["t", "mc", "cn", "mi", "mk", "k"])
handle_query("23a", ["cc", "t", "mi", "k"])
handle_query("23b", ["cc", "k"])
handle_query("23c", ["cc", "t", "mi", "k"])
handle_query("24a", ["t", "mi", "mk", "k", "ci", "n", "an"])
handle_query("24b", ["t"])
handle_query("25a", ["mi_idx", "it2", "mk", "k", "t", "ci", "n"])
handle_query("25b", ["t"])
handle_query("25c", ["mi", "mk", "k", "t", "ci", "n"])
handle_query("26a", ["cc", "t", "mk", "k", "ci", "n"])
handle_query("26b", ["cc", "t", "k", "n"])
handle_query("26c", ["cc", "t", "mk", "k", "ci", "n"])
handle_query("27a", ["cc", "lt", "t", "mc", "cn", "mi"])
handle_query("27b", ["cc", "cn"])
handle_query("27c", ["cc", "lt", "t", "mc", "cn", "mi"])
handle_query("28a", ["cc", "t", "mc", "cn", "mi", "it1", "mk", "k"])
handle_query("28b", ["cc", "t", "mc", "cn", "mi", "mk", "k"])
handle_query("28c", ["cc", "t", "mc", "cn", "mi", "it1", "mk", "k"])
handle_query("29a", ["k", "it3"])
handle_query("29b", ["k", "it3"])
handle_query("29c", ["cc", "t", "cn", "mi", "ci", "n", "an", "pi", "it", "it3"])   # it's also not clear which info_type is used
handle_query("30a", ["cc", "t", "mi", "mk", "k", "ci", "n"])
handle_query("30b", ["t", "k"])
handle_query("30c", ["cc", "t", "mi", "mk", "k", "ci", "n"])
handle_query("31a", ["mc", "mi", "mk", "k", "t", "ci", "n"])
handle_query("31b", ["t", "k", "n"])
handle_query("31c", ["mc", "mi", "mk", "k", "t", "ci", "n"])
handle_query("32a", [])
handle_query("32b", ["ml", "lt", "t1", "t2"])
handle_query("33a", ["mi_idx2"])
handle_query("33b", ["ml", "mi_idx2", "kt1", "kt2", "lt"])  # it's not 100% clear which kind_type table is used. both have the same filters
handle_query("33c", ["mi_idx2", "cn1", "cn2"])