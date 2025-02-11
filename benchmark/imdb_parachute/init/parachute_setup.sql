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



-------------
-- 2a
-------------
ALTER TABLE movie_companies ADD COLUMN IF NOT EXISTS optimal_parachute_q2a_company_name BOOLEAN DEFAULT false;
UPDATE movie_companies mc
SET optimal_parachute_q2a_company_name = true
FROM company_name cn
WHERE cn.id = mc.company_id -- join condition
  -- Predicate from the probe side
  AND (
    cn.country_code ='[de]'
);

-------------
-- 2b
-------------
ALTER TABLE movie_companies ADD COLUMN IF NOT EXISTS optimal_parachute_q2b_company_name BOOLEAN DEFAULT false;
UPDATE movie_companies mc
SET optimal_parachute_q2b_company_name = true
FROM company_name cn
WHERE cn.id = mc.company_id -- join condition
  -- Predicate from the probe side
  AND (
    cn.country_code ='[nl]'
);

-------------
-- 2c
-------------
ALTER TABLE movie_companies ADD COLUMN IF NOT EXISTS optimal_parachute_q2c_company_name BOOLEAN DEFAULT false;
UPDATE movie_companies mc
SET optimal_parachute_q2c_company_name = true
FROM company_name cn
WHERE cn.id = mc.company_id -- join condition
  -- Predicate from the probe side
  AND (
    cn.country_code ='[sm]'
);

-------------
-- 2d
-------------
ALTER TABLE movie_companies ADD COLUMN IF NOT EXISTS optimal_parachute_q2d_company_name BOOLEAN DEFAULT false;
UPDATE movie_companies mc
SET optimal_parachute_q2d_company_name = true
FROM company_name cn
WHERE cn.id = mc.company_id -- join condition
  -- Predicate from the probe side
  AND (
    cn.country_code ='[us]'
);

-------------
-- 3a
-------------
ALTER TABLE movie_keyword ADD COLUMN IF NOT EXISTS optimal_parachute_q3a_movie_info BOOLEAN DEFAULT false;
UPDATE movie_keyword mk
SET optimal_parachute_q3a_movie_info = true
FROM movie_info mi
WHERE mk.movie_id = mi.movie_id -- join condition
  -- Predicate from the probe side
  AND (
    mi.info IN ('Sweden',
                  'Norway',
                  'Germany',
                  'Denmark',
                  'Swedish',
                  'Denish',
                  'Norwegian',
                  'German')
);

ALTER TABLE title ADD COLUMN IF NOT EXISTS optimal_parachute_q3a_movie_info BOOLEAN DEFAULT false;
UPDATE title t
SET optimal_parachute_q3a_movie_info = true
FROM movie_info mi
WHERE t.id = mi.movie_id -- join condition
  -- Predicate from the probe side
  AND (
    mi.info IN ('Sweden',
                  'Norway',
                  'Germany',
                  'Denmark',
                  'Swedish',
                  'Denish',
                  'Norwegian',
                  'German')
);


-------------
-- 3b
-------------
ALTER TABLE movie_keyword ADD COLUMN IF NOT EXISTS optimal_parachute_q3b_title BOOLEAN DEFAULT false;
UPDATE movie_keyword mk
SET optimal_parachute_q3b_title = true
FROM title t
WHERE t.id = mk.movie_id -- join condition
  -- Predicate from the probe side
  AND (
    t.production_year > 2010
);

ALTER TABLE movie_info ADD COLUMN IF NOT EXISTS optimal_parachute_q3b_title BOOLEAN DEFAULT false;
UPDATE movie_info mi
SET optimal_parachute_q3b_title = true
FROM title t
WHERE t.id = mi.movie_id -- join condition
  -- Predicate from the probe side
  AND (
    t.production_year > 2010
);

ALTER TABLE movie_keyword ADD COLUMN IF NOT EXISTS optimal_parachute_q3b_keyword BOOLEAN DEFAULT false;
UPDATE movie_keyword mk
SET optimal_parachute_q3b_keyword = true
FROM keyword k
WHERE k.id = mk.keyword_id -- join condition
  -- Predicate from the probe side
  AND (
    k.keyword like '%sequel%'
);

-------------
-- 3c
-------------
ALTER TABLE movie_keyword ADD COLUMN IF NOT EXISTS optimal_parachute_q3c_keyword BOOLEAN DEFAULT false;
UPDATE movie_keyword mk
SET optimal_parachute_q3c_keyword = true
FROM keyword k
WHERE k.id = mk.keyword_id -- join condition
  -- Predicate from the probe side
  AND (
    k.keyword like '%sequel%'
);

ALTER TABLE movie_keyword ADD COLUMN IF NOT EXISTS optimal_parachute_q3c_movie_info BOOLEAN DEFAULT false;
UPDATE movie_keyword mk
SET optimal_parachute_q3c_movie_info = true
FROM movie_info mi
WHERE mk.movie_id = mi.movie_id -- join condition
  -- Predicate from the probe side
  AND (
    mi.info IN ('Sweden',
                  'Norway',
                  'Germany',
                  'Denmark',
                  'Swedish',
                  'Denish',
                  'Norwegian',
                  'German',
                  'USA',
                  'American')
);

ALTER TABLE title ADD COLUMN IF NOT EXISTS optimal_parachute_q3c_movie_info BOOLEAN DEFAULT false;
UPDATE title t
SET optimal_parachute_q3c_movie_info = true
FROM movie_info mi
WHERE t.id = mi.movie_id -- join condition
  -- Predicate from the probe side
  AND (
    mi.info IN ('Sweden',
                  'Norway',
                  'Germany',
                  'Denmark',
                  'Swedish',
                  'Denish',
                  'Norwegian',
                  'German',
                  'USA',
                  'American')
);


-------------
-- 4a
-------------
ALTER TABLE movie_keyword ADD COLUMN IF NOT EXISTS optimal_parachute_q4a_keyword BOOLEAN DEFAULT false;
UPDATE movie_keyword mk
SET optimal_parachute_q4a_keyword = true
FROM keyword k
WHERE k.id = mk.keyword_id -- join condition
  -- Predicate from the probe side
  AND (
    k.keyword like '%sequel%'
);

ALTER TABLE movie_keyword ADD COLUMN IF NOT EXISTS optimal_parachute_q4a_title BOOLEAN DEFAULT false;
UPDATE movie_keyword mk
SET optimal_parachute_q4a_title = true
FROM title t
WHERE t.id = mk.movie_id -- join condition
  -- Predicate from the probe side
  AND (
    t.production_year > 2005
);

ALTER TABLE movie_info_idx ADD COLUMN IF NOT EXISTS optimal_parachute_q4a_title BOOLEAN DEFAULT false;
UPDATE movie_info_idx mi_idx
SET optimal_parachute_q4a_title = true
FROM title t
WHERE t.id = mi_idx.movie_id -- join condition
  -- Predicate from the probe side
  AND (
    t.production_year > 2005
);

-------------
-- 4b
-------------
ALTER TABLE movie_info_idx ADD COLUMN IF NOT EXISTS optimal_parachute_q4b_title BOOLEAN DEFAULT false;
UPDATE movie_info_idx mi_idx
SET optimal_parachute_q4b_title = true
FROM title t
WHERE t.id = mi_idx.movie_id -- join condition
  -- Predicate from the probe side
  AND (
    t.production_year > 2010
);

ALTER TABLE movie_keyword ADD COLUMN IF NOT EXISTS optimal_parachute_q4b_title BOOLEAN DEFAULT false;
UPDATE movie_keyword mk
SET optimal_parachute_q4b_title = true
FROM title t
WHERE t.id = mk.movie_id -- join condition
  -- Predicate from the probe side
  AND (
    t.production_year > 2010
);

ALTER TABLE movie_keyword ADD COLUMN IF NOT EXISTS optimal_parachute_q4b_keyword BOOLEAN DEFAULT false;
UPDATE movie_keyword mk
SET optimal_parachute_q4b_keyword = true
FROM keyword k
WHERE k.id = mk.keyword_id -- join condition
  -- Predicate from the probe side
  AND (
    k.keyword like '%sequel%'
);

-------------
-- 4c
-------------
ALTER TABLE movie_keyword ADD COLUMN IF NOT EXISTS optimal_parachute_q4c_keyword BOOLEAN DEFAULT false;
UPDATE movie_keyword mk
SET optimal_parachute_q4c_keyword = true
FROM keyword k
WHERE k.id = mk.keyword_id -- join condition
  -- Predicate from the probe side
  AND (
    k.keyword like '%sequel%'
);

ALTER TABLE movie_keyword ADD COLUMN IF NOT EXISTS optimal_parachute_q4c_title BOOLEAN DEFAULT false;
UPDATE movie_keyword mk
SET optimal_parachute_q4c_title = true
FROM title t
WHERE t.id = mk.movie_id -- join condition
  -- Predicate from the probe side
  AND (
    t.production_year > 1990
);

ALTER TABLE movie_info_idx ADD COLUMN IF NOT EXISTS optimal_parachute_q4c_title BOOLEAN DEFAULT false;
UPDATE movie_info_idx mi_idx
SET optimal_parachute_q4c_title = true
FROM title t
WHERE t.id = mi_idx.movie_id -- join condition
  -- Predicate from the probe side
  AND (
    t.production_year > 1990
);


-------------
-- 5a
-------------
ALTER TABLE movie_info ADD COLUMN IF NOT EXISTS optimal_parachute_q5a_title BOOLEAN DEFAULT false;
UPDATE movie_info mi
SET optimal_parachute_q5a_title = true
FROM title t
WHERE t.id = mi.movie_id -- join condition
  -- Predicate from the probe side
  AND (
    t.production_year > 2005
);

ALTER TABLE movie_companies ADD COLUMN IF NOT EXISTS optimal_parachute_q5a_title BOOLEAN DEFAULT false;
UPDATE movie_companies mc
SET optimal_parachute_q5a_title = true
FROM title t
WHERE t.id = mc.movie_id -- join condition
  -- Predicate from the probe side
  AND (
    t.production_year > 2005
);


-------------
-- 5b
-------------
ALTER TABLE movie_info ADD COLUMN IF NOT EXISTS optimal_parachute_q5b_title BOOLEAN DEFAULT false;
UPDATE movie_info mi
SET optimal_parachute_q5b_title = true
FROM title t
WHERE t.id = mi.movie_id -- join condition
  -- Predicate from the probe side
  AND (
    t.production_year > 2005
);

ALTER TABLE movie_companies ADD COLUMN IF NOT EXISTS optimal_parachute_q5b_title BOOLEAN DEFAULT false;
UPDATE movie_companies mc
SET optimal_parachute_q5b_title = true
FROM title t
WHERE t.id = mc.movie_id -- join condition
  -- Predicate from the probe side
  AND (
    t.production_year > 2010
);


-------------
-- 5c
-------------
ALTER TABLE movie_info ADD COLUMN IF NOT EXISTS optimal_parachute_q5c_title BOOLEAN DEFAULT false;
UPDATE movie_info mi
SET optimal_parachute_q5c_title = true
FROM title t
WHERE t.id = mi.movie_id -- join condition
  -- Predicate from the probe side
  AND (
    t.production_year > 1990
);

ALTER TABLE movie_companies ADD COLUMN IF NOT EXISTS optimal_parachute_q5c_title BOOLEAN DEFAULT false;
UPDATE movie_companies mc
SET optimal_parachute_q5c_title = true
FROM title t
WHERE t.id = mc.movie_id -- join condition
  -- Predicate from the probe side
  AND (
    t.production_year > 1990
);

ALTER TABLE movie_companies ADD COLUMN IF NOT EXISTS optimal_parachute_q5c_movie_info BOOLEAN DEFAULT false;
UPDATE movie_companies mc
SET optimal_parachute_q5c_movie_info = true
FROM movie_info mi
WHERE mc.movie_id = mi.movie_id -- join condition
  -- Predicate from the probe side
  AND (
    mi.info IN ('Sweden',
                  'Norway',
                  'Germany',
                  'Denmark',
                  'Swedish',
                  'Denish',
                  'Norwegian',
                  'German',
                  'USA',
                  'American')
);

-------------
-- 6a
-------------
ALTER TABLE cast_info ADD COLUMN IF NOT EXISTS optimal_parachute_q6a_name BOOLEAN DEFAULT false;
UPDATE cast_info ci
SET optimal_parachute_q6a_name = true
FROM name n
WHERE n.id = ci.person_id -- join condition
  -- Predicate from the probe side
  AND (
    n.name LIKE '%Downey%Robert%'
);

-------------
-- 6e
-------------
ALTER TABLE cast_info ADD COLUMN IF NOT EXISTS optimal_parachute_q6e_name BOOLEAN DEFAULT false;
UPDATE cast_info ci
SET optimal_parachute_q6e_name = true
FROM name n
WHERE n.id = ci.person_id -- join condition
  -- Predicate from the probe side
  AND (
    n.name LIKE '%Downey%Robert%'
);

-------------
-- 7a
-------------
ALTER TABLE aka_name ADD COLUMN IF NOT EXISTS optimal_parachute_q7a_name BOOLEAN DEFAULT false;
UPDATE aka_name an
SET optimal_parachute_q7a_name = true
FROM name n
WHERE n.id = an.person_id -- join condition
  -- Predicate from the probe side
  AND (
    n.name_pcode_cf BETWEEN 'A' AND 'F'
  AND (n.gender='m'
       OR (n.gender = 'f'
           AND n.name LIKE 'B%'))
);

ALTER TABLE person_info ADD COLUMN IF NOT EXISTS optimal_parachute_q7a_name BOOLEAN DEFAULT false;
UPDATE person_info pi
SET optimal_parachute_q7a_name = true
FROM name n
WHERE n.id = pi.person_id -- join condition
  -- Predicate from the probe side
  AND (
    n.name_pcode_cf BETWEEN 'A' AND 'F'
  AND (n.gender='m'
       OR (n.gender = 'f'
           AND n.name LIKE 'B%'))
);

ALTER TABLE movie_link ADD COLUMN IF NOT EXISTS optimal_parachute_q7a_link_type BOOLEAN DEFAULT false;
UPDATE movie_link ml
SET optimal_parachute_q7a_link_type = true
FROM link_type lt
WHERE lt.id = ml.link_type_id -- join condition
  -- Predicate from the probe side
  AND (
    lt.link ='features'
);

ALTER TABLE movie_link ADD COLUMN IF NOT EXISTS optimal_parachute_q7a_title BOOLEAN DEFAULT false;
UPDATE movie_link ml
SET optimal_parachute_q7a_title = true
FROM title t
WHERE ml.linked_movie_id = t.id -- join condition
  -- Predicate from the probe side
  AND (
    t.production_year BETWEEN 1980 AND 1995
);

ALTER TABLE cast_info ADD COLUMN IF NOT EXISTS optimal_parachute_q7a_title BOOLEAN DEFAULT false;
UPDATE cast_info ci
SET optimal_parachute_q7a_title = true
FROM title t
WHERE t.id = ci.movie_id -- join condition
  -- Predicate from the probe side
  AND (
    t.production_year BETWEEN 1980 AND 1995
);


-------------
-- 7b
-------------
ALTER TABLE name ADD COLUMN IF NOT EXISTS optimal_parachute_q7b_aka_name BOOLEAN DEFAULT false;
UPDATE name n
SET optimal_parachute_q7b_aka_name = true
FROM aka_name an
WHERE n.id = an.person_id -- join condition
  -- Predicate from the probe side
  AND (
    an.name LIKE '%a%'
);

ALTER TABLE person_info ADD COLUMN IF NOT EXISTS optimal_parachute_q7b_aka_name BOOLEAN DEFAULT false;
UPDATE person_info pi
SET optimal_parachute_q7b_aka_name = true
FROM aka_name an
WHERE pi.person_id = an.person_id -- join condition
  -- Predicate from the probe side
  AND (
    an.name LIKE '%a%'
);

ALTER TABLE cast_info ADD COLUMN IF NOT EXISTS optimal_parachute_q7b_aka_name BOOLEAN DEFAULT false;
UPDATE cast_info ci
SET optimal_parachute_q7b_aka_name = true
FROM aka_name an
WHERE an.person_id = ci.person_id -- join condition
  -- Predicate from the probe side
  AND (
    an.name LIKE '%a%'
);

ALTER TABLE aka_name ADD COLUMN IF NOT EXISTS optimal_parachute_q7b_name BOOLEAN DEFAULT false;
UPDATE aka_name an
SET optimal_parachute_q7b_name = true
FROM name n
WHERE n.id = an.person_id -- join condition
  -- Predicate from the probe side
  AND (
    n.name_pcode_cf LIKE 'D%'
    AND n.gender='m'
);

ALTER TABLE person_info ADD COLUMN IF NOT EXISTS optimal_parachute_q7b_name BOOLEAN DEFAULT false;
UPDATE person_info pi
SET optimal_parachute_q7b_name = true
FROM name n
WHERE n.id = pi.person_id -- join condition
  -- Predicate from the probe side
  AND (
    n.name_pcode_cf LIKE 'D%'
    AND n.gender='m'
);

ALTER TABLE cast_info ADD COLUMN IF NOT EXISTS optimal_parachute_q7b_name BOOLEAN DEFAULT false;
UPDATE cast_info ci
SET optimal_parachute_q7b_name = true
FROM name n
WHERE ci.person_id = n.id -- join condition
  -- Predicate from the probe side
  AND (
    n.name_pcode_cf LIKE 'D%'
    AND n.gender='m'
);

ALTER TABLE movie_link ADD COLUMN IF NOT EXISTS optimal_parachute_q7b_link_type BOOLEAN DEFAULT false;
UPDATE movie_link ml
SET optimal_parachute_q7b_link_type = true
FROM link_type lt
WHERE lt.id = ml.link_type_id -- join condition
  -- Predicate from the probe side
  AND (
    lt.link ='features'
);

ALTER TABLE cast_info ADD COLUMN IF NOT EXISTS optimal_parachute_q7b_title BOOLEAN DEFAULT false;
UPDATE cast_info ci
SET optimal_parachute_q7b_title = true
FROM title t
WHERE t.id = ci.movie_id -- join condition
  -- Predicate from the probe side
  AND (
    t.production_year BETWEEN 1980 AND 1984
);

ALTER TABLE movie_link ADD COLUMN IF NOT EXISTS optimal_parachute_q7b_title BOOLEAN DEFAULT false;
UPDATE movie_link ml
SET optimal_parachute_q7b_title = true
FROM title t
WHERE ml.linked_movie_id = t.id -- join condition
  -- Predicate from the probe side
  AND (
    t.production_year BETWEEN 1980 AND 1984
);


-------------
-- 7c
-------------
ALTER TABLE aka_name ADD COLUMN IF NOT EXISTS optimal_parachute_q7c_name BOOLEAN DEFAULT false;
UPDATE aka_name an
SET optimal_parachute_q7c_name = true
FROM name n
WHERE n.id = an.person_id -- join condition
  -- Predicate from the probe side
  AND (
    n.name_pcode_cf BETWEEN 'A' AND 'F'
  AND (n.gender='m'
       OR (n.gender = 'f'
           AND n.name LIKE 'A%'))
);

ALTER TABLE person_info ADD COLUMN IF NOT EXISTS optimal_parachute_q7c_name BOOLEAN DEFAULT false;
UPDATE person_info pi
SET optimal_parachute_q7c_name = true
FROM name n
WHERE n.id = pi.person_id -- join condition
  -- Predicate from the probe side
  AND (
    n.name_pcode_cf BETWEEN 'A' AND 'F'
  AND (n.gender='m'
       OR (n.gender = 'f'
           AND n.name LIKE 'A%'))
);

ALTER TABLE cast_info ADD COLUMN IF NOT EXISTS optimal_parachute_q7c_name BOOLEAN DEFAULT false;
UPDATE cast_info ci
SET optimal_parachute_q7c_name = true
FROM name n
WHERE ci.person_id = n.id -- join condition
  -- Predicate from the probe side
  AND (
    n.name_pcode_cf BETWEEN 'A' AND 'F'
  AND (n.gender='m'
       OR (n.gender = 'f'
           AND n.name LIKE 'A%'))
);

ALTER TABLE name ADD COLUMN IF NOT EXISTS optimal_parachute_q7c_person_info BOOLEAN DEFAULT false;
UPDATE name n
SET optimal_parachute_q7c_person_info = true
FROM person_info pi
WHERE n.id = pi.person_id -- join condition
  -- Predicate from the probe side
  AND (
    pi.note IS NOT NULL
);

ALTER TABLE info_type ADD COLUMN IF NOT EXISTS optimal_parachute_q7c_person_info BOOLEAN DEFAULT false;
UPDATE info_type it
SET optimal_parachute_q7c_person_info = true
FROM person_info pi
WHERE it.id = pi.info_type_id -- join condition
  -- Predicate from the probe side
  AND (
    pi.note IS NOT NULL
);

ALTER TABLE aka_name ADD COLUMN IF NOT EXISTS optimal_parachute_q7c_person_info BOOLEAN DEFAULT false;
UPDATE aka_name an
SET optimal_parachute_q7c_person_info = true
FROM person_info pi
WHERE pi.person_id = an.person_id -- join condition
  -- Predicate from the probe side
  AND (
    pi.note IS NOT NULL
);

ALTER TABLE cast_info ADD COLUMN IF NOT EXISTS optimal_parachute_q7c_person_info BOOLEAN DEFAULT false;
UPDATE cast_info ci
SET optimal_parachute_q7c_person_info = true
FROM person_info pi
WHERE pi.person_id = ci.person_id -- join condition
  -- Predicate from the probe side
  AND (
    pi.note IS NOT NULL
);

ALTER TABLE cast_info ADD COLUMN IF NOT EXISTS optimal_parachute_q7c_title BOOLEAN DEFAULT false;
UPDATE cast_info ci
SET optimal_parachute_q7c_title = true
FROM title t
WHERE t.id = ci.movie_id -- join condition
  -- Predicate from the probe side
  AND (
    t.production_year BETWEEN 1980 AND 2010
);

ALTER TABLE movie_link ADD COLUMN IF NOT EXISTS optimal_parachute_q7c_title BOOLEAN DEFAULT false;
UPDATE movie_link ml
SET optimal_parachute_q7c_title = true
FROM title t
WHERE ml.linked_movie_id = t.id -- join condition
  -- Predicate from the probe side
  AND (
    t.production_year BETWEEN 1980 AND 2010
);


-------------
-- 8a
-------------
ALTER TABLE title ADD COLUMN IF NOT EXISTS optimal_parachute_q8a_movie_companies BOOLEAN DEFAULT false;
UPDATE title t
SET optimal_parachute_q8a_movie_companies = true
FROM movie_companies mc
WHERE t.id = mc.movie_id -- join condition
  -- Predicate from the probe side
  AND (
    mc.note like '%(Japan)%'
    AND mc.note not like '%(USA)%'
);

ALTER TABLE company_name ADD COLUMN IF NOT EXISTS optimal_parachute_q8a_movie_companies BOOLEAN DEFAULT false;
UPDATE company_name cn
SET optimal_parachute_q8a_movie_companies = true
FROM movie_companies mc
WHERE mc.company_id = cn.id -- join condition
  -- Predicate from the probe side
  AND (
    mc.note like '%(Japan)%'
    AND mc.note not like '%(USA)%'
);

ALTER TABLE cast_info ADD COLUMN IF NOT EXISTS optimal_parachute_q8a_movie_companies BOOLEAN DEFAULT false;
UPDATE cast_info ci
SET optimal_parachute_q8a_movie_companies = true
FROM movie_companies mc
WHERE ci.movie_id = mc.movie_id -- join condition
  -- Predicate from the probe side
  AND (
    mc.note like '%(Japan)%'
    AND mc.note not like '%(USA)%'
);

ALTER TABLE movie_companies ADD COLUMN IF NOT EXISTS optimal_parachute_q8a_company_name BOOLEAN DEFAULT false;
UPDATE movie_companies mc
SET optimal_parachute_q8a_company_name = true
FROM company_name cn
WHERE mc.company_id = cn.id -- join condition
  -- Predicate from the probe side
  AND (
    cn.country_code ='[jp]'
);

ALTER TABLE aka_name ADD COLUMN IF NOT EXISTS optimal_parachute_q8a_name BOOLEAN DEFAULT false;
UPDATE aka_name an1
SET optimal_parachute_q8a_name = true
FROM name n1
WHERE an1.person_id = n1.id -- join condition
  -- Predicate from the probe side
  AND (
    n1.name like '%Yo%'
    AND n1.name not like '%Yu%'
);

ALTER TABLE cast_info ADD COLUMN IF NOT EXISTS optimal_parachute_q8a_name BOOLEAN DEFAULT false;
UPDATE cast_info ci
SET optimal_parachute_q8a_name = true
FROM name n1
WHERE n1.id = ci.person_id -- join condition
  -- Predicate from the probe side
  AND (
    n1.name like '%Yo%'
    AND n1.name not like '%Yu%'
);


-------------
-- 8b
-------------
ALTER TABLE cast_info ADD COLUMN IF NOT EXISTS optimal_parachute_q8b_title BOOLEAN DEFAULT false;
UPDATE cast_info ci
SET optimal_parachute_q8b_title = true
FROM title t
WHERE ci.movie_id = t.id -- join condition
  -- Predicate from the probe side
  AND (
    t.production_year BETWEEN 2006 AND 2007
    AND (t.title like 'One Piece%'
       OR t.title like 'Dragon Ball Z%')
);

ALTER TABLE movie_companies ADD COLUMN IF NOT EXISTS optimal_parachute_q8b_title BOOLEAN DEFAULT false;
UPDATE movie_companies mc
SET optimal_parachute_q8b_title = true
FROM title t
WHERE t.id = mc.movie_id -- join condition
  -- Predicate from the probe side
  AND (
    t.production_year BETWEEN 2006 AND 2007
    AND (t.title like 'One Piece%'
       OR t.title like 'Dragon Ball Z%')
);

ALTER TABLE title ADD COLUMN IF NOT EXISTS optimal_parachute_q8b_movie_companies BOOLEAN DEFAULT false;
UPDATE title t
SET optimal_parachute_q8b_movie_companies = true
FROM movie_companies mc
WHERE t.id = mc.movie_id -- join condition
  -- Predicate from the probe side
  AND (
    mc.note like '%(Japan)%'
    AND mc.note not like '%(USA)%'
    AND (mc.note like '%(2006)%'
       OR mc.note like '%(2007)%')
);

ALTER TABLE company_name ADD COLUMN IF NOT EXISTS optimal_parachute_q8b_movie_companies BOOLEAN DEFAULT false;
UPDATE company_name cn
SET optimal_parachute_q8b_movie_companies = true
FROM movie_companies mc
WHERE mc.company_id = cn.id -- join condition
  -- Predicate from the probe side
  AND (
    mc.note like '%(Japan)%'
    AND mc.note not like '%(USA)%'
    AND (mc.note like '%(2006)%'
       OR mc.note like '%(2007)%')
);

ALTER TABLE cast_info ADD COLUMN IF NOT EXISTS optimal_parachute_q8b_movie_companies BOOLEAN DEFAULT false;
UPDATE cast_info ci
SET optimal_parachute_q8b_movie_companies = true
FROM movie_companies mc
WHERE mc.company_id = cn.id -- join condition
  -- Predicate from the probe side
  AND (
    mc.note like '%(Japan)%'
    AND mc.note not like '%(USA)%'
    AND (mc.note like '%(2006)%'
       OR mc.note like '%(2007)%')
);