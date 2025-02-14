
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
-- 01a
-------------

                
-------------
-- 01b
-------------

                
-------------
-- 01c
-------------

                
-------------
-- 01d
-------------

                
-------------
-- 02a
-------------

ALTER TABLE movie_companies ADD COLUMN IF NOT EXISTS optimal_parachute_q02a_company_name BOOLEAN DEFAULT false;
UPDATE movie_companies mc
SET optimal_parachute_q02a_company_name = true
FROM company_name cn
WHERE cn.id = mc.company_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    cn.country_code ='[de]'
);

                
-------------
-- 02b
-------------

ALTER TABLE movie_companies ADD COLUMN IF NOT EXISTS optimal_parachute_q02b_company_name BOOLEAN DEFAULT false;
UPDATE movie_companies mc
SET optimal_parachute_q02b_company_name = true
FROM company_name cn
WHERE cn.id = mc.company_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    cn.country_code ='[nl]'
);

                
-------------
-- 02c
-------------

ALTER TABLE movie_companies ADD COLUMN IF NOT EXISTS optimal_parachute_q02c_company_name BOOLEAN DEFAULT false;
UPDATE movie_companies mc
SET optimal_parachute_q02c_company_name = true
FROM company_name cn
WHERE cn.id = mc.company_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    cn.country_code ='[sm]'
);

                
-------------
-- 02d
-------------

ALTER TABLE movie_companies ADD COLUMN IF NOT EXISTS optimal_parachute_q02d_company_name BOOLEAN DEFAULT false;
UPDATE movie_companies mc
SET optimal_parachute_q02d_company_name = true
FROM company_name cn
WHERE cn.id = mc.company_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    cn.country_code ='[us]'
);

                
-------------
-- 03a
-------------

                
-------------
-- 03b
-------------

ALTER TABLE movie_info ADD COLUMN IF NOT EXISTS optimal_parachute_q03b_title BOOLEAN DEFAULT false;
UPDATE movie_info mi
SET optimal_parachute_q03b_title = true
FROM title t
WHERE t.id = mi.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2010
);

ALTER TABLE movie_keyword ADD COLUMN IF NOT EXISTS optimal_parachute_q03b_title BOOLEAN DEFAULT false;
UPDATE movie_keyword mk
SET optimal_parachute_q03b_title = true
FROM title t
WHERE t.id = mk.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2010
);

ALTER TABLE movie_keyword ADD COLUMN IF NOT EXISTS optimal_parachute_q03b_keyword BOOLEAN DEFAULT false;
UPDATE movie_keyword mk
SET optimal_parachute_q03b_keyword = true
FROM keyword k
WHERE k.id = mk.keyword_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    k.keyword LIKE '%sequel%'
);

                
-------------
-- 03c
-------------

                
-------------
-- 04a
-------------

ALTER TABLE movie_info_idx ADD COLUMN IF NOT EXISTS optimal_parachute_q04a_title BOOLEAN DEFAULT false;
UPDATE movie_info_idx mi_idx
SET optimal_parachute_q04a_title = true
FROM title t
WHERE t.id = mi_idx.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2005
);

ALTER TABLE movie_keyword ADD COLUMN IF NOT EXISTS optimal_parachute_q04a_title BOOLEAN DEFAULT false;
UPDATE movie_keyword mk
SET optimal_parachute_q04a_title = true
FROM title t
WHERE t.id = mk.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2005
);

ALTER TABLE movie_keyword ADD COLUMN IF NOT EXISTS optimal_parachute_q04a_keyword BOOLEAN DEFAULT false;
UPDATE movie_keyword mk
SET optimal_parachute_q04a_keyword = true
FROM keyword k
WHERE k.id = mk.keyword_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    k.keyword LIKE '%sequel%'
);

                
-------------
-- 04b
-------------

ALTER TABLE movie_info_idx ADD COLUMN IF NOT EXISTS optimal_parachute_q04b_title BOOLEAN DEFAULT false;
UPDATE movie_info_idx mi_idx
SET optimal_parachute_q04b_title = true
FROM title t
WHERE t.id = mi_idx.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2010
);

ALTER TABLE movie_keyword ADD COLUMN IF NOT EXISTS optimal_parachute_q04b_title BOOLEAN DEFAULT false;
UPDATE movie_keyword mk
SET optimal_parachute_q04b_title = true
FROM title t
WHERE t.id = mk.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2010
);

ALTER TABLE movie_keyword ADD COLUMN IF NOT EXISTS optimal_parachute_q04b_keyword BOOLEAN DEFAULT false;
UPDATE movie_keyword mk
SET optimal_parachute_q04b_keyword = true
FROM keyword k
WHERE k.id = mk.keyword_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    k.keyword LIKE '%sequel%'
);

                
-------------
-- 04c
-------------

ALTER TABLE movie_info_idx ADD COLUMN IF NOT EXISTS optimal_parachute_q04c_title BOOLEAN DEFAULT false;
UPDATE movie_info_idx mi_idx
SET optimal_parachute_q04c_title = true
FROM title t
WHERE t.id = mi_idx.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 1990
);

ALTER TABLE movie_keyword ADD COLUMN IF NOT EXISTS optimal_parachute_q04c_title BOOLEAN DEFAULT false;
UPDATE movie_keyword mk
SET optimal_parachute_q04c_title = true
FROM title t
WHERE t.id = mk.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 1990
);

ALTER TABLE movie_keyword ADD COLUMN IF NOT EXISTS optimal_parachute_q04c_keyword BOOLEAN DEFAULT false;
UPDATE movie_keyword mk
SET optimal_parachute_q04c_keyword = true
FROM keyword k
WHERE k.id = mk.keyword_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    k.keyword LIKE '%sequel%'
);

                
-------------
-- 05a
-------------

ALTER TABLE movie_info ADD COLUMN IF NOT EXISTS optimal_parachute_q05a_title BOOLEAN DEFAULT false;
UPDATE movie_info mi
SET optimal_parachute_q05a_title = true
FROM title t
WHERE t.id = mi.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2005
);

ALTER TABLE movie_companies ADD COLUMN IF NOT EXISTS optimal_parachute_q05a_title BOOLEAN DEFAULT false;
UPDATE movie_companies mc
SET optimal_parachute_q05a_title = true
FROM title t
WHERE t.id = mc.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2005
);

                
-------------
-- 05b
-------------

ALTER TABLE movie_info ADD COLUMN IF NOT EXISTS optimal_parachute_q05b_title BOOLEAN DEFAULT false;
UPDATE movie_info mi
SET optimal_parachute_q05b_title = true
FROM title t
WHERE t.id = mi.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2010
);

ALTER TABLE movie_companies ADD COLUMN IF NOT EXISTS optimal_parachute_q05b_title BOOLEAN DEFAULT false;
UPDATE movie_companies mc
SET optimal_parachute_q05b_title = true
FROM title t
WHERE t.id = mc.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2010
);

                
-------------
-- 05c
-------------

ALTER TABLE movie_info ADD COLUMN IF NOT EXISTS optimal_parachute_q05c_title BOOLEAN DEFAULT false;
UPDATE movie_info mi
SET optimal_parachute_q05c_title = true
FROM title t
WHERE t.id = mi.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 1990
);

ALTER TABLE movie_companies ADD COLUMN IF NOT EXISTS optimal_parachute_q05c_title BOOLEAN DEFAULT false;
UPDATE movie_companies mc
SET optimal_parachute_q05c_title = true
FROM title t
WHERE t.id = mc.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 1990
);

                
-------------
-- 06a
-------------

ALTER TABLE cast_info ADD COLUMN IF NOT EXISTS optimal_parachute_q06a_name BOOLEAN DEFAULT false;
UPDATE cast_info ci
SET optimal_parachute_q06a_name = true
FROM name n
WHERE n.id = ci.person_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    n.name LIKE '%Downey%Robert%'
);

                
-------------
-- 06b
-------------

                
-------------
-- 06c
-------------

                
-------------
-- 06d
-------------

                
-------------
-- 06e
-------------

ALTER TABLE cast_info ADD COLUMN IF NOT EXISTS optimal_parachute_q06e_name BOOLEAN DEFAULT false;
UPDATE cast_info ci
SET optimal_parachute_q06e_name = true
FROM name n
WHERE n.id = ci.person_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    n.name LIKE '%Downey%Robert%'
);

                
-------------
-- 06f
-------------

                
-------------
-- 07a
-------------

ALTER TABLE aka_name ADD COLUMN IF NOT EXISTS optimal_parachute_q07a_name BOOLEAN DEFAULT false;
UPDATE aka_name an
SET optimal_parachute_q07a_name = true
FROM name n
WHERE n.id = an.person_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    (n.gender='m'
       OR (n.gender = 'f'
           AND n.name LIKE 'B%'))
);

ALTER TABLE person_info ADD COLUMN IF NOT EXISTS optimal_parachute_q07a_name BOOLEAN DEFAULT false;
UPDATE person_info pi
SET optimal_parachute_q07a_name = true
FROM name n
WHERE n.id = pi.person_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    (n.gender='m'
       OR (n.gender = 'f'
           AND n.name LIKE 'B%'))
);

ALTER TABLE cast_info ADD COLUMN IF NOT EXISTS optimal_parachute_q07a_name BOOLEAN DEFAULT false;
UPDATE cast_info ci
SET optimal_parachute_q07a_name = true
FROM name n
WHERE ci.person_id = n.id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    (n.gender='m'
       OR (n.gender = 'f'
           AND n.name LIKE 'B%'))
);

ALTER TABLE movie_link ADD COLUMN IF NOT EXISTS optimal_parachute_q07a_link_type BOOLEAN DEFAULT false;
UPDATE movie_link ml
SET optimal_parachute_q07a_link_type = true
FROM link_type lt
WHERE lt.id = ml.link_type_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    lt.link ='features'
);

                
-------------
-- 07b
-------------

ALTER TABLE name ADD COLUMN IF NOT EXISTS optimal_parachute_q07b_aka_name BOOLEAN DEFAULT false;
UPDATE name n
SET optimal_parachute_q07b_aka_name = true
FROM aka_name an
WHERE n.id = an.person_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    an.name LIKE '%a%'
);

ALTER TABLE person_info ADD COLUMN IF NOT EXISTS optimal_parachute_q07b_aka_name BOOLEAN DEFAULT false;
UPDATE person_info pi
SET optimal_parachute_q07b_aka_name = true
FROM aka_name an
WHERE pi.person_id = an.person_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    an.name LIKE '%a%'
);

ALTER TABLE cast_info ADD COLUMN IF NOT EXISTS optimal_parachute_q07b_aka_name BOOLEAN DEFAULT false;
UPDATE cast_info ci
SET optimal_parachute_q07b_aka_name = true
FROM aka_name an
WHERE an.person_id = ci.person_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    an.name LIKE '%a%'
);

ALTER TABLE aka_name ADD COLUMN IF NOT EXISTS optimal_parachute_q07b_name BOOLEAN DEFAULT false;
UPDATE aka_name an
SET optimal_parachute_q07b_name = true
FROM name n
WHERE n.id = an.person_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    n.name_pcode_cf LIKE 'D%' AND n.gender='m'
);

ALTER TABLE person_info ADD COLUMN IF NOT EXISTS optimal_parachute_q07b_name BOOLEAN DEFAULT false;
UPDATE person_info pi
SET optimal_parachute_q07b_name = true
FROM name n
WHERE n.id = pi.person_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    n.name_pcode_cf LIKE 'D%' AND n.gender='m'
);

ALTER TABLE cast_info ADD COLUMN IF NOT EXISTS optimal_parachute_q07b_name BOOLEAN DEFAULT false;
UPDATE cast_info ci
SET optimal_parachute_q07b_name = true
FROM name n
WHERE ci.person_id = n.id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    n.name_pcode_cf LIKE 'D%' AND n.gender='m'
);

ALTER TABLE movie_link ADD COLUMN IF NOT EXISTS optimal_parachute_q07b_link_type BOOLEAN DEFAULT false;
UPDATE movie_link ml
SET optimal_parachute_q07b_link_type = true
FROM link_type lt
WHERE lt.id = ml.link_type_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    lt.link ='features'
);

                
-------------
-- 07c
-------------

ALTER TABLE aka_name ADD COLUMN IF NOT EXISTS optimal_parachute_q07c_name BOOLEAN DEFAULT false;
UPDATE aka_name an
SET optimal_parachute_q07c_name = true
FROM name n
WHERE n.id = an.person_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    (n.gender='m'
       OR (n.gender = 'f'
           AND n.name LIKE 'A%'))
);

ALTER TABLE person_info ADD COLUMN IF NOT EXISTS optimal_parachute_q07c_name BOOLEAN DEFAULT false;
UPDATE person_info pi
SET optimal_parachute_q07c_name = true
FROM name n
WHERE n.id = pi.person_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    (n.gender='m'
       OR (n.gender = 'f'
           AND n.name LIKE 'A%'))
);

ALTER TABLE cast_info ADD COLUMN IF NOT EXISTS optimal_parachute_q07c_name BOOLEAN DEFAULT false;
UPDATE cast_info ci
SET optimal_parachute_q07c_name = true
FROM name n
WHERE ci.person_id = n.id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    (n.gender='m'
       OR (n.gender = 'f'
           AND n.name LIKE 'A%'))
);

                
-------------
-- 08a
-------------

ALTER TABLE title ADD COLUMN IF NOT EXISTS optimal_parachute_q08a_movie_companies BOOLEAN DEFAULT false;
UPDATE title t
SET optimal_parachute_q08a_movie_companies = true
FROM movie_companies mc
WHERE t.id = mc.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    mc.note LIKE '%(Japan)%' AND mc.note NOT LIKE '%(USA)%'
);

ALTER TABLE company_name ADD COLUMN IF NOT EXISTS optimal_parachute_q08a_movie_companies BOOLEAN DEFAULT false;
UPDATE company_name cn
SET optimal_parachute_q08a_movie_companies = true
FROM movie_companies mc
WHERE mc.company_id = cn.id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    mc.note LIKE '%(Japan)%' AND mc.note NOT LIKE '%(USA)%'
);

ALTER TABLE cast_info ADD COLUMN IF NOT EXISTS optimal_parachute_q08a_movie_companies BOOLEAN DEFAULT false;
UPDATE cast_info ci
SET optimal_parachute_q08a_movie_companies = true
FROM movie_companies mc
WHERE ci.movie_id = mc.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    mc.note LIKE '%(Japan)%' AND mc.note NOT LIKE '%(USA)%'
);

ALTER TABLE movie_companies ADD COLUMN IF NOT EXISTS optimal_parachute_q08a_company_name BOOLEAN DEFAULT false;
UPDATE movie_companies mc
SET optimal_parachute_q08a_company_name = true
FROM company_name cn
WHERE mc.company_id = cn.id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    cn.country_code ='[jp]'
);

ALTER TABLE aka_name ADD COLUMN IF NOT EXISTS optimal_parachute_q08a_name BOOLEAN DEFAULT false;
UPDATE aka_name an1
SET optimal_parachute_q08a_name = true
FROM name n1
WHERE an1.person_id = n1.id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    n1.name LIKE '%Yo%' AND n1.name NOT LIKE '%Yu%'
);

ALTER TABLE cast_info ADD COLUMN IF NOT EXISTS optimal_parachute_q08a_name BOOLEAN DEFAULT false;
UPDATE cast_info ci
SET optimal_parachute_q08a_name = true
FROM name n1
WHERE n1.id = ci.person_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    n1.name LIKE '%Yo%' AND n1.name NOT LIKE '%Yu%'
);

                
-------------
-- 08b
-------------

ALTER TABLE cast_info ADD COLUMN IF NOT EXISTS optimal_parachute_q08b_title BOOLEAN DEFAULT false;
UPDATE cast_info ci
SET optimal_parachute_q08b_title = true
FROM title t
WHERE ci.movie_id = t.id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    (t.title LIKE 'One Piece%'
       OR t.title LIKE 'Dragon Ball Z%')
);

ALTER TABLE movie_companies ADD COLUMN IF NOT EXISTS optimal_parachute_q08b_title BOOLEAN DEFAULT false;
UPDATE movie_companies mc
SET optimal_parachute_q08b_title = true
FROM title t
WHERE t.id = mc.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    (t.title LIKE 'One Piece%'
       OR t.title LIKE 'Dragon Ball Z%')
);

ALTER TABLE title ADD COLUMN IF NOT EXISTS optimal_parachute_q08b_movie_companies BOOLEAN DEFAULT false;
UPDATE title t
SET optimal_parachute_q08b_movie_companies = true
FROM movie_companies mc
WHERE t.id = mc.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    mc.note LIKE '%(Japan)%' AND mc.note NOT LIKE '%(USA)%' AND (mc.note LIKE '%(2006)%'
       OR mc.note LIKE '%(2007)%')
);

ALTER TABLE company_name ADD COLUMN IF NOT EXISTS optimal_parachute_q08b_movie_companies BOOLEAN DEFAULT false;
UPDATE company_name cn
SET optimal_parachute_q08b_movie_companies = true
FROM movie_companies mc
WHERE mc.company_id = cn.id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    mc.note LIKE '%(Japan)%' AND mc.note NOT LIKE '%(USA)%' AND (mc.note LIKE '%(2006)%'
       OR mc.note LIKE '%(2007)%')
);

ALTER TABLE cast_info ADD COLUMN IF NOT EXISTS optimal_parachute_q08b_movie_companies BOOLEAN DEFAULT false;
UPDATE cast_info ci
SET optimal_parachute_q08b_movie_companies = true
FROM movie_companies mc
WHERE ci.movie_id = mc.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    mc.note LIKE '%(Japan)%' AND mc.note NOT LIKE '%(USA)%' AND (mc.note LIKE '%(2006)%'
       OR mc.note LIKE '%(2007)%')
);

                
-------------
-- 08c
-------------

                
-------------
-- 08d
-------------

                
-------------
-- 09a
-------------

ALTER TABLE cast_info ADD COLUMN IF NOT EXISTS optimal_parachute_q09a_name BOOLEAN DEFAULT false;
UPDATE cast_info ci
SET optimal_parachute_q09a_name = true
FROM name n
WHERE n.id = ci.person_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    n.gender ='f' AND n.name LIKE '%Ang%'
);

ALTER TABLE aka_name ADD COLUMN IF NOT EXISTS optimal_parachute_q09a_name BOOLEAN DEFAULT false;
UPDATE aka_name an
SET optimal_parachute_q09a_name = true
FROM name n
WHERE an.person_id = n.id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    n.gender ='f' AND n.name LIKE '%Ang%'
);

                
-------------
-- 09b
-------------

ALTER TABLE cast_info ADD COLUMN IF NOT EXISTS optimal_parachute_q09b_name BOOLEAN DEFAULT false;
UPDATE cast_info ci
SET optimal_parachute_q09b_name = true
FROM name n
WHERE n.id = ci.person_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    n.gender ='f' AND n.name LIKE '%Angel%'
);

ALTER TABLE aka_name ADD COLUMN IF NOT EXISTS optimal_parachute_q09b_name BOOLEAN DEFAULT false;
UPDATE aka_name an
SET optimal_parachute_q09b_name = true
FROM name n
WHERE an.person_id = n.id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    n.gender ='f' AND n.name LIKE '%Angel%'
);

ALTER TABLE title ADD COLUMN IF NOT EXISTS optimal_parachute_q09b_movie_companies BOOLEAN DEFAULT false;
UPDATE title t
SET optimal_parachute_q09b_movie_companies = true
FROM movie_companies mc
WHERE t.id = mc.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    mc.note LIKE '%(200%)%' AND (mc.note LIKE '%(USA)%'
       OR mc.note LIKE '%(worldwide)%')
);

ALTER TABLE cast_info ADD COLUMN IF NOT EXISTS optimal_parachute_q09b_movie_companies BOOLEAN DEFAULT false;
UPDATE cast_info ci
SET optimal_parachute_q09b_movie_companies = true
FROM movie_companies mc
WHERE ci.movie_id = mc.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    mc.note LIKE '%(200%)%' AND (mc.note LIKE '%(USA)%'
       OR mc.note LIKE '%(worldwide)%')
);

ALTER TABLE company_name ADD COLUMN IF NOT EXISTS optimal_parachute_q09b_movie_companies BOOLEAN DEFAULT false;
UPDATE company_name cn
SET optimal_parachute_q09b_movie_companies = true
FROM movie_companies mc
WHERE mc.company_id = cn.id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    mc.note LIKE '%(200%)%' AND (mc.note LIKE '%(USA)%'
       OR mc.note LIKE '%(worldwide)%')
);

ALTER TABLE movie_companies ADD COLUMN IF NOT EXISTS optimal_parachute_q09b_company_name BOOLEAN DEFAULT false;
UPDATE movie_companies mc
SET optimal_parachute_q09b_company_name = true
FROM company_name cn
WHERE mc.company_id = cn.id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    cn.country_code ='[us]'
);

                
-------------
-- 09c
-------------

ALTER TABLE cast_info ADD COLUMN IF NOT EXISTS optimal_parachute_q09c_name BOOLEAN DEFAULT false;
UPDATE cast_info ci
SET optimal_parachute_q09c_name = true
FROM name n
WHERE n.id = ci.person_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    n.gender ='f' AND n.name LIKE '%An%'
);

ALTER TABLE aka_name ADD COLUMN IF NOT EXISTS optimal_parachute_q09c_name BOOLEAN DEFAULT false;
UPDATE aka_name an
SET optimal_parachute_q09c_name = true
FROM name n
WHERE an.person_id = n.id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    n.gender ='f' AND n.name LIKE '%An%'
);

                
-------------
-- 09d
-------------

ALTER TABLE cast_info ADD COLUMN IF NOT EXISTS optimal_parachute_q09d_name BOOLEAN DEFAULT false;
UPDATE cast_info ci
SET optimal_parachute_q09d_name = true
FROM name n
WHERE n.id = ci.person_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    n.gender ='f'
);

ALTER TABLE aka_name ADD COLUMN IF NOT EXISTS optimal_parachute_q09d_name BOOLEAN DEFAULT false;
UPDATE aka_name an
SET optimal_parachute_q09d_name = true
FROM name n
WHERE an.person_id = n.id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    n.gender ='f'
);

                
-------------
-- 10a
-------------

ALTER TABLE movie_companies ADD COLUMN IF NOT EXISTS optimal_parachute_q10a_title BOOLEAN DEFAULT false;
UPDATE movie_companies mc
SET optimal_parachute_q10a_title = true
FROM title t
WHERE t.id = mc.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2005
);

ALTER TABLE cast_info ADD COLUMN IF NOT EXISTS optimal_parachute_q10a_title BOOLEAN DEFAULT false;
UPDATE cast_info ci
SET optimal_parachute_q10a_title = true
FROM title t
WHERE t.id = ci.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2005
);

ALTER TABLE title ADD COLUMN IF NOT EXISTS optimal_parachute_q10a_cast_info BOOLEAN DEFAULT false;
UPDATE title t
SET optimal_parachute_q10a_cast_info = true
FROM cast_info ci
WHERE t.id = ci.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    ci.note LIKE '%(voice)%' AND ci.note LIKE '%(uncredited)%'
);

ALTER TABLE movie_companies ADD COLUMN IF NOT EXISTS optimal_parachute_q10a_cast_info BOOLEAN DEFAULT false;
UPDATE movie_companies mc
SET optimal_parachute_q10a_cast_info = true
FROM cast_info ci
WHERE ci.movie_id = mc.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    ci.note LIKE '%(voice)%' AND ci.note LIKE '%(uncredited)%'
);

ALTER TABLE char_name ADD COLUMN IF NOT EXISTS optimal_parachute_q10a_cast_info BOOLEAN DEFAULT false;
UPDATE char_name chn
SET optimal_parachute_q10a_cast_info = true
FROM cast_info ci
WHERE chn.id = ci.person_role_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    ci.note LIKE '%(voice)%' AND ci.note LIKE '%(uncredited)%'
);

ALTER TABLE role_type ADD COLUMN IF NOT EXISTS optimal_parachute_q10a_cast_info BOOLEAN DEFAULT false;
UPDATE role_type rt
SET optimal_parachute_q10a_cast_info = true
FROM cast_info ci
WHERE rt.id = ci.role_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    ci.note LIKE '%(voice)%' AND ci.note LIKE '%(uncredited)%'
);

                
-------------
-- 10b
-------------

ALTER TABLE movie_companies ADD COLUMN IF NOT EXISTS optimal_parachute_q10b_title BOOLEAN DEFAULT false;
UPDATE movie_companies mc
SET optimal_parachute_q10b_title = true
FROM title t
WHERE t.id = mc.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2010
);

ALTER TABLE cast_info ADD COLUMN IF NOT EXISTS optimal_parachute_q10b_title BOOLEAN DEFAULT false;
UPDATE cast_info ci
SET optimal_parachute_q10b_title = true
FROM title t
WHERE t.id = ci.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2010
);

ALTER TABLE title ADD COLUMN IF NOT EXISTS optimal_parachute_q10b_cast_info BOOLEAN DEFAULT false;
UPDATE title t
SET optimal_parachute_q10b_cast_info = true
FROM cast_info ci
WHERE t.id = ci.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    ci.note LIKE '%(producer)%'
);

ALTER TABLE movie_companies ADD COLUMN IF NOT EXISTS optimal_parachute_q10b_cast_info BOOLEAN DEFAULT false;
UPDATE movie_companies mc
SET optimal_parachute_q10b_cast_info = true
FROM cast_info ci
WHERE ci.movie_id = mc.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    ci.note LIKE '%(producer)%'
);

ALTER TABLE char_name ADD COLUMN IF NOT EXISTS optimal_parachute_q10b_cast_info BOOLEAN DEFAULT false;
UPDATE char_name chn
SET optimal_parachute_q10b_cast_info = true
FROM cast_info ci
WHERE chn.id = ci.person_role_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    ci.note LIKE '%(producer)%'
);

ALTER TABLE role_type ADD COLUMN IF NOT EXISTS optimal_parachute_q10b_cast_info BOOLEAN DEFAULT false;
UPDATE role_type rt
SET optimal_parachute_q10b_cast_info = true
FROM cast_info ci
WHERE rt.id = ci.role_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    ci.note LIKE '%(producer)%'
);

                
-------------
-- 10c
-------------

ALTER TABLE movie_companies ADD COLUMN IF NOT EXISTS optimal_parachute_q10c_title BOOLEAN DEFAULT false;
UPDATE movie_companies mc
SET optimal_parachute_q10c_title = true
FROM title t
WHERE t.id = mc.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 1990
);

ALTER TABLE cast_info ADD COLUMN IF NOT EXISTS optimal_parachute_q10c_title BOOLEAN DEFAULT false;
UPDATE cast_info ci
SET optimal_parachute_q10c_title = true
FROM title t
WHERE t.id = ci.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 1990
);

ALTER TABLE title ADD COLUMN IF NOT EXISTS optimal_parachute_q10c_cast_info BOOLEAN DEFAULT false;
UPDATE title t
SET optimal_parachute_q10c_cast_info = true
FROM cast_info ci
WHERE t.id = ci.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    ci.note LIKE '%(producer)%'
);

ALTER TABLE movie_companies ADD COLUMN IF NOT EXISTS optimal_parachute_q10c_cast_info BOOLEAN DEFAULT false;
UPDATE movie_companies mc
SET optimal_parachute_q10c_cast_info = true
FROM cast_info ci
WHERE ci.movie_id = mc.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    ci.note LIKE '%(producer)%'
);

ALTER TABLE char_name ADD COLUMN IF NOT EXISTS optimal_parachute_q10c_cast_info BOOLEAN DEFAULT false;
UPDATE char_name chn
SET optimal_parachute_q10c_cast_info = true
FROM cast_info ci
WHERE chn.id = ci.person_role_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    ci.note LIKE '%(producer)%'
);

ALTER TABLE role_type ADD COLUMN IF NOT EXISTS optimal_parachute_q10c_cast_info BOOLEAN DEFAULT false;
UPDATE role_type rt
SET optimal_parachute_q10c_cast_info = true
FROM cast_info ci
WHERE rt.id = ci.role_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    ci.note LIKE '%(producer)%'
);

                
-------------
-- 11a
-------------

ALTER TABLE movie_link ADD COLUMN IF NOT EXISTS optimal_parachute_q11a_link_type BOOLEAN DEFAULT false;
UPDATE movie_link ml
SET optimal_parachute_q11a_link_type = true
FROM link_type lt
WHERE lt.id = ml.link_type_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    lt.link LIKE '%follow%'
);

ALTER TABLE movie_companies ADD COLUMN IF NOT EXISTS optimal_parachute_q11a_company_name BOOLEAN DEFAULT false;
UPDATE movie_companies mc
SET optimal_parachute_q11a_company_name = true
FROM company_name cn
WHERE mc.company_id = cn.id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    cn.country_code !='[pl]' AND (cn.name LIKE '%Film%'
       OR cn.name LIKE '%Warner%')
);

                
-------------
-- 11b
-------------

ALTER TABLE movie_keyword ADD COLUMN IF NOT EXISTS optimal_parachute_q11b_keyword BOOLEAN DEFAULT false;
UPDATE movie_keyword mk
SET optimal_parachute_q11b_keyword = true
FROM keyword k
WHERE mk.keyword_id = k.id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    k.keyword ='sequel'
);

                
-------------
-- 11c
-------------

ALTER TABLE movie_link ADD COLUMN IF NOT EXISTS optimal_parachute_q11c_title BOOLEAN DEFAULT false;
UPDATE movie_link ml
SET optimal_parachute_q11c_title = true
FROM title t
WHERE ml.movie_id = t.id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 1950
);

ALTER TABLE movie_keyword ADD COLUMN IF NOT EXISTS optimal_parachute_q11c_title BOOLEAN DEFAULT false;
UPDATE movie_keyword mk
SET optimal_parachute_q11c_title = true
FROM title t
WHERE t.id = mk.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 1950
);

ALTER TABLE movie_companies ADD COLUMN IF NOT EXISTS optimal_parachute_q11c_title BOOLEAN DEFAULT false;
UPDATE movie_companies mc
SET optimal_parachute_q11c_title = true
FROM title t
WHERE t.id = mc.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 1950
);

                
-------------
-- 11d
-------------

ALTER TABLE movie_link ADD COLUMN IF NOT EXISTS optimal_parachute_q11d_title BOOLEAN DEFAULT false;
UPDATE movie_link ml
SET optimal_parachute_q11d_title = true
FROM title t
WHERE ml.movie_id = t.id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 1950
);

ALTER TABLE movie_keyword ADD COLUMN IF NOT EXISTS optimal_parachute_q11d_title BOOLEAN DEFAULT false;
UPDATE movie_keyword mk
SET optimal_parachute_q11d_title = true
FROM title t
WHERE t.id = mk.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 1950
);

ALTER TABLE movie_companies ADD COLUMN IF NOT EXISTS optimal_parachute_q11d_title BOOLEAN DEFAULT false;
UPDATE movie_companies mc
SET optimal_parachute_q11d_title = true
FROM title t
WHERE t.id = mc.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 1950
);

ALTER TABLE movie_companies ADD COLUMN IF NOT EXISTS optimal_parachute_q11d_company_name BOOLEAN DEFAULT false;
UPDATE movie_companies mc
SET optimal_parachute_q11d_company_name = true
FROM company_name cn
WHERE mc.company_id = cn.id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    cn.country_code !='[pl]'
);

                
-------------
-- 12a
-------------

                
-------------
-- 12b
-------------

ALTER TABLE movie_info ADD COLUMN IF NOT EXISTS optimal_parachute_q12b_title BOOLEAN DEFAULT false;
UPDATE movie_info mi
SET optimal_parachute_q12b_title = true
FROM title t
WHERE t.id = mi.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year >2000 AND (t.title LIKE 'Birdemic%'
       OR t.title LIKE '%Movie%')
);

ALTER TABLE movie_info_idx ADD COLUMN IF NOT EXISTS optimal_parachute_q12b_title BOOLEAN DEFAULT false;
UPDATE movie_info_idx mi_idx
SET optimal_parachute_q12b_title = true
FROM title t
WHERE t.id = mi_idx.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year >2000 AND (t.title LIKE 'Birdemic%'
       OR t.title LIKE '%Movie%')
);

ALTER TABLE movie_companies ADD COLUMN IF NOT EXISTS optimal_parachute_q12b_title BOOLEAN DEFAULT false;
UPDATE movie_companies mc
SET optimal_parachute_q12b_title = true
FROM title t
WHERE t.id = mc.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year >2000 AND (t.title LIKE 'Birdemic%'
       OR t.title LIKE '%Movie%')
);

                
-------------
-- 12c
-------------

                
-------------
-- 13a
-------------

                
-------------
-- 13b
-------------

ALTER TABLE movie_info ADD COLUMN IF NOT EXISTS optimal_parachute_q13b_title BOOLEAN DEFAULT false;
UPDATE movie_info mi
SET optimal_parachute_q13b_title = true
FROM title t
WHERE mi.movie_id = t.id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.title != '' AND (t.title LIKE '%Champion%'
       OR t.title LIKE '%Loser%')
);

ALTER TABLE kind_type ADD COLUMN IF NOT EXISTS optimal_parachute_q13b_title BOOLEAN DEFAULT false;
UPDATE kind_type kt
SET optimal_parachute_q13b_title = true
FROM title t
WHERE kt.id = t.kind_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.title != '' AND (t.title LIKE '%Champion%'
       OR t.title LIKE '%Loser%')
);

ALTER TABLE movie_companies ADD COLUMN IF NOT EXISTS optimal_parachute_q13b_title BOOLEAN DEFAULT false;
UPDATE movie_companies mc
SET optimal_parachute_q13b_title = true
FROM title t
WHERE mc.movie_id = t.id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.title != '' AND (t.title LIKE '%Champion%'
       OR t.title LIKE '%Loser%')
);

ALTER TABLE movie_info_idx ADD COLUMN IF NOT EXISTS optimal_parachute_q13b_title BOOLEAN DEFAULT false;
UPDATE movie_info_idx miidx
SET optimal_parachute_q13b_title = true
FROM title t
WHERE miidx.movie_id = t.id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.title != '' AND (t.title LIKE '%Champion%'
       OR t.title LIKE '%Loser%')
);

                
-------------
-- 13c
-------------

ALTER TABLE movie_info ADD COLUMN IF NOT EXISTS optimal_parachute_q13c_title BOOLEAN DEFAULT false;
UPDATE movie_info mi
SET optimal_parachute_q13c_title = true
FROM title t
WHERE mi.movie_id = t.id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.title != '' AND (t.title LIKE 'Champion%'
       OR t.title LIKE 'Loser%')
);

ALTER TABLE kind_type ADD COLUMN IF NOT EXISTS optimal_parachute_q13c_title BOOLEAN DEFAULT false;
UPDATE kind_type kt
SET optimal_parachute_q13c_title = true
FROM title t
WHERE kt.id = t.kind_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.title != '' AND (t.title LIKE 'Champion%'
       OR t.title LIKE 'Loser%')
);

ALTER TABLE movie_companies ADD COLUMN IF NOT EXISTS optimal_parachute_q13c_title BOOLEAN DEFAULT false;
UPDATE movie_companies mc
SET optimal_parachute_q13c_title = true
FROM title t
WHERE mc.movie_id = t.id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.title != '' AND (t.title LIKE 'Champion%'
       OR t.title LIKE 'Loser%')
);

ALTER TABLE movie_info_idx ADD COLUMN IF NOT EXISTS optimal_parachute_q13c_title BOOLEAN DEFAULT false;
UPDATE movie_info_idx miidx
SET optimal_parachute_q13c_title = true
FROM title t
WHERE miidx.movie_id = t.id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.title != '' AND (t.title LIKE 'Champion%'
       OR t.title LIKE 'Loser%')
);

                
-------------
-- 13d
-------------

                
-------------
-- 14a
-------------

ALTER TABLE kind_type ADD COLUMN IF NOT EXISTS optimal_parachute_q14a_title BOOLEAN DEFAULT false;
UPDATE kind_type kt
SET optimal_parachute_q14a_title = true
FROM title t
WHERE kt.id = t.kind_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2010
);

ALTER TABLE movie_info ADD COLUMN IF NOT EXISTS optimal_parachute_q14a_title BOOLEAN DEFAULT false;
UPDATE movie_info mi
SET optimal_parachute_q14a_title = true
FROM title t
WHERE t.id = mi.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2010
);

ALTER TABLE movie_keyword ADD COLUMN IF NOT EXISTS optimal_parachute_q14a_title BOOLEAN DEFAULT false;
UPDATE movie_keyword mk
SET optimal_parachute_q14a_title = true
FROM title t
WHERE t.id = mk.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2010
);

ALTER TABLE movie_info_idx ADD COLUMN IF NOT EXISTS optimal_parachute_q14a_title BOOLEAN DEFAULT false;
UPDATE movie_info_idx mi_idx
SET optimal_parachute_q14a_title = true
FROM title t
WHERE t.id = mi_idx.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2010
);

                
-------------
-- 14b
-------------

ALTER TABLE kind_type ADD COLUMN IF NOT EXISTS optimal_parachute_q14b_title BOOLEAN DEFAULT false;
UPDATE kind_type kt
SET optimal_parachute_q14b_title = true
FROM title t
WHERE kt.id = t.kind_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2010 AND (t.title LIKE '%murder%'
       OR t.title LIKE '%Murder%'
       OR t.title LIKE '%Mord%')
);

ALTER TABLE movie_info ADD COLUMN IF NOT EXISTS optimal_parachute_q14b_title BOOLEAN DEFAULT false;
UPDATE movie_info mi
SET optimal_parachute_q14b_title = true
FROM title t
WHERE t.id = mi.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2010 AND (t.title LIKE '%murder%'
       OR t.title LIKE '%Murder%'
       OR t.title LIKE '%Mord%')
);

ALTER TABLE movie_keyword ADD COLUMN IF NOT EXISTS optimal_parachute_q14b_title BOOLEAN DEFAULT false;
UPDATE movie_keyword mk
SET optimal_parachute_q14b_title = true
FROM title t
WHERE t.id = mk.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2010 AND (t.title LIKE '%murder%'
       OR t.title LIKE '%Murder%'
       OR t.title LIKE '%Mord%')
);

ALTER TABLE movie_info_idx ADD COLUMN IF NOT EXISTS optimal_parachute_q14b_title BOOLEAN DEFAULT false;
UPDATE movie_info_idx mi_idx
SET optimal_parachute_q14b_title = true
FROM title t
WHERE t.id = mi_idx.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2010 AND (t.title LIKE '%murder%'
       OR t.title LIKE '%Murder%'
       OR t.title LIKE '%Mord%')
);

                
-------------
-- 14c
-------------

ALTER TABLE kind_type ADD COLUMN IF NOT EXISTS optimal_parachute_q14c_title BOOLEAN DEFAULT false;
UPDATE kind_type kt
SET optimal_parachute_q14c_title = true
FROM title t
WHERE kt.id = t.kind_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2005
);

ALTER TABLE movie_info ADD COLUMN IF NOT EXISTS optimal_parachute_q14c_title BOOLEAN DEFAULT false;
UPDATE movie_info mi
SET optimal_parachute_q14c_title = true
FROM title t
WHERE t.id = mi.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2005
);

ALTER TABLE movie_keyword ADD COLUMN IF NOT EXISTS optimal_parachute_q14c_title BOOLEAN DEFAULT false;
UPDATE movie_keyword mk
SET optimal_parachute_q14c_title = true
FROM title t
WHERE t.id = mk.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2005
);

ALTER TABLE movie_info_idx ADD COLUMN IF NOT EXISTS optimal_parachute_q14c_title BOOLEAN DEFAULT false;
UPDATE movie_info_idx mi_idx
SET optimal_parachute_q14c_title = true
FROM title t
WHERE t.id = mi_idx.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2005
);

                
-------------
-- 15a
-------------

ALTER TABLE aka_title ADD COLUMN IF NOT EXISTS optimal_parachute_q15a_title BOOLEAN DEFAULT false;
UPDATE aka_title at
SET optimal_parachute_q15a_title = true
FROM title t
WHERE t.id = at.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2000
);

ALTER TABLE movie_info ADD COLUMN IF NOT EXISTS optimal_parachute_q15a_title BOOLEAN DEFAULT false;
UPDATE movie_info mi
SET optimal_parachute_q15a_title = true
FROM title t
WHERE t.id = mi.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2000
);

ALTER TABLE movie_keyword ADD COLUMN IF NOT EXISTS optimal_parachute_q15a_title BOOLEAN DEFAULT false;
UPDATE movie_keyword mk
SET optimal_parachute_q15a_title = true
FROM title t
WHERE t.id = mk.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2000
);

ALTER TABLE movie_companies ADD COLUMN IF NOT EXISTS optimal_parachute_q15a_title BOOLEAN DEFAULT false;
UPDATE movie_companies mc
SET optimal_parachute_q15a_title = true
FROM title t
WHERE t.id = mc.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2000
);

ALTER TABLE title ADD COLUMN IF NOT EXISTS optimal_parachute_q15a_movie_info BOOLEAN DEFAULT false;
UPDATE title t
SET optimal_parachute_q15a_movie_info = true
FROM movie_info mi
WHERE t.id = mi.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    mi.note LIKE '%internet%' AND mi.info LIKE 'USA:% 200%'
);

ALTER TABLE movie_keyword ADD COLUMN IF NOT EXISTS optimal_parachute_q15a_movie_info BOOLEAN DEFAULT false;
UPDATE movie_keyword mk
SET optimal_parachute_q15a_movie_info = true
FROM movie_info mi
WHERE mk.movie_id = mi.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    mi.note LIKE '%internet%' AND mi.info LIKE 'USA:% 200%'
);

ALTER TABLE movie_companies ADD COLUMN IF NOT EXISTS optimal_parachute_q15a_movie_info BOOLEAN DEFAULT false;
UPDATE movie_companies mc
SET optimal_parachute_q15a_movie_info = true
FROM movie_info mi
WHERE mi.movie_id = mc.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    mi.note LIKE '%internet%' AND mi.info LIKE 'USA:% 200%'
);

ALTER TABLE aka_title ADD COLUMN IF NOT EXISTS optimal_parachute_q15a_movie_info BOOLEAN DEFAULT false;
UPDATE aka_title at
SET optimal_parachute_q15a_movie_info = true
FROM movie_info mi
WHERE mi.movie_id = at.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    mi.note LIKE '%internet%' AND mi.info LIKE 'USA:% 200%'
);

ALTER TABLE info_type ADD COLUMN IF NOT EXISTS optimal_parachute_q15a_movie_info BOOLEAN DEFAULT false;
UPDATE info_type it1
SET optimal_parachute_q15a_movie_info = true
FROM movie_info mi
WHERE it1.id = mi.info_type_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    mi.note LIKE '%internet%' AND mi.info LIKE 'USA:% 200%'
);

                
-------------
-- 15b
-------------

                
-------------
-- 15c
-------------

ALTER TABLE aka_title ADD COLUMN IF NOT EXISTS optimal_parachute_q15c_title BOOLEAN DEFAULT false;
UPDATE aka_title at
SET optimal_parachute_q15c_title = true
FROM title t
WHERE t.id = at.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 1990
);

ALTER TABLE movie_info ADD COLUMN IF NOT EXISTS optimal_parachute_q15c_title BOOLEAN DEFAULT false;
UPDATE movie_info mi
SET optimal_parachute_q15c_title = true
FROM title t
WHERE t.id = mi.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 1990
);

ALTER TABLE movie_keyword ADD COLUMN IF NOT EXISTS optimal_parachute_q15c_title BOOLEAN DEFAULT false;
UPDATE movie_keyword mk
SET optimal_parachute_q15c_title = true
FROM title t
WHERE t.id = mk.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 1990
);

ALTER TABLE movie_companies ADD COLUMN IF NOT EXISTS optimal_parachute_q15c_title BOOLEAN DEFAULT false;
UPDATE movie_companies mc
SET optimal_parachute_q15c_title = true
FROM title t
WHERE t.id = mc.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 1990
);

ALTER TABLE title ADD COLUMN IF NOT EXISTS optimal_parachute_q15c_movie_info BOOLEAN DEFAULT false;
UPDATE title t
SET optimal_parachute_q15c_movie_info = true
FROM movie_info mi
WHERE t.id = mi.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    mi.note LIKE '%internet%' AND (mi.info LIKE 'USA:% 199%'
       OR mi.info LIKE 'USA:% 200%')
);

ALTER TABLE movie_keyword ADD COLUMN IF NOT EXISTS optimal_parachute_q15c_movie_info BOOLEAN DEFAULT false;
UPDATE movie_keyword mk
SET optimal_parachute_q15c_movie_info = true
FROM movie_info mi
WHERE mk.movie_id = mi.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    mi.note LIKE '%internet%' AND (mi.info LIKE 'USA:% 199%'
       OR mi.info LIKE 'USA:% 200%')
);

ALTER TABLE movie_companies ADD COLUMN IF NOT EXISTS optimal_parachute_q15c_movie_info BOOLEAN DEFAULT false;
UPDATE movie_companies mc
SET optimal_parachute_q15c_movie_info = true
FROM movie_info mi
WHERE mi.movie_id = mc.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    mi.note LIKE '%internet%' AND (mi.info LIKE 'USA:% 199%'
       OR mi.info LIKE 'USA:% 200%')
);

ALTER TABLE aka_title ADD COLUMN IF NOT EXISTS optimal_parachute_q15c_movie_info BOOLEAN DEFAULT false;
UPDATE aka_title at
SET optimal_parachute_q15c_movie_info = true
FROM movie_info mi
WHERE mi.movie_id = at.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    mi.note LIKE '%internet%' AND (mi.info LIKE 'USA:% 199%'
       OR mi.info LIKE 'USA:% 200%')
);

ALTER TABLE info_type ADD COLUMN IF NOT EXISTS optimal_parachute_q15c_movie_info BOOLEAN DEFAULT false;
UPDATE info_type it1
SET optimal_parachute_q15c_movie_info = true
FROM movie_info mi
WHERE it1.id = mi.info_type_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    mi.note LIKE '%internet%' AND (mi.info LIKE 'USA:% 199%'
       OR mi.info LIKE 'USA:% 200%')
);

                
-------------
-- 15d
-------------

ALTER TABLE aka_title ADD COLUMN IF NOT EXISTS optimal_parachute_q15d_title BOOLEAN DEFAULT false;
UPDATE aka_title at
SET optimal_parachute_q15d_title = true
FROM title t
WHERE t.id = at.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 1990
);

ALTER TABLE movie_info ADD COLUMN IF NOT EXISTS optimal_parachute_q15d_title BOOLEAN DEFAULT false;
UPDATE movie_info mi
SET optimal_parachute_q15d_title = true
FROM title t
WHERE t.id = mi.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 1990
);

ALTER TABLE movie_keyword ADD COLUMN IF NOT EXISTS optimal_parachute_q15d_title BOOLEAN DEFAULT false;
UPDATE movie_keyword mk
SET optimal_parachute_q15d_title = true
FROM title t
WHERE t.id = mk.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 1990
);

ALTER TABLE movie_companies ADD COLUMN IF NOT EXISTS optimal_parachute_q15d_title BOOLEAN DEFAULT false;
UPDATE movie_companies mc
SET optimal_parachute_q15d_title = true
FROM title t
WHERE t.id = mc.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 1990
);

ALTER TABLE title ADD COLUMN IF NOT EXISTS optimal_parachute_q15d_movie_info BOOLEAN DEFAULT false;
UPDATE title t
SET optimal_parachute_q15d_movie_info = true
FROM movie_info mi
WHERE t.id = mi.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    mi.note LIKE '%internet%'
);

ALTER TABLE movie_keyword ADD COLUMN IF NOT EXISTS optimal_parachute_q15d_movie_info BOOLEAN DEFAULT false;
UPDATE movie_keyword mk
SET optimal_parachute_q15d_movie_info = true
FROM movie_info mi
WHERE mk.movie_id = mi.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    mi.note LIKE '%internet%'
);

ALTER TABLE movie_companies ADD COLUMN IF NOT EXISTS optimal_parachute_q15d_movie_info BOOLEAN DEFAULT false;
UPDATE movie_companies mc
SET optimal_parachute_q15d_movie_info = true
FROM movie_info mi
WHERE mi.movie_id = mc.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    mi.note LIKE '%internet%'
);

ALTER TABLE aka_title ADD COLUMN IF NOT EXISTS optimal_parachute_q15d_movie_info BOOLEAN DEFAULT false;
UPDATE aka_title at
SET optimal_parachute_q15d_movie_info = true
FROM movie_info mi
WHERE mi.movie_id = at.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    mi.note LIKE '%internet%'
);

ALTER TABLE info_type ADD COLUMN IF NOT EXISTS optimal_parachute_q15d_movie_info BOOLEAN DEFAULT false;
UPDATE info_type it1
SET optimal_parachute_q15d_movie_info = true
FROM movie_info mi
WHERE it1.id = mi.info_type_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    mi.note LIKE '%internet%'
);

                
-------------
-- 16a
-------------

ALTER TABLE cast_info ADD COLUMN IF NOT EXISTS optimal_parachute_q16a_title BOOLEAN DEFAULT false;
UPDATE cast_info ci
SET optimal_parachute_q16a_title = true
FROM title t
WHERE ci.movie_id = t.id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.episode_nr >= 50 AND t.episode_nr < 100
);

ALTER TABLE movie_keyword ADD COLUMN IF NOT EXISTS optimal_parachute_q16a_title BOOLEAN DEFAULT false;
UPDATE movie_keyword mk
SET optimal_parachute_q16a_title = true
FROM title t
WHERE t.id = mk.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.episode_nr >= 50 AND t.episode_nr < 100
);

ALTER TABLE movie_companies ADD COLUMN IF NOT EXISTS optimal_parachute_q16a_title BOOLEAN DEFAULT false;
UPDATE movie_companies mc
SET optimal_parachute_q16a_title = true
FROM title t
WHERE t.id = mc.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.episode_nr >= 50 AND t.episode_nr < 100
);

ALTER TABLE movie_companies ADD COLUMN IF NOT EXISTS optimal_parachute_q16a_company_name BOOLEAN DEFAULT false;
UPDATE movie_companies mc
SET optimal_parachute_q16a_company_name = true
FROM company_name cn
WHERE mc.company_id = cn.id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    cn.country_code ='[us]'
);

                
-------------
-- 16b
-------------

ALTER TABLE movie_companies ADD COLUMN IF NOT EXISTS optimal_parachute_q16b_company_name BOOLEAN DEFAULT false;
UPDATE movie_companies mc
SET optimal_parachute_q16b_company_name = true
FROM company_name cn
WHERE mc.company_id = cn.id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    cn.country_code ='[us]'
);

                
-------------
-- 16c
-------------

ALTER TABLE cast_info ADD COLUMN IF NOT EXISTS optimal_parachute_q16c_title BOOLEAN DEFAULT false;
UPDATE cast_info ci
SET optimal_parachute_q16c_title = true
FROM title t
WHERE ci.movie_id = t.id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.episode_nr < 100
);

ALTER TABLE movie_keyword ADD COLUMN IF NOT EXISTS optimal_parachute_q16c_title BOOLEAN DEFAULT false;
UPDATE movie_keyword mk
SET optimal_parachute_q16c_title = true
FROM title t
WHERE t.id = mk.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.episode_nr < 100
);

ALTER TABLE movie_companies ADD COLUMN IF NOT EXISTS optimal_parachute_q16c_title BOOLEAN DEFAULT false;
UPDATE movie_companies mc
SET optimal_parachute_q16c_title = true
FROM title t
WHERE t.id = mc.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.episode_nr < 100
);

ALTER TABLE movie_companies ADD COLUMN IF NOT EXISTS optimal_parachute_q16c_company_name BOOLEAN DEFAULT false;
UPDATE movie_companies mc
SET optimal_parachute_q16c_company_name = true
FROM company_name cn
WHERE mc.company_id = cn.id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    cn.country_code ='[us]'
);

                
-------------
-- 16d
-------------

ALTER TABLE cast_info ADD COLUMN IF NOT EXISTS optimal_parachute_q16d_title BOOLEAN DEFAULT false;
UPDATE cast_info ci
SET optimal_parachute_q16d_title = true
FROM title t
WHERE ci.movie_id = t.id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.episode_nr >= 5 AND t.episode_nr < 100
);

ALTER TABLE movie_keyword ADD COLUMN IF NOT EXISTS optimal_parachute_q16d_title BOOLEAN DEFAULT false;
UPDATE movie_keyword mk
SET optimal_parachute_q16d_title = true
FROM title t
WHERE t.id = mk.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.episode_nr >= 5 AND t.episode_nr < 100
);

ALTER TABLE movie_companies ADD COLUMN IF NOT EXISTS optimal_parachute_q16d_title BOOLEAN DEFAULT false;
UPDATE movie_companies mc
SET optimal_parachute_q16d_title = true
FROM title t
WHERE t.id = mc.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.episode_nr >= 5 AND t.episode_nr < 100
);

ALTER TABLE movie_companies ADD COLUMN IF NOT EXISTS optimal_parachute_q16d_company_name BOOLEAN DEFAULT false;
UPDATE movie_companies mc
SET optimal_parachute_q16d_company_name = true
FROM company_name cn
WHERE mc.company_id = cn.id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    cn.country_code ='[us]'
);

                
-------------
-- 17a
-------------

ALTER TABLE movie_companies ADD COLUMN IF NOT EXISTS optimal_parachute_q17a_company_name BOOLEAN DEFAULT false;
UPDATE movie_companies mc
SET optimal_parachute_q17a_company_name = true
FROM company_name cn
WHERE mc.company_id = cn.id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    cn.country_code ='[us]'
);

ALTER TABLE cast_info ADD COLUMN IF NOT EXISTS optimal_parachute_q17a_name BOOLEAN DEFAULT false;
UPDATE cast_info ci
SET optimal_parachute_q17a_name = true
FROM name n
WHERE n.id = ci.person_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    n.name LIKE 'B%'
);

                
-------------
-- 17b
-------------

ALTER TABLE cast_info ADD COLUMN IF NOT EXISTS optimal_parachute_q17b_name BOOLEAN DEFAULT false;
UPDATE cast_info ci
SET optimal_parachute_q17b_name = true
FROM name n
WHERE n.id = ci.person_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    n.name LIKE 'Z%'
);

                
-------------
-- 17c
-------------

ALTER TABLE cast_info ADD COLUMN IF NOT EXISTS optimal_parachute_q17c_name BOOLEAN DEFAULT false;
UPDATE cast_info ci
SET optimal_parachute_q17c_name = true
FROM name n
WHERE n.id = ci.person_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    n.name LIKE 'X%'
);

                
-------------
-- 17d
-------------

ALTER TABLE cast_info ADD COLUMN IF NOT EXISTS optimal_parachute_q17d_name BOOLEAN DEFAULT false;
UPDATE cast_info ci
SET optimal_parachute_q17d_name = true
FROM name n
WHERE n.id = ci.person_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    n.name LIKE '%Bert%'
);

                
-------------
-- 17e
-------------

ALTER TABLE movie_companies ADD COLUMN IF NOT EXISTS optimal_parachute_q17e_company_name BOOLEAN DEFAULT false;
UPDATE movie_companies mc
SET optimal_parachute_q17e_company_name = true
FROM company_name cn
WHERE mc.company_id = cn.id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    cn.country_code ='[us]'
);

                
-------------
-- 17f
-------------

ALTER TABLE cast_info ADD COLUMN IF NOT EXISTS optimal_parachute_q17f_name BOOLEAN DEFAULT false;
UPDATE cast_info ci
SET optimal_parachute_q17f_name = true
FROM name n
WHERE n.id = ci.person_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    n.name LIKE '%B%'
);

                
-------------
-- 18a
-------------

ALTER TABLE cast_info ADD COLUMN IF NOT EXISTS optimal_parachute_q18a_name BOOLEAN DEFAULT false;
UPDATE cast_info ci
SET optimal_parachute_q18a_name = true
FROM name n
WHERE n.id = ci.person_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    n.gender = 'm' AND n.name LIKE '%Tim%'
);

                
-------------
-- 18b
-------------

ALTER TABLE cast_info ADD COLUMN IF NOT EXISTS optimal_parachute_q18b_name BOOLEAN DEFAULT false;
UPDATE cast_info ci
SET optimal_parachute_q18b_name = true
FROM name n
WHERE n.id = ci.person_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    n.gender = 'f'
);

                
-------------
-- 18c
-------------

ALTER TABLE cast_info ADD COLUMN IF NOT EXISTS optimal_parachute_q18c_name BOOLEAN DEFAULT false;
UPDATE cast_info ci
SET optimal_parachute_q18c_name = true
FROM name n
WHERE n.id = ci.person_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    n.gender = 'm'
);

                
-------------
-- 19a
-------------

ALTER TABLE cast_info ADD COLUMN IF NOT EXISTS optimal_parachute_q19a_name BOOLEAN DEFAULT false;
UPDATE cast_info ci
SET optimal_parachute_q19a_name = true
FROM name n
WHERE n.id = ci.person_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    n.gender ='f' AND n.name LIKE '%Ang%'
);

ALTER TABLE aka_name ADD COLUMN IF NOT EXISTS optimal_parachute_q19a_name BOOLEAN DEFAULT false;
UPDATE aka_name an
SET optimal_parachute_q19a_name = true
FROM name n
WHERE n.id = an.person_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    n.gender ='f' AND n.name LIKE '%Ang%'
);

ALTER TABLE title ADD COLUMN IF NOT EXISTS optimal_parachute_q19a_movie_info BOOLEAN DEFAULT false;
UPDATE title t
SET optimal_parachute_q19a_movie_info = true
FROM movie_info mi
WHERE t.id = mi.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    (mi.info LIKE 'Japan:%200%'
       OR mi.info LIKE 'USA:%200%')
);

ALTER TABLE movie_companies ADD COLUMN IF NOT EXISTS optimal_parachute_q19a_movie_info BOOLEAN DEFAULT false;
UPDATE movie_companies mc
SET optimal_parachute_q19a_movie_info = true
FROM movie_info mi
WHERE mc.movie_id = mi.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    (mi.info LIKE 'Japan:%200%'
       OR mi.info LIKE 'USA:%200%')
);

ALTER TABLE cast_info ADD COLUMN IF NOT EXISTS optimal_parachute_q19a_movie_info BOOLEAN DEFAULT false;
UPDATE cast_info ci
SET optimal_parachute_q19a_movie_info = true
FROM movie_info mi
WHERE mi.movie_id = ci.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    (mi.info LIKE 'Japan:%200%'
       OR mi.info LIKE 'USA:%200%')
);

ALTER TABLE info_type ADD COLUMN IF NOT EXISTS optimal_parachute_q19a_movie_info BOOLEAN DEFAULT false;
UPDATE info_type it
SET optimal_parachute_q19a_movie_info = true
FROM movie_info mi
WHERE it.id = mi.info_type_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    (mi.info LIKE 'Japan:%200%'
       OR mi.info LIKE 'USA:%200%')
);

                
-------------
-- 19b
-------------

ALTER TABLE movie_info ADD COLUMN IF NOT EXISTS optimal_parachute_q19b_title BOOLEAN DEFAULT false;
UPDATE movie_info mi
SET optimal_parachute_q19b_title = true
FROM title t
WHERE t.id = mi.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.title LIKE '%Kung%Fu%Panda%'
);

ALTER TABLE movie_companies ADD COLUMN IF NOT EXISTS optimal_parachute_q19b_title BOOLEAN DEFAULT false;
UPDATE movie_companies mc
SET optimal_parachute_q19b_title = true
FROM title t
WHERE t.id = mc.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.title LIKE '%Kung%Fu%Panda%'
);

ALTER TABLE cast_info ADD COLUMN IF NOT EXISTS optimal_parachute_q19b_title BOOLEAN DEFAULT false;
UPDATE cast_info ci
SET optimal_parachute_q19b_title = true
FROM title t
WHERE t.id = ci.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.title LIKE '%Kung%Fu%Panda%'
);

                
-------------
-- 19c
-------------

ALTER TABLE movie_info ADD COLUMN IF NOT EXISTS optimal_parachute_q19c_title BOOLEAN DEFAULT false;
UPDATE movie_info mi
SET optimal_parachute_q19c_title = true
FROM title t
WHERE t.id = mi.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2000
);

ALTER TABLE movie_companies ADD COLUMN IF NOT EXISTS optimal_parachute_q19c_title BOOLEAN DEFAULT false;
UPDATE movie_companies mc
SET optimal_parachute_q19c_title = true
FROM title t
WHERE t.id = mc.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2000
);

ALTER TABLE cast_info ADD COLUMN IF NOT EXISTS optimal_parachute_q19c_title BOOLEAN DEFAULT false;
UPDATE cast_info ci
SET optimal_parachute_q19c_title = true
FROM title t
WHERE t.id = ci.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2000
);

ALTER TABLE title ADD COLUMN IF NOT EXISTS optimal_parachute_q19c_movie_info BOOLEAN DEFAULT false;
UPDATE title t
SET optimal_parachute_q19c_movie_info = true
FROM movie_info mi
WHERE t.id = mi.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    (mi.info LIKE 'Japan:%200%'
       OR mi.info LIKE 'USA:%200%')
);

ALTER TABLE movie_companies ADD COLUMN IF NOT EXISTS optimal_parachute_q19c_movie_info BOOLEAN DEFAULT false;
UPDATE movie_companies mc
SET optimal_parachute_q19c_movie_info = true
FROM movie_info mi
WHERE mc.movie_id = mi.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    (mi.info LIKE 'Japan:%200%'
       OR mi.info LIKE 'USA:%200%')
);

ALTER TABLE cast_info ADD COLUMN IF NOT EXISTS optimal_parachute_q19c_movie_info BOOLEAN DEFAULT false;
UPDATE cast_info ci
SET optimal_parachute_q19c_movie_info = true
FROM movie_info mi
WHERE mi.movie_id = ci.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    (mi.info LIKE 'Japan:%200%'
       OR mi.info LIKE 'USA:%200%')
);

ALTER TABLE info_type ADD COLUMN IF NOT EXISTS optimal_parachute_q19c_movie_info BOOLEAN DEFAULT false;
UPDATE info_type it
SET optimal_parachute_q19c_movie_info = true
FROM movie_info mi
WHERE it.id = mi.info_type_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    (mi.info LIKE 'Japan:%200%'
       OR mi.info LIKE 'USA:%200%')
);

ALTER TABLE cast_info ADD COLUMN IF NOT EXISTS optimal_parachute_q19c_name BOOLEAN DEFAULT false;
UPDATE cast_info ci
SET optimal_parachute_q19c_name = true
FROM name n
WHERE n.id = ci.person_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    n.gender ='f' AND n.name LIKE '%An%'
);

ALTER TABLE aka_name ADD COLUMN IF NOT EXISTS optimal_parachute_q19c_name BOOLEAN DEFAULT false;
UPDATE aka_name an
SET optimal_parachute_q19c_name = true
FROM name n
WHERE n.id = an.person_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    n.gender ='f' AND n.name LIKE '%An%'
);

                
-------------
-- 19d
-------------

ALTER TABLE movie_info ADD COLUMN IF NOT EXISTS optimal_parachute_q19d_title BOOLEAN DEFAULT false;
UPDATE movie_info mi
SET optimal_parachute_q19d_title = true
FROM title t
WHERE t.id = mi.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2000
);

ALTER TABLE movie_companies ADD COLUMN IF NOT EXISTS optimal_parachute_q19d_title BOOLEAN DEFAULT false;
UPDATE movie_companies mc
SET optimal_parachute_q19d_title = true
FROM title t
WHERE t.id = mc.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2000
);

ALTER TABLE cast_info ADD COLUMN IF NOT EXISTS optimal_parachute_q19d_title BOOLEAN DEFAULT false;
UPDATE cast_info ci
SET optimal_parachute_q19d_title = true
FROM title t
WHERE t.id = ci.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2000
);

ALTER TABLE cast_info ADD COLUMN IF NOT EXISTS optimal_parachute_q19d_name BOOLEAN DEFAULT false;
UPDATE cast_info ci
SET optimal_parachute_q19d_name = true
FROM name n
WHERE n.id = ci.person_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    n.gender ='f'
);

ALTER TABLE aka_name ADD COLUMN IF NOT EXISTS optimal_parachute_q19d_name BOOLEAN DEFAULT false;
UPDATE aka_name an
SET optimal_parachute_q19d_name = true
FROM name n
WHERE n.id = an.person_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    n.gender ='f'
);

                
-------------
-- 20a
-------------

ALTER TABLE kind_type ADD COLUMN IF NOT EXISTS optimal_parachute_q20a_title BOOLEAN DEFAULT false;
UPDATE kind_type kt
SET optimal_parachute_q20a_title = true
FROM title t
WHERE kt.id = t.kind_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 1950
);

ALTER TABLE movie_keyword ADD COLUMN IF NOT EXISTS optimal_parachute_q20a_title BOOLEAN DEFAULT false;
UPDATE movie_keyword mk
SET optimal_parachute_q20a_title = true
FROM title t
WHERE t.id = mk.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 1950
);

ALTER TABLE cast_info ADD COLUMN IF NOT EXISTS optimal_parachute_q20a_title BOOLEAN DEFAULT false;
UPDATE cast_info ci
SET optimal_parachute_q20a_title = true
FROM title t
WHERE t.id = ci.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 1950
);

ALTER TABLE complete_cast ADD COLUMN IF NOT EXISTS optimal_parachute_q20a_title BOOLEAN DEFAULT false;
UPDATE complete_cast cc
SET optimal_parachute_q20a_title = true
FROM title t
WHERE t.id = cc.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 1950
);

                
-------------
-- 20b
-------------

ALTER TABLE kind_type ADD COLUMN IF NOT EXISTS optimal_parachute_q20b_title BOOLEAN DEFAULT false;
UPDATE kind_type kt
SET optimal_parachute_q20b_title = true
FROM title t
WHERE kt.id = t.kind_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2000
);

ALTER TABLE movie_keyword ADD COLUMN IF NOT EXISTS optimal_parachute_q20b_title BOOLEAN DEFAULT false;
UPDATE movie_keyword mk
SET optimal_parachute_q20b_title = true
FROM title t
WHERE t.id = mk.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2000
);

ALTER TABLE cast_info ADD COLUMN IF NOT EXISTS optimal_parachute_q20b_title BOOLEAN DEFAULT false;
UPDATE cast_info ci
SET optimal_parachute_q20b_title = true
FROM title t
WHERE t.id = ci.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2000
);

ALTER TABLE complete_cast ADD COLUMN IF NOT EXISTS optimal_parachute_q20b_title BOOLEAN DEFAULT false;
UPDATE complete_cast cc
SET optimal_parachute_q20b_title = true
FROM title t
WHERE t.id = cc.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2000
);

ALTER TABLE cast_info ADD COLUMN IF NOT EXISTS optimal_parachute_q20b_name BOOLEAN DEFAULT false;
UPDATE cast_info ci
SET optimal_parachute_q20b_name = true
FROM name n
WHERE n.id = ci.person_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    n.name LIKE '%Downey%Robert%'
);

                
-------------
-- 20c
-------------

ALTER TABLE kind_type ADD COLUMN IF NOT EXISTS optimal_parachute_q20c_title BOOLEAN DEFAULT false;
UPDATE kind_type kt
SET optimal_parachute_q20c_title = true
FROM title t
WHERE kt.id = t.kind_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2000
);

ALTER TABLE movie_keyword ADD COLUMN IF NOT EXISTS optimal_parachute_q20c_title BOOLEAN DEFAULT false;
UPDATE movie_keyword mk
SET optimal_parachute_q20c_title = true
FROM title t
WHERE t.id = mk.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2000
);

ALTER TABLE cast_info ADD COLUMN IF NOT EXISTS optimal_parachute_q20c_title BOOLEAN DEFAULT false;
UPDATE cast_info ci
SET optimal_parachute_q20c_title = true
FROM title t
WHERE t.id = ci.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2000
);

ALTER TABLE complete_cast ADD COLUMN IF NOT EXISTS optimal_parachute_q20c_title BOOLEAN DEFAULT false;
UPDATE complete_cast cc
SET optimal_parachute_q20c_title = true
FROM title t
WHERE t.id = cc.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2000
);

                
-------------
-- 21a
-------------

ALTER TABLE movie_link ADD COLUMN IF NOT EXISTS optimal_parachute_q21a_link_type BOOLEAN DEFAULT false;
UPDATE movie_link ml
SET optimal_parachute_q21a_link_type = true
FROM link_type lt
WHERE lt.id = ml.link_type_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    lt.link LIKE '%follow%'
);

ALTER TABLE movie_companies ADD COLUMN IF NOT EXISTS optimal_parachute_q21a_company_name BOOLEAN DEFAULT false;
UPDATE movie_companies mc
SET optimal_parachute_q21a_company_name = true
FROM company_name cn
WHERE mc.company_id = cn.id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    cn.country_code !='[pl]' AND (cn.name LIKE '%Film%'
       OR cn.name LIKE '%Warner%')
);

                
-------------
-- 21b
-------------

ALTER TABLE movie_link ADD COLUMN IF NOT EXISTS optimal_parachute_q21b_link_type BOOLEAN DEFAULT false;
UPDATE movie_link ml
SET optimal_parachute_q21b_link_type = true
FROM link_type lt
WHERE lt.id = ml.link_type_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    lt.link LIKE '%follow%'
);

ALTER TABLE movie_companies ADD COLUMN IF NOT EXISTS optimal_parachute_q21b_company_name BOOLEAN DEFAULT false;
UPDATE movie_companies mc
SET optimal_parachute_q21b_company_name = true
FROM company_name cn
WHERE mc.company_id = cn.id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    cn.country_code !='[pl]' AND (cn.name LIKE '%Film%'
       OR cn.name LIKE '%Warner%')
);

                
-------------
-- 21c
-------------

ALTER TABLE movie_link ADD COLUMN IF NOT EXISTS optimal_parachute_q21c_link_type BOOLEAN DEFAULT false;
UPDATE movie_link ml
SET optimal_parachute_q21c_link_type = true
FROM link_type lt
WHERE lt.id = ml.link_type_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    lt.link LIKE '%follow%'
);

ALTER TABLE movie_companies ADD COLUMN IF NOT EXISTS optimal_parachute_q21c_company_name BOOLEAN DEFAULT false;
UPDATE movie_companies mc
SET optimal_parachute_q21c_company_name = true
FROM company_name cn
WHERE mc.company_id = cn.id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    cn.country_code !='[pl]' AND (cn.name LIKE '%Film%'
       OR cn.name LIKE '%Warner%')
);

                
-------------
-- 22a
-------------

ALTER TABLE kind_type ADD COLUMN IF NOT EXISTS optimal_parachute_q22a_title BOOLEAN DEFAULT false;
UPDATE kind_type kt
SET optimal_parachute_q22a_title = true
FROM title t
WHERE kt.id = t.kind_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2008
);

ALTER TABLE movie_info ADD COLUMN IF NOT EXISTS optimal_parachute_q22a_title BOOLEAN DEFAULT false;
UPDATE movie_info mi
SET optimal_parachute_q22a_title = true
FROM title t
WHERE t.id = mi.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2008
);

ALTER TABLE movie_keyword ADD COLUMN IF NOT EXISTS optimal_parachute_q22a_title BOOLEAN DEFAULT false;
UPDATE movie_keyword mk
SET optimal_parachute_q22a_title = true
FROM title t
WHERE t.id = mk.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2008
);

ALTER TABLE movie_info_idx ADD COLUMN IF NOT EXISTS optimal_parachute_q22a_title BOOLEAN DEFAULT false;
UPDATE movie_info_idx mi_idx
SET optimal_parachute_q22a_title = true
FROM title t
WHERE t.id = mi_idx.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2008
);

ALTER TABLE movie_companies ADD COLUMN IF NOT EXISTS optimal_parachute_q22a_title BOOLEAN DEFAULT false;
UPDATE movie_companies mc
SET optimal_parachute_q22a_title = true
FROM title t
WHERE t.id = mc.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2008
);

ALTER TABLE title ADD COLUMN IF NOT EXISTS optimal_parachute_q22a_movie_companies BOOLEAN DEFAULT false;
UPDATE title t
SET optimal_parachute_q22a_movie_companies = true
FROM movie_companies mc
WHERE t.id = mc.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    mc.note NOT LIKE '%(USA)%' AND mc.note LIKE '%(200%)%'
);

ALTER TABLE movie_keyword ADD COLUMN IF NOT EXISTS optimal_parachute_q22a_movie_companies BOOLEAN DEFAULT false;
UPDATE movie_keyword mk
SET optimal_parachute_q22a_movie_companies = true
FROM movie_companies mc
WHERE mk.movie_id = mc.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    mc.note NOT LIKE '%(USA)%' AND mc.note LIKE '%(200%)%'
);

ALTER TABLE movie_info ADD COLUMN IF NOT EXISTS optimal_parachute_q22a_movie_companies BOOLEAN DEFAULT false;
UPDATE movie_info mi
SET optimal_parachute_q22a_movie_companies = true
FROM movie_companies mc
WHERE mi.movie_id = mc.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    mc.note NOT LIKE '%(USA)%' AND mc.note LIKE '%(200%)%'
);

ALTER TABLE movie_info_idx ADD COLUMN IF NOT EXISTS optimal_parachute_q22a_movie_companies BOOLEAN DEFAULT false;
UPDATE movie_info_idx mi_idx
SET optimal_parachute_q22a_movie_companies = true
FROM movie_companies mc
WHERE mc.movie_id = mi_idx.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    mc.note NOT LIKE '%(USA)%' AND mc.note LIKE '%(200%)%'
);

ALTER TABLE company_type ADD COLUMN IF NOT EXISTS optimal_parachute_q22a_movie_companies BOOLEAN DEFAULT false;
UPDATE company_type ct
SET optimal_parachute_q22a_movie_companies = true
FROM movie_companies mc
WHERE ct.id = mc.company_type_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    mc.note NOT LIKE '%(USA)%' AND mc.note LIKE '%(200%)%'
);

ALTER TABLE company_name ADD COLUMN IF NOT EXISTS optimal_parachute_q22a_movie_companies BOOLEAN DEFAULT false;
UPDATE company_name cn
SET optimal_parachute_q22a_movie_companies = true
FROM movie_companies mc
WHERE cn.id = mc.company_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    mc.note NOT LIKE '%(USA)%' AND mc.note LIKE '%(200%)%'
);

ALTER TABLE movie_companies ADD COLUMN IF NOT EXISTS optimal_parachute_q22a_company_name BOOLEAN DEFAULT false;
UPDATE movie_companies mc
SET optimal_parachute_q22a_company_name = true
FROM company_name cn
WHERE cn.id = mc.company_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    cn.country_code != '[us]'
);

                
-------------
-- 22b
-------------

ALTER TABLE kind_type ADD COLUMN IF NOT EXISTS optimal_parachute_q22b_title BOOLEAN DEFAULT false;
UPDATE kind_type kt
SET optimal_parachute_q22b_title = true
FROM title t
WHERE kt.id = t.kind_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2009
);

ALTER TABLE movie_info ADD COLUMN IF NOT EXISTS optimal_parachute_q22b_title BOOLEAN DEFAULT false;
UPDATE movie_info mi
SET optimal_parachute_q22b_title = true
FROM title t
WHERE t.id = mi.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2009
);

ALTER TABLE movie_keyword ADD COLUMN IF NOT EXISTS optimal_parachute_q22b_title BOOLEAN DEFAULT false;
UPDATE movie_keyword mk
SET optimal_parachute_q22b_title = true
FROM title t
WHERE t.id = mk.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2009
);

ALTER TABLE movie_info_idx ADD COLUMN IF NOT EXISTS optimal_parachute_q22b_title BOOLEAN DEFAULT false;
UPDATE movie_info_idx mi_idx
SET optimal_parachute_q22b_title = true
FROM title t
WHERE t.id = mi_idx.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2009
);

ALTER TABLE movie_companies ADD COLUMN IF NOT EXISTS optimal_parachute_q22b_title BOOLEAN DEFAULT false;
UPDATE movie_companies mc
SET optimal_parachute_q22b_title = true
FROM title t
WHERE t.id = mc.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2009
);

ALTER TABLE title ADD COLUMN IF NOT EXISTS optimal_parachute_q22b_movie_companies BOOLEAN DEFAULT false;
UPDATE title t
SET optimal_parachute_q22b_movie_companies = true
FROM movie_companies mc
WHERE t.id = mc.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    mc.note NOT LIKE '%(USA)%' AND mc.note LIKE '%(200%)%'
);

ALTER TABLE movie_keyword ADD COLUMN IF NOT EXISTS optimal_parachute_q22b_movie_companies BOOLEAN DEFAULT false;
UPDATE movie_keyword mk
SET optimal_parachute_q22b_movie_companies = true
FROM movie_companies mc
WHERE mk.movie_id = mc.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    mc.note NOT LIKE '%(USA)%' AND mc.note LIKE '%(200%)%'
);

ALTER TABLE movie_info ADD COLUMN IF NOT EXISTS optimal_parachute_q22b_movie_companies BOOLEAN DEFAULT false;
UPDATE movie_info mi
SET optimal_parachute_q22b_movie_companies = true
FROM movie_companies mc
WHERE mi.movie_id = mc.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    mc.note NOT LIKE '%(USA)%' AND mc.note LIKE '%(200%)%'
);

ALTER TABLE movie_info_idx ADD COLUMN IF NOT EXISTS optimal_parachute_q22b_movie_companies BOOLEAN DEFAULT false;
UPDATE movie_info_idx mi_idx
SET optimal_parachute_q22b_movie_companies = true
FROM movie_companies mc
WHERE mc.movie_id = mi_idx.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    mc.note NOT LIKE '%(USA)%' AND mc.note LIKE '%(200%)%'
);

ALTER TABLE company_type ADD COLUMN IF NOT EXISTS optimal_parachute_q22b_movie_companies BOOLEAN DEFAULT false;
UPDATE company_type ct
SET optimal_parachute_q22b_movie_companies = true
FROM movie_companies mc
WHERE ct.id = mc.company_type_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    mc.note NOT LIKE '%(USA)%' AND mc.note LIKE '%(200%)%'
);

ALTER TABLE company_name ADD COLUMN IF NOT EXISTS optimal_parachute_q22b_movie_companies BOOLEAN DEFAULT false;
UPDATE company_name cn
SET optimal_parachute_q22b_movie_companies = true
FROM movie_companies mc
WHERE cn.id = mc.company_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    mc.note NOT LIKE '%(USA)%' AND mc.note LIKE '%(200%)%'
);

ALTER TABLE movie_companies ADD COLUMN IF NOT EXISTS optimal_parachute_q22b_company_name BOOLEAN DEFAULT false;
UPDATE movie_companies mc
SET optimal_parachute_q22b_company_name = true
FROM company_name cn
WHERE cn.id = mc.company_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    cn.country_code != '[us]'
);

                
-------------
-- 22c
-------------

ALTER TABLE kind_type ADD COLUMN IF NOT EXISTS optimal_parachute_q22c_title BOOLEAN DEFAULT false;
UPDATE kind_type kt
SET optimal_parachute_q22c_title = true
FROM title t
WHERE kt.id = t.kind_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2005
);

ALTER TABLE movie_info ADD COLUMN IF NOT EXISTS optimal_parachute_q22c_title BOOLEAN DEFAULT false;
UPDATE movie_info mi
SET optimal_parachute_q22c_title = true
FROM title t
WHERE t.id = mi.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2005
);

ALTER TABLE movie_keyword ADD COLUMN IF NOT EXISTS optimal_parachute_q22c_title BOOLEAN DEFAULT false;
UPDATE movie_keyword mk
SET optimal_parachute_q22c_title = true
FROM title t
WHERE t.id = mk.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2005
);

ALTER TABLE movie_info_idx ADD COLUMN IF NOT EXISTS optimal_parachute_q22c_title BOOLEAN DEFAULT false;
UPDATE movie_info_idx mi_idx
SET optimal_parachute_q22c_title = true
FROM title t
WHERE t.id = mi_idx.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2005
);

ALTER TABLE movie_companies ADD COLUMN IF NOT EXISTS optimal_parachute_q22c_title BOOLEAN DEFAULT false;
UPDATE movie_companies mc
SET optimal_parachute_q22c_title = true
FROM title t
WHERE t.id = mc.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2005
);

ALTER TABLE title ADD COLUMN IF NOT EXISTS optimal_parachute_q22c_movie_companies BOOLEAN DEFAULT false;
UPDATE title t
SET optimal_parachute_q22c_movie_companies = true
FROM movie_companies mc
WHERE t.id = mc.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    mc.note NOT LIKE '%(USA)%' AND mc.note LIKE '%(200%)%'
);

ALTER TABLE movie_keyword ADD COLUMN IF NOT EXISTS optimal_parachute_q22c_movie_companies BOOLEAN DEFAULT false;
UPDATE movie_keyword mk
SET optimal_parachute_q22c_movie_companies = true
FROM movie_companies mc
WHERE mk.movie_id = mc.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    mc.note NOT LIKE '%(USA)%' AND mc.note LIKE '%(200%)%'
);

ALTER TABLE movie_info ADD COLUMN IF NOT EXISTS optimal_parachute_q22c_movie_companies BOOLEAN DEFAULT false;
UPDATE movie_info mi
SET optimal_parachute_q22c_movie_companies = true
FROM movie_companies mc
WHERE mi.movie_id = mc.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    mc.note NOT LIKE '%(USA)%' AND mc.note LIKE '%(200%)%'
);

ALTER TABLE movie_info_idx ADD COLUMN IF NOT EXISTS optimal_parachute_q22c_movie_companies BOOLEAN DEFAULT false;
UPDATE movie_info_idx mi_idx
SET optimal_parachute_q22c_movie_companies = true
FROM movie_companies mc
WHERE mc.movie_id = mi_idx.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    mc.note NOT LIKE '%(USA)%' AND mc.note LIKE '%(200%)%'
);

ALTER TABLE company_type ADD COLUMN IF NOT EXISTS optimal_parachute_q22c_movie_companies BOOLEAN DEFAULT false;
UPDATE company_type ct
SET optimal_parachute_q22c_movie_companies = true
FROM movie_companies mc
WHERE ct.id = mc.company_type_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    mc.note NOT LIKE '%(USA)%' AND mc.note LIKE '%(200%)%'
);

ALTER TABLE company_name ADD COLUMN IF NOT EXISTS optimal_parachute_q22c_movie_companies BOOLEAN DEFAULT false;
UPDATE company_name cn
SET optimal_parachute_q22c_movie_companies = true
FROM movie_companies mc
WHERE cn.id = mc.company_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    mc.note NOT LIKE '%(USA)%' AND mc.note LIKE '%(200%)%'
);

ALTER TABLE movie_companies ADD COLUMN IF NOT EXISTS optimal_parachute_q22c_company_name BOOLEAN DEFAULT false;
UPDATE movie_companies mc
SET optimal_parachute_q22c_company_name = true
FROM company_name cn
WHERE cn.id = mc.company_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    cn.country_code != '[us]'
);

                
-------------
-- 22d
-------------

ALTER TABLE kind_type ADD COLUMN IF NOT EXISTS optimal_parachute_q22d_title BOOLEAN DEFAULT false;
UPDATE kind_type kt
SET optimal_parachute_q22d_title = true
FROM title t
WHERE kt.id = t.kind_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2005
);

ALTER TABLE movie_info ADD COLUMN IF NOT EXISTS optimal_parachute_q22d_title BOOLEAN DEFAULT false;
UPDATE movie_info mi
SET optimal_parachute_q22d_title = true
FROM title t
WHERE t.id = mi.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2005
);

ALTER TABLE movie_keyword ADD COLUMN IF NOT EXISTS optimal_parachute_q22d_title BOOLEAN DEFAULT false;
UPDATE movie_keyword mk
SET optimal_parachute_q22d_title = true
FROM title t
WHERE t.id = mk.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2005
);

ALTER TABLE movie_info_idx ADD COLUMN IF NOT EXISTS optimal_parachute_q22d_title BOOLEAN DEFAULT false;
UPDATE movie_info_idx mi_idx
SET optimal_parachute_q22d_title = true
FROM title t
WHERE t.id = mi_idx.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2005
);

ALTER TABLE movie_companies ADD COLUMN IF NOT EXISTS optimal_parachute_q22d_title BOOLEAN DEFAULT false;
UPDATE movie_companies mc
SET optimal_parachute_q22d_title = true
FROM title t
WHERE t.id = mc.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2005
);

ALTER TABLE movie_companies ADD COLUMN IF NOT EXISTS optimal_parachute_q22d_company_name BOOLEAN DEFAULT false;
UPDATE movie_companies mc
SET optimal_parachute_q22d_company_name = true
FROM company_name cn
WHERE cn.id = mc.company_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    cn.country_code != '[us]'
);

                
-------------
-- 23a
-------------

ALTER TABLE kind_type ADD COLUMN IF NOT EXISTS optimal_parachute_q23a_title BOOLEAN DEFAULT false;
UPDATE kind_type kt
SET optimal_parachute_q23a_title = true
FROM title t
WHERE kt.id = t.kind_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2000
);

ALTER TABLE movie_info ADD COLUMN IF NOT EXISTS optimal_parachute_q23a_title BOOLEAN DEFAULT false;
UPDATE movie_info mi
SET optimal_parachute_q23a_title = true
FROM title t
WHERE t.id = mi.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2000
);

ALTER TABLE movie_keyword ADD COLUMN IF NOT EXISTS optimal_parachute_q23a_title BOOLEAN DEFAULT false;
UPDATE movie_keyword mk
SET optimal_parachute_q23a_title = true
FROM title t
WHERE t.id = mk.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2000
);

ALTER TABLE movie_companies ADD COLUMN IF NOT EXISTS optimal_parachute_q23a_title BOOLEAN DEFAULT false;
UPDATE movie_companies mc
SET optimal_parachute_q23a_title = true
FROM title t
WHERE t.id = mc.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2000
);

ALTER TABLE complete_cast ADD COLUMN IF NOT EXISTS optimal_parachute_q23a_title BOOLEAN DEFAULT false;
UPDATE complete_cast cc
SET optimal_parachute_q23a_title = true
FROM title t
WHERE t.id = cc.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2000
);

ALTER TABLE title ADD COLUMN IF NOT EXISTS optimal_parachute_q23a_movie_info BOOLEAN DEFAULT false;
UPDATE title t
SET optimal_parachute_q23a_movie_info = true
FROM movie_info mi
WHERE t.id = mi.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    mi.note LIKE '%internet%' AND (mi.info LIKE 'USA:% 199%'
       OR mi.info LIKE 'USA:% 200%')
);

ALTER TABLE movie_keyword ADD COLUMN IF NOT EXISTS optimal_parachute_q23a_movie_info BOOLEAN DEFAULT false;
UPDATE movie_keyword mk
SET optimal_parachute_q23a_movie_info = true
FROM movie_info mi
WHERE mk.movie_id = mi.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    mi.note LIKE '%internet%' AND (mi.info LIKE 'USA:% 199%'
       OR mi.info LIKE 'USA:% 200%')
);

ALTER TABLE movie_companies ADD COLUMN IF NOT EXISTS optimal_parachute_q23a_movie_info BOOLEAN DEFAULT false;
UPDATE movie_companies mc
SET optimal_parachute_q23a_movie_info = true
FROM movie_info mi
WHERE mi.movie_id = mc.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    mi.note LIKE '%internet%' AND (mi.info LIKE 'USA:% 199%'
       OR mi.info LIKE 'USA:% 200%')
);

ALTER TABLE complete_cast ADD COLUMN IF NOT EXISTS optimal_parachute_q23a_movie_info BOOLEAN DEFAULT false;
UPDATE complete_cast cc
SET optimal_parachute_q23a_movie_info = true
FROM movie_info mi
WHERE mi.movie_id = cc.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    mi.note LIKE '%internet%' AND (mi.info LIKE 'USA:% 199%'
       OR mi.info LIKE 'USA:% 200%')
);

ALTER TABLE info_type ADD COLUMN IF NOT EXISTS optimal_parachute_q23a_movie_info BOOLEAN DEFAULT false;
UPDATE info_type it1
SET optimal_parachute_q23a_movie_info = true
FROM movie_info mi
WHERE it1.id = mi.info_type_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    mi.note LIKE '%internet%' AND (mi.info LIKE 'USA:% 199%'
       OR mi.info LIKE 'USA:% 200%')
);

                
-------------
-- 23b
-------------

                
-------------
-- 23c
-------------

ALTER TABLE kind_type ADD COLUMN IF NOT EXISTS optimal_parachute_q23c_title BOOLEAN DEFAULT false;
UPDATE kind_type kt
SET optimal_parachute_q23c_title = true
FROM title t
WHERE kt.id = t.kind_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 1990
);

ALTER TABLE movie_info ADD COLUMN IF NOT EXISTS optimal_parachute_q23c_title BOOLEAN DEFAULT false;
UPDATE movie_info mi
SET optimal_parachute_q23c_title = true
FROM title t
WHERE t.id = mi.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 1990
);

ALTER TABLE movie_keyword ADD COLUMN IF NOT EXISTS optimal_parachute_q23c_title BOOLEAN DEFAULT false;
UPDATE movie_keyword mk
SET optimal_parachute_q23c_title = true
FROM title t
WHERE t.id = mk.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 1990
);

ALTER TABLE movie_companies ADD COLUMN IF NOT EXISTS optimal_parachute_q23c_title BOOLEAN DEFAULT false;
UPDATE movie_companies mc
SET optimal_parachute_q23c_title = true
FROM title t
WHERE t.id = mc.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 1990
);

ALTER TABLE complete_cast ADD COLUMN IF NOT EXISTS optimal_parachute_q23c_title BOOLEAN DEFAULT false;
UPDATE complete_cast cc
SET optimal_parachute_q23c_title = true
FROM title t
WHERE t.id = cc.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 1990
);

ALTER TABLE title ADD COLUMN IF NOT EXISTS optimal_parachute_q23c_movie_info BOOLEAN DEFAULT false;
UPDATE title t
SET optimal_parachute_q23c_movie_info = true
FROM movie_info mi
WHERE t.id = mi.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    mi.note LIKE '%internet%' AND (mi.info LIKE 'USA:% 199%'
       OR mi.info LIKE 'USA:% 200%')
);

ALTER TABLE movie_keyword ADD COLUMN IF NOT EXISTS optimal_parachute_q23c_movie_info BOOLEAN DEFAULT false;
UPDATE movie_keyword mk
SET optimal_parachute_q23c_movie_info = true
FROM movie_info mi
WHERE mk.movie_id = mi.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    mi.note LIKE '%internet%' AND (mi.info LIKE 'USA:% 199%'
       OR mi.info LIKE 'USA:% 200%')
);

ALTER TABLE movie_companies ADD COLUMN IF NOT EXISTS optimal_parachute_q23c_movie_info BOOLEAN DEFAULT false;
UPDATE movie_companies mc
SET optimal_parachute_q23c_movie_info = true
FROM movie_info mi
WHERE mi.movie_id = mc.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    mi.note LIKE '%internet%' AND (mi.info LIKE 'USA:% 199%'
       OR mi.info LIKE 'USA:% 200%')
);

ALTER TABLE complete_cast ADD COLUMN IF NOT EXISTS optimal_parachute_q23c_movie_info BOOLEAN DEFAULT false;
UPDATE complete_cast cc
SET optimal_parachute_q23c_movie_info = true
FROM movie_info mi
WHERE mi.movie_id = cc.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    mi.note LIKE '%internet%' AND (mi.info LIKE 'USA:% 199%'
       OR mi.info LIKE 'USA:% 200%')
);

ALTER TABLE info_type ADD COLUMN IF NOT EXISTS optimal_parachute_q23c_movie_info BOOLEAN DEFAULT false;
UPDATE info_type it1
SET optimal_parachute_q23c_movie_info = true
FROM movie_info mi
WHERE it1.id = mi.info_type_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    mi.note LIKE '%internet%' AND (mi.info LIKE 'USA:% 199%'
       OR mi.info LIKE 'USA:% 200%')
);

                
-------------
-- 24a
-------------

ALTER TABLE movie_info ADD COLUMN IF NOT EXISTS optimal_parachute_q24a_title BOOLEAN DEFAULT false;
UPDATE movie_info mi
SET optimal_parachute_q24a_title = true
FROM title t
WHERE t.id = mi.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2010
);

ALTER TABLE movie_companies ADD COLUMN IF NOT EXISTS optimal_parachute_q24a_title BOOLEAN DEFAULT false;
UPDATE movie_companies mc
SET optimal_parachute_q24a_title = true
FROM title t
WHERE t.id = mc.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2010
);

ALTER TABLE cast_info ADD COLUMN IF NOT EXISTS optimal_parachute_q24a_title BOOLEAN DEFAULT false;
UPDATE cast_info ci
SET optimal_parachute_q24a_title = true
FROM title t
WHERE t.id = ci.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2010
);

ALTER TABLE movie_keyword ADD COLUMN IF NOT EXISTS optimal_parachute_q24a_title BOOLEAN DEFAULT false;
UPDATE movie_keyword mk
SET optimal_parachute_q24a_title = true
FROM title t
WHERE t.id = mk.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2010
);

ALTER TABLE title ADD COLUMN IF NOT EXISTS optimal_parachute_q24a_movie_info BOOLEAN DEFAULT false;
UPDATE title t
SET optimal_parachute_q24a_movie_info = true
FROM movie_info mi
WHERE t.id = mi.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    (mi.info LIKE 'Japan:%201%'
       OR mi.info LIKE 'USA:%201%')
);

ALTER TABLE movie_companies ADD COLUMN IF NOT EXISTS optimal_parachute_q24a_movie_info BOOLEAN DEFAULT false;
UPDATE movie_companies mc
SET optimal_parachute_q24a_movie_info = true
FROM movie_info mi
WHERE mc.movie_id = mi.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    (mi.info LIKE 'Japan:%201%'
       OR mi.info LIKE 'USA:%201%')
);

ALTER TABLE cast_info ADD COLUMN IF NOT EXISTS optimal_parachute_q24a_movie_info BOOLEAN DEFAULT false;
UPDATE cast_info ci
SET optimal_parachute_q24a_movie_info = true
FROM movie_info mi
WHERE mi.movie_id = ci.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    (mi.info LIKE 'Japan:%201%'
       OR mi.info LIKE 'USA:%201%')
);

ALTER TABLE movie_keyword ADD COLUMN IF NOT EXISTS optimal_parachute_q24a_movie_info BOOLEAN DEFAULT false;
UPDATE movie_keyword mk
SET optimal_parachute_q24a_movie_info = true
FROM movie_info mi
WHERE mi.movie_id = mk.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    (mi.info LIKE 'Japan:%201%'
       OR mi.info LIKE 'USA:%201%')
);

ALTER TABLE info_type ADD COLUMN IF NOT EXISTS optimal_parachute_q24a_movie_info BOOLEAN DEFAULT false;
UPDATE info_type it
SET optimal_parachute_q24a_movie_info = true
FROM movie_info mi
WHERE it.id = mi.info_type_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    (mi.info LIKE 'Japan:%201%'
       OR mi.info LIKE 'USA:%201%')
);

ALTER TABLE cast_info ADD COLUMN IF NOT EXISTS optimal_parachute_q24a_name BOOLEAN DEFAULT false;
UPDATE cast_info ci
SET optimal_parachute_q24a_name = true
FROM name n
WHERE n.id = ci.person_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    n.gender ='f' AND n.name LIKE '%An%'
);

ALTER TABLE aka_name ADD COLUMN IF NOT EXISTS optimal_parachute_q24a_name BOOLEAN DEFAULT false;
UPDATE aka_name an
SET optimal_parachute_q24a_name = true
FROM name n
WHERE n.id = an.person_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    n.gender ='f' AND n.name LIKE '%An%'
);

                
-------------
-- 24b
-------------

ALTER TABLE movie_info ADD COLUMN IF NOT EXISTS optimal_parachute_q24b_title BOOLEAN DEFAULT false;
UPDATE movie_info mi
SET optimal_parachute_q24b_title = true
FROM title t
WHERE t.id = mi.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2010 AND t.title LIKE 'Kung Fu Panda%'
);

ALTER TABLE movie_companies ADD COLUMN IF NOT EXISTS optimal_parachute_q24b_title BOOLEAN DEFAULT false;
UPDATE movie_companies mc
SET optimal_parachute_q24b_title = true
FROM title t
WHERE t.id = mc.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2010 AND t.title LIKE 'Kung Fu Panda%'
);

ALTER TABLE cast_info ADD COLUMN IF NOT EXISTS optimal_parachute_q24b_title BOOLEAN DEFAULT false;
UPDATE cast_info ci
SET optimal_parachute_q24b_title = true
FROM title t
WHERE t.id = ci.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2010 AND t.title LIKE 'Kung Fu Panda%'
);

ALTER TABLE movie_keyword ADD COLUMN IF NOT EXISTS optimal_parachute_q24b_title BOOLEAN DEFAULT false;
UPDATE movie_keyword mk
SET optimal_parachute_q24b_title = true
FROM title t
WHERE t.id = mk.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2010 AND t.title LIKE 'Kung Fu Panda%'
);

                
-------------
-- 25a
-------------

ALTER TABLE movie_info_idx ADD COLUMN IF NOT EXISTS optimal_parachute_q25a_info_type BOOLEAN DEFAULT false;
UPDATE movie_info_idx mi_idx
SET optimal_parachute_q25a_info_type = true
FROM info_type it2
WHERE it2.id = mi_idx.info_type_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    it2.info = 'votes'
);

ALTER TABLE cast_info ADD COLUMN IF NOT EXISTS optimal_parachute_q25a_name BOOLEAN DEFAULT false;
UPDATE cast_info ci
SET optimal_parachute_q25a_name = true
FROM name n
WHERE n.id = ci.person_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    n.gender = 'm'
);

                
-------------
-- 25b
-------------

ALTER TABLE movie_info ADD COLUMN IF NOT EXISTS optimal_parachute_q25b_title BOOLEAN DEFAULT false;
UPDATE movie_info mi
SET optimal_parachute_q25b_title = true
FROM title t
WHERE t.id = mi.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2010 AND t.title LIKE 'Vampire%'
);

ALTER TABLE movie_info_idx ADD COLUMN IF NOT EXISTS optimal_parachute_q25b_title BOOLEAN DEFAULT false;
UPDATE movie_info_idx mi_idx
SET optimal_parachute_q25b_title = true
FROM title t
WHERE t.id = mi_idx.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2010 AND t.title LIKE 'Vampire%'
);

ALTER TABLE cast_info ADD COLUMN IF NOT EXISTS optimal_parachute_q25b_title BOOLEAN DEFAULT false;
UPDATE cast_info ci
SET optimal_parachute_q25b_title = true
FROM title t
WHERE t.id = ci.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2010 AND t.title LIKE 'Vampire%'
);

ALTER TABLE movie_keyword ADD COLUMN IF NOT EXISTS optimal_parachute_q25b_title BOOLEAN DEFAULT false;
UPDATE movie_keyword mk
SET optimal_parachute_q25b_title = true
FROM title t
WHERE t.id = mk.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2010 AND t.title LIKE 'Vampire%'
);

                
-------------
-- 25c
-------------

ALTER TABLE cast_info ADD COLUMN IF NOT EXISTS optimal_parachute_q25c_name BOOLEAN DEFAULT false;
UPDATE cast_info ci
SET optimal_parachute_q25c_name = true
FROM name n
WHERE n.id = ci.person_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    n.gender = 'm'
);

                
-------------
-- 26a
-------------

ALTER TABLE kind_type ADD COLUMN IF NOT EXISTS optimal_parachute_q26a_title BOOLEAN DEFAULT false;
UPDATE kind_type kt
SET optimal_parachute_q26a_title = true
FROM title t
WHERE kt.id = t.kind_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2000
);

ALTER TABLE movie_keyword ADD COLUMN IF NOT EXISTS optimal_parachute_q26a_title BOOLEAN DEFAULT false;
UPDATE movie_keyword mk
SET optimal_parachute_q26a_title = true
FROM title t
WHERE t.id = mk.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2000
);

ALTER TABLE cast_info ADD COLUMN IF NOT EXISTS optimal_parachute_q26a_title BOOLEAN DEFAULT false;
UPDATE cast_info ci
SET optimal_parachute_q26a_title = true
FROM title t
WHERE t.id = ci.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2000
);

ALTER TABLE complete_cast ADD COLUMN IF NOT EXISTS optimal_parachute_q26a_title BOOLEAN DEFAULT false;
UPDATE complete_cast cc
SET optimal_parachute_q26a_title = true
FROM title t
WHERE t.id = cc.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2000
);

ALTER TABLE movie_info_idx ADD COLUMN IF NOT EXISTS optimal_parachute_q26a_title BOOLEAN DEFAULT false;
UPDATE movie_info_idx mi_idx
SET optimal_parachute_q26a_title = true
FROM title t
WHERE t.id = mi_idx.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2000
);

                
-------------
-- 26b
-------------

ALTER TABLE kind_type ADD COLUMN IF NOT EXISTS optimal_parachute_q26b_title BOOLEAN DEFAULT false;
UPDATE kind_type kt
SET optimal_parachute_q26b_title = true
FROM title t
WHERE kt.id = t.kind_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2005
);

ALTER TABLE movie_keyword ADD COLUMN IF NOT EXISTS optimal_parachute_q26b_title BOOLEAN DEFAULT false;
UPDATE movie_keyword mk
SET optimal_parachute_q26b_title = true
FROM title t
WHERE t.id = mk.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2005
);

ALTER TABLE cast_info ADD COLUMN IF NOT EXISTS optimal_parachute_q26b_title BOOLEAN DEFAULT false;
UPDATE cast_info ci
SET optimal_parachute_q26b_title = true
FROM title t
WHERE t.id = ci.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2005
);

ALTER TABLE complete_cast ADD COLUMN IF NOT EXISTS optimal_parachute_q26b_title BOOLEAN DEFAULT false;
UPDATE complete_cast cc
SET optimal_parachute_q26b_title = true
FROM title t
WHERE t.id = cc.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2005
);

ALTER TABLE movie_info_idx ADD COLUMN IF NOT EXISTS optimal_parachute_q26b_title BOOLEAN DEFAULT false;
UPDATE movie_info_idx mi_idx
SET optimal_parachute_q26b_title = true
FROM title t
WHERE t.id = mi_idx.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2005
);

                
-------------
-- 26c
-------------

ALTER TABLE kind_type ADD COLUMN IF NOT EXISTS optimal_parachute_q26c_title BOOLEAN DEFAULT false;
UPDATE kind_type kt
SET optimal_parachute_q26c_title = true
FROM title t
WHERE kt.id = t.kind_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2000
);

ALTER TABLE movie_keyword ADD COLUMN IF NOT EXISTS optimal_parachute_q26c_title BOOLEAN DEFAULT false;
UPDATE movie_keyword mk
SET optimal_parachute_q26c_title = true
FROM title t
WHERE t.id = mk.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2000
);

ALTER TABLE cast_info ADD COLUMN IF NOT EXISTS optimal_parachute_q26c_title BOOLEAN DEFAULT false;
UPDATE cast_info ci
SET optimal_parachute_q26c_title = true
FROM title t
WHERE t.id = ci.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2000
);

ALTER TABLE complete_cast ADD COLUMN IF NOT EXISTS optimal_parachute_q26c_title BOOLEAN DEFAULT false;
UPDATE complete_cast cc
SET optimal_parachute_q26c_title = true
FROM title t
WHERE t.id = cc.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2000
);

ALTER TABLE movie_info_idx ADD COLUMN IF NOT EXISTS optimal_parachute_q26c_title BOOLEAN DEFAULT false;
UPDATE movie_info_idx mi_idx
SET optimal_parachute_q26c_title = true
FROM title t
WHERE t.id = mi_idx.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2000
);

                
-------------
-- 27a
-------------

ALTER TABLE movie_link ADD COLUMN IF NOT EXISTS optimal_parachute_q27a_link_type BOOLEAN DEFAULT false;
UPDATE movie_link ml
SET optimal_parachute_q27a_link_type = true
FROM link_type lt
WHERE lt.id = ml.link_type_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    lt.link LIKE '%follow%'
);

ALTER TABLE movie_companies ADD COLUMN IF NOT EXISTS optimal_parachute_q27a_company_name BOOLEAN DEFAULT false;
UPDATE movie_companies mc
SET optimal_parachute_q27a_company_name = true
FROM company_name cn
WHERE mc.company_id = cn.id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    cn.country_code !='[pl]' AND (cn.name LIKE '%Film%'
       OR cn.name LIKE '%Warner%')
);

                
-------------
-- 27b
-------------

ALTER TABLE movie_companies ADD COLUMN IF NOT EXISTS optimal_parachute_q27b_company_name BOOLEAN DEFAULT false;
UPDATE movie_companies mc
SET optimal_parachute_q27b_company_name = true
FROM company_name cn
WHERE mc.company_id = cn.id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    cn.country_code !='[pl]' AND (cn.name LIKE '%Film%'
       OR cn.name LIKE '%Warner%')
);

                
-------------
-- 27c
-------------

ALTER TABLE movie_link ADD COLUMN IF NOT EXISTS optimal_parachute_q27c_link_type BOOLEAN DEFAULT false;
UPDATE movie_link ml
SET optimal_parachute_q27c_link_type = true
FROM link_type lt
WHERE lt.id = ml.link_type_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    lt.link LIKE '%follow%'
);

ALTER TABLE movie_companies ADD COLUMN IF NOT EXISTS optimal_parachute_q27c_company_name BOOLEAN DEFAULT false;
UPDATE movie_companies mc
SET optimal_parachute_q27c_company_name = true
FROM company_name cn
WHERE mc.company_id = cn.id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    cn.country_code !='[pl]' AND (cn.name LIKE '%Film%'
       OR cn.name LIKE '%Warner%')
);

                
-------------
-- 28a
-------------

ALTER TABLE kind_type ADD COLUMN IF NOT EXISTS optimal_parachute_q28a_title BOOLEAN DEFAULT false;
UPDATE kind_type kt
SET optimal_parachute_q28a_title = true
FROM title t
WHERE kt.id = t.kind_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2000
);

ALTER TABLE movie_info ADD COLUMN IF NOT EXISTS optimal_parachute_q28a_title BOOLEAN DEFAULT false;
UPDATE movie_info mi
SET optimal_parachute_q28a_title = true
FROM title t
WHERE t.id = mi.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2000
);

ALTER TABLE movie_keyword ADD COLUMN IF NOT EXISTS optimal_parachute_q28a_title BOOLEAN DEFAULT false;
UPDATE movie_keyword mk
SET optimal_parachute_q28a_title = true
FROM title t
WHERE t.id = mk.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2000
);

ALTER TABLE movie_info_idx ADD COLUMN IF NOT EXISTS optimal_parachute_q28a_title BOOLEAN DEFAULT false;
UPDATE movie_info_idx mi_idx
SET optimal_parachute_q28a_title = true
FROM title t
WHERE t.id = mi_idx.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2000
);

ALTER TABLE movie_companies ADD COLUMN IF NOT EXISTS optimal_parachute_q28a_title BOOLEAN DEFAULT false;
UPDATE movie_companies mc
SET optimal_parachute_q28a_title = true
FROM title t
WHERE t.id = mc.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2000
);

ALTER TABLE complete_cast ADD COLUMN IF NOT EXISTS optimal_parachute_q28a_title BOOLEAN DEFAULT false;
UPDATE complete_cast cc
SET optimal_parachute_q28a_title = true
FROM title t
WHERE t.id = cc.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2000
);

ALTER TABLE title ADD COLUMN IF NOT EXISTS optimal_parachute_q28a_movie_companies BOOLEAN DEFAULT false;
UPDATE title t
SET optimal_parachute_q28a_movie_companies = true
FROM movie_companies mc
WHERE t.id = mc.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    mc.note NOT LIKE '%(USA)%' AND mc.note LIKE '%(200%)%'
);

ALTER TABLE movie_keyword ADD COLUMN IF NOT EXISTS optimal_parachute_q28a_movie_companies BOOLEAN DEFAULT false;
UPDATE movie_keyword mk
SET optimal_parachute_q28a_movie_companies = true
FROM movie_companies mc
WHERE mk.movie_id = mc.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    mc.note NOT LIKE '%(USA)%' AND mc.note LIKE '%(200%)%'
);

ALTER TABLE movie_info ADD COLUMN IF NOT EXISTS optimal_parachute_q28a_movie_companies BOOLEAN DEFAULT false;
UPDATE movie_info mi
SET optimal_parachute_q28a_movie_companies = true
FROM movie_companies mc
WHERE mi.movie_id = mc.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    mc.note NOT LIKE '%(USA)%' AND mc.note LIKE '%(200%)%'
);

ALTER TABLE movie_info_idx ADD COLUMN IF NOT EXISTS optimal_parachute_q28a_movie_companies BOOLEAN DEFAULT false;
UPDATE movie_info_idx mi_idx
SET optimal_parachute_q28a_movie_companies = true
FROM movie_companies mc
WHERE mc.movie_id = mi_idx.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    mc.note NOT LIKE '%(USA)%' AND mc.note LIKE '%(200%)%'
);

ALTER TABLE complete_cast ADD COLUMN IF NOT EXISTS optimal_parachute_q28a_movie_companies BOOLEAN DEFAULT false;
UPDATE complete_cast cc
SET optimal_parachute_q28a_movie_companies = true
FROM movie_companies mc
WHERE mc.movie_id = cc.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    mc.note NOT LIKE '%(USA)%' AND mc.note LIKE '%(200%)%'
);

ALTER TABLE company_type ADD COLUMN IF NOT EXISTS optimal_parachute_q28a_movie_companies BOOLEAN DEFAULT false;
UPDATE company_type ct
SET optimal_parachute_q28a_movie_companies = true
FROM movie_companies mc
WHERE ct.id = mc.company_type_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    mc.note NOT LIKE '%(USA)%' AND mc.note LIKE '%(200%)%'
);

ALTER TABLE company_name ADD COLUMN IF NOT EXISTS optimal_parachute_q28a_movie_companies BOOLEAN DEFAULT false;
UPDATE company_name cn
SET optimal_parachute_q28a_movie_companies = true
FROM movie_companies mc
WHERE cn.id = mc.company_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    mc.note NOT LIKE '%(USA)%' AND mc.note LIKE '%(200%)%'
);

ALTER TABLE movie_companies ADD COLUMN IF NOT EXISTS optimal_parachute_q28a_company_name BOOLEAN DEFAULT false;
UPDATE movie_companies mc
SET optimal_parachute_q28a_company_name = true
FROM company_name cn
WHERE cn.id = mc.company_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    cn.country_code != '[us]'
);

ALTER TABLE movie_info ADD COLUMN IF NOT EXISTS optimal_parachute_q28a_info_type BOOLEAN DEFAULT false;
UPDATE movie_info mi
SET optimal_parachute_q28a_info_type = true
FROM info_type it1
WHERE it1.id = mi.info_type_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    it1.info = 'countries'
);

                
-------------
-- 28b
-------------

ALTER TABLE kind_type ADD COLUMN IF NOT EXISTS optimal_parachute_q28b_title BOOLEAN DEFAULT false;
UPDATE kind_type kt
SET optimal_parachute_q28b_title = true
FROM title t
WHERE kt.id = t.kind_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2005
);

ALTER TABLE movie_info ADD COLUMN IF NOT EXISTS optimal_parachute_q28b_title BOOLEAN DEFAULT false;
UPDATE movie_info mi
SET optimal_parachute_q28b_title = true
FROM title t
WHERE t.id = mi.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2005
);

ALTER TABLE movie_keyword ADD COLUMN IF NOT EXISTS optimal_parachute_q28b_title BOOLEAN DEFAULT false;
UPDATE movie_keyword mk
SET optimal_parachute_q28b_title = true
FROM title t
WHERE t.id = mk.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2005
);

ALTER TABLE movie_info_idx ADD COLUMN IF NOT EXISTS optimal_parachute_q28b_title BOOLEAN DEFAULT false;
UPDATE movie_info_idx mi_idx
SET optimal_parachute_q28b_title = true
FROM title t
WHERE t.id = mi_idx.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2005
);

ALTER TABLE movie_companies ADD COLUMN IF NOT EXISTS optimal_parachute_q28b_title BOOLEAN DEFAULT false;
UPDATE movie_companies mc
SET optimal_parachute_q28b_title = true
FROM title t
WHERE t.id = mc.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2005
);

ALTER TABLE complete_cast ADD COLUMN IF NOT EXISTS optimal_parachute_q28b_title BOOLEAN DEFAULT false;
UPDATE complete_cast cc
SET optimal_parachute_q28b_title = true
FROM title t
WHERE t.id = cc.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2005
);

ALTER TABLE title ADD COLUMN IF NOT EXISTS optimal_parachute_q28b_movie_companies BOOLEAN DEFAULT false;
UPDATE title t
SET optimal_parachute_q28b_movie_companies = true
FROM movie_companies mc
WHERE t.id = mc.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    mc.note NOT LIKE '%(USA)%' AND mc.note LIKE '%(200%)%'
);

ALTER TABLE movie_keyword ADD COLUMN IF NOT EXISTS optimal_parachute_q28b_movie_companies BOOLEAN DEFAULT false;
UPDATE movie_keyword mk
SET optimal_parachute_q28b_movie_companies = true
FROM movie_companies mc
WHERE mk.movie_id = mc.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    mc.note NOT LIKE '%(USA)%' AND mc.note LIKE '%(200%)%'
);

ALTER TABLE movie_info ADD COLUMN IF NOT EXISTS optimal_parachute_q28b_movie_companies BOOLEAN DEFAULT false;
UPDATE movie_info mi
SET optimal_parachute_q28b_movie_companies = true
FROM movie_companies mc
WHERE mi.movie_id = mc.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    mc.note NOT LIKE '%(USA)%' AND mc.note LIKE '%(200%)%'
);

ALTER TABLE movie_info_idx ADD COLUMN IF NOT EXISTS optimal_parachute_q28b_movie_companies BOOLEAN DEFAULT false;
UPDATE movie_info_idx mi_idx
SET optimal_parachute_q28b_movie_companies = true
FROM movie_companies mc
WHERE mc.movie_id = mi_idx.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    mc.note NOT LIKE '%(USA)%' AND mc.note LIKE '%(200%)%'
);

ALTER TABLE complete_cast ADD COLUMN IF NOT EXISTS optimal_parachute_q28b_movie_companies BOOLEAN DEFAULT false;
UPDATE complete_cast cc
SET optimal_parachute_q28b_movie_companies = true
FROM movie_companies mc
WHERE mc.movie_id = cc.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    mc.note NOT LIKE '%(USA)%' AND mc.note LIKE '%(200%)%'
);

ALTER TABLE company_type ADD COLUMN IF NOT EXISTS optimal_parachute_q28b_movie_companies BOOLEAN DEFAULT false;
UPDATE company_type ct
SET optimal_parachute_q28b_movie_companies = true
FROM movie_companies mc
WHERE ct.id = mc.company_type_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    mc.note NOT LIKE '%(USA)%' AND mc.note LIKE '%(200%)%'
);

ALTER TABLE company_name ADD COLUMN IF NOT EXISTS optimal_parachute_q28b_movie_companies BOOLEAN DEFAULT false;
UPDATE company_name cn
SET optimal_parachute_q28b_movie_companies = true
FROM movie_companies mc
WHERE cn.id = mc.company_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    mc.note NOT LIKE '%(USA)%' AND mc.note LIKE '%(200%)%'
);

ALTER TABLE movie_companies ADD COLUMN IF NOT EXISTS optimal_parachute_q28b_company_name BOOLEAN DEFAULT false;
UPDATE movie_companies mc
SET optimal_parachute_q28b_company_name = true
FROM company_name cn
WHERE cn.id = mc.company_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    cn.country_code != '[us]'
);

                
-------------
-- 28c
-------------

ALTER TABLE kind_type ADD COLUMN IF NOT EXISTS optimal_parachute_q28c_title BOOLEAN DEFAULT false;
UPDATE kind_type kt
SET optimal_parachute_q28c_title = true
FROM title t
WHERE kt.id = t.kind_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2005
);

ALTER TABLE movie_info ADD COLUMN IF NOT EXISTS optimal_parachute_q28c_title BOOLEAN DEFAULT false;
UPDATE movie_info mi
SET optimal_parachute_q28c_title = true
FROM title t
WHERE t.id = mi.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2005
);

ALTER TABLE movie_keyword ADD COLUMN IF NOT EXISTS optimal_parachute_q28c_title BOOLEAN DEFAULT false;
UPDATE movie_keyword mk
SET optimal_parachute_q28c_title = true
FROM title t
WHERE t.id = mk.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2005
);

ALTER TABLE movie_info_idx ADD COLUMN IF NOT EXISTS optimal_parachute_q28c_title BOOLEAN DEFAULT false;
UPDATE movie_info_idx mi_idx
SET optimal_parachute_q28c_title = true
FROM title t
WHERE t.id = mi_idx.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2005
);

ALTER TABLE movie_companies ADD COLUMN IF NOT EXISTS optimal_parachute_q28c_title BOOLEAN DEFAULT false;
UPDATE movie_companies mc
SET optimal_parachute_q28c_title = true
FROM title t
WHERE t.id = mc.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2005
);

ALTER TABLE complete_cast ADD COLUMN IF NOT EXISTS optimal_parachute_q28c_title BOOLEAN DEFAULT false;
UPDATE complete_cast cc
SET optimal_parachute_q28c_title = true
FROM title t
WHERE t.id = cc.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2005
);

ALTER TABLE title ADD COLUMN IF NOT EXISTS optimal_parachute_q28c_movie_companies BOOLEAN DEFAULT false;
UPDATE title t
SET optimal_parachute_q28c_movie_companies = true
FROM movie_companies mc
WHERE t.id = mc.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    mc.note NOT LIKE '%(USA)%' AND mc.note LIKE '%(200%)%'
);

ALTER TABLE movie_keyword ADD COLUMN IF NOT EXISTS optimal_parachute_q28c_movie_companies BOOLEAN DEFAULT false;
UPDATE movie_keyword mk
SET optimal_parachute_q28c_movie_companies = true
FROM movie_companies mc
WHERE mk.movie_id = mc.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    mc.note NOT LIKE '%(USA)%' AND mc.note LIKE '%(200%)%'
);

ALTER TABLE movie_info ADD COLUMN IF NOT EXISTS optimal_parachute_q28c_movie_companies BOOLEAN DEFAULT false;
UPDATE movie_info mi
SET optimal_parachute_q28c_movie_companies = true
FROM movie_companies mc
WHERE mi.movie_id = mc.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    mc.note NOT LIKE '%(USA)%' AND mc.note LIKE '%(200%)%'
);

ALTER TABLE movie_info_idx ADD COLUMN IF NOT EXISTS optimal_parachute_q28c_movie_companies BOOLEAN DEFAULT false;
UPDATE movie_info_idx mi_idx
SET optimal_parachute_q28c_movie_companies = true
FROM movie_companies mc
WHERE mc.movie_id = mi_idx.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    mc.note NOT LIKE '%(USA)%' AND mc.note LIKE '%(200%)%'
);

ALTER TABLE complete_cast ADD COLUMN IF NOT EXISTS optimal_parachute_q28c_movie_companies BOOLEAN DEFAULT false;
UPDATE complete_cast cc
SET optimal_parachute_q28c_movie_companies = true
FROM movie_companies mc
WHERE mc.movie_id = cc.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    mc.note NOT LIKE '%(USA)%' AND mc.note LIKE '%(200%)%'
);

ALTER TABLE company_type ADD COLUMN IF NOT EXISTS optimal_parachute_q28c_movie_companies BOOLEAN DEFAULT false;
UPDATE company_type ct
SET optimal_parachute_q28c_movie_companies = true
FROM movie_companies mc
WHERE ct.id = mc.company_type_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    mc.note NOT LIKE '%(USA)%' AND mc.note LIKE '%(200%)%'
);

ALTER TABLE company_name ADD COLUMN IF NOT EXISTS optimal_parachute_q28c_movie_companies BOOLEAN DEFAULT false;
UPDATE company_name cn
SET optimal_parachute_q28c_movie_companies = true
FROM movie_companies mc
WHERE cn.id = mc.company_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    mc.note NOT LIKE '%(USA)%' AND mc.note LIKE '%(200%)%'
);

ALTER TABLE movie_companies ADD COLUMN IF NOT EXISTS optimal_parachute_q28c_company_name BOOLEAN DEFAULT false;
UPDATE movie_companies mc
SET optimal_parachute_q28c_company_name = true
FROM company_name cn
WHERE cn.id = mc.company_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    cn.country_code != '[us]'
);

ALTER TABLE movie_info ADD COLUMN IF NOT EXISTS optimal_parachute_q28c_info_type BOOLEAN DEFAULT false;
UPDATE movie_info mi
SET optimal_parachute_q28c_info_type = true
FROM info_type it1
WHERE it1.id = mi.info_type_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    it1.info = 'countries'
);

                
-------------
-- 29a
-------------

ALTER TABLE movie_keyword ADD COLUMN IF NOT EXISTS optimal_parachute_q29a_keyword BOOLEAN DEFAULT false;
UPDATE movie_keyword mk
SET optimal_parachute_q29a_keyword = true
FROM keyword k
WHERE k.id = mk.keyword_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    k.keyword = 'computer-animation'
);

ALTER TABLE person_info ADD COLUMN IF NOT EXISTS optimal_parachute_q29a_info_type BOOLEAN DEFAULT false;
UPDATE person_info pi
SET optimal_parachute_q29a_info_type = true
FROM info_type it3
WHERE it3.id = pi.info_type_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    it3.info = 'trivia'
);

                
-------------
-- 29b
-------------

ALTER TABLE movie_keyword ADD COLUMN IF NOT EXISTS optimal_parachute_q29b_keyword BOOLEAN DEFAULT false;
UPDATE movie_keyword mk
SET optimal_parachute_q29b_keyword = true
FROM keyword k
WHERE k.id = mk.keyword_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    k.keyword = 'computer-animation'
);

ALTER TABLE person_info ADD COLUMN IF NOT EXISTS optimal_parachute_q29b_info_type BOOLEAN DEFAULT false;
UPDATE person_info pi
SET optimal_parachute_q29b_info_type = true
FROM info_type it3
WHERE it3.id = pi.info_type_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    it3.info = 'height'
);

                
-------------
-- 29c
-------------

ALTER TABLE movie_companies ADD COLUMN IF NOT EXISTS optimal_parachute_q29c_company_name BOOLEAN DEFAULT false;
UPDATE movie_companies mc
SET optimal_parachute_q29c_company_name = true
FROM company_name cn
WHERE cn.id = mc.company_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    cn.country_code ='[us]'
);

ALTER TABLE title ADD COLUMN IF NOT EXISTS optimal_parachute_q29c_movie_info BOOLEAN DEFAULT false;
UPDATE title t
SET optimal_parachute_q29c_movie_info = true
FROM movie_info mi
WHERE t.id = mi.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    (mi.info LIKE 'Japan:%200%'
       OR mi.info LIKE 'USA:%200%')
);

ALTER TABLE movie_companies ADD COLUMN IF NOT EXISTS optimal_parachute_q29c_movie_info BOOLEAN DEFAULT false;
UPDATE movie_companies mc
SET optimal_parachute_q29c_movie_info = true
FROM movie_info mi
WHERE mc.movie_id = mi.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    (mi.info LIKE 'Japan:%200%'
       OR mi.info LIKE 'USA:%200%')
);

ALTER TABLE cast_info ADD COLUMN IF NOT EXISTS optimal_parachute_q29c_movie_info BOOLEAN DEFAULT false;
UPDATE cast_info ci
SET optimal_parachute_q29c_movie_info = true
FROM movie_info mi
WHERE mi.movie_id = ci.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    (mi.info LIKE 'Japan:%200%'
       OR mi.info LIKE 'USA:%200%')
);

ALTER TABLE movie_keyword ADD COLUMN IF NOT EXISTS optimal_parachute_q29c_movie_info BOOLEAN DEFAULT false;
UPDATE movie_keyword mk
SET optimal_parachute_q29c_movie_info = true
FROM movie_info mi
WHERE mi.movie_id = mk.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    (mi.info LIKE 'Japan:%200%'
       OR mi.info LIKE 'USA:%200%')
);

ALTER TABLE complete_cast ADD COLUMN IF NOT EXISTS optimal_parachute_q29c_movie_info BOOLEAN DEFAULT false;
UPDATE complete_cast cc
SET optimal_parachute_q29c_movie_info = true
FROM movie_info mi
WHERE mi.movie_id = cc.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    (mi.info LIKE 'Japan:%200%'
       OR mi.info LIKE 'USA:%200%')
);

ALTER TABLE info_type ADD COLUMN IF NOT EXISTS optimal_parachute_q29c_movie_info BOOLEAN DEFAULT false;
UPDATE info_type it
SET optimal_parachute_q29c_movie_info = true
FROM movie_info mi
WHERE it.id = mi.info_type_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    (mi.info LIKE 'Japan:%200%'
       OR mi.info LIKE 'USA:%200%')
);

ALTER TABLE cast_info ADD COLUMN IF NOT EXISTS optimal_parachute_q29c_name BOOLEAN DEFAULT false;
UPDATE cast_info ci
SET optimal_parachute_q29c_name = true
FROM name n
WHERE n.id = ci.person_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    n.gender ='f' AND n.name LIKE '%An%'
);

ALTER TABLE aka_name ADD COLUMN IF NOT EXISTS optimal_parachute_q29c_name BOOLEAN DEFAULT false;
UPDATE aka_name an
SET optimal_parachute_q29c_name = true
FROM name n
WHERE n.id = an.person_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    n.gender ='f' AND n.name LIKE '%An%'
);

ALTER TABLE person_info ADD COLUMN IF NOT EXISTS optimal_parachute_q29c_name BOOLEAN DEFAULT false;
UPDATE person_info pi
SET optimal_parachute_q29c_name = true
FROM name n
WHERE n.id = pi.person_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    n.gender ='f' AND n.name LIKE '%An%'
);

ALTER TABLE movie_info ADD COLUMN IF NOT EXISTS optimal_parachute_q29c_info_type BOOLEAN DEFAULT false;
UPDATE movie_info mi
SET optimal_parachute_q29c_info_type = true
FROM info_type it
WHERE it.id = mi.info_type_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    it.info = 'release dates'
);

ALTER TABLE person_info ADD COLUMN IF NOT EXISTS optimal_parachute_q29c_info_type BOOLEAN DEFAULT false;
UPDATE person_info pi
SET optimal_parachute_q29c_info_type = true
FROM info_type it3
WHERE it3.id = pi.info_type_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    it3.info = 'trivia'
);

                
-------------
-- 30a
-------------

ALTER TABLE movie_info ADD COLUMN IF NOT EXISTS optimal_parachute_q30a_title BOOLEAN DEFAULT false;
UPDATE movie_info mi
SET optimal_parachute_q30a_title = true
FROM title t
WHERE t.id = mi.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2000
);

ALTER TABLE movie_info_idx ADD COLUMN IF NOT EXISTS optimal_parachute_q30a_title BOOLEAN DEFAULT false;
UPDATE movie_info_idx mi_idx
SET optimal_parachute_q30a_title = true
FROM title t
WHERE t.id = mi_idx.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2000
);

ALTER TABLE cast_info ADD COLUMN IF NOT EXISTS optimal_parachute_q30a_title BOOLEAN DEFAULT false;
UPDATE cast_info ci
SET optimal_parachute_q30a_title = true
FROM title t
WHERE t.id = ci.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2000
);

ALTER TABLE movie_keyword ADD COLUMN IF NOT EXISTS optimal_parachute_q30a_title BOOLEAN DEFAULT false;
UPDATE movie_keyword mk
SET optimal_parachute_q30a_title = true
FROM title t
WHERE t.id = mk.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2000
);

ALTER TABLE complete_cast ADD COLUMN IF NOT EXISTS optimal_parachute_q30a_title BOOLEAN DEFAULT false;
UPDATE complete_cast cc
SET optimal_parachute_q30a_title = true
FROM title t
WHERE t.id = cc.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2000
);

ALTER TABLE cast_info ADD COLUMN IF NOT EXISTS optimal_parachute_q30a_name BOOLEAN DEFAULT false;
UPDATE cast_info ci
SET optimal_parachute_q30a_name = true
FROM name n
WHERE n.id = ci.person_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    n.gender = 'm'
);

                
-------------
-- 30b
-------------

ALTER TABLE movie_info ADD COLUMN IF NOT EXISTS optimal_parachute_q30b_title BOOLEAN DEFAULT false;
UPDATE movie_info mi
SET optimal_parachute_q30b_title = true
FROM title t
WHERE t.id = mi.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2000 AND (t.title LIKE '%Freddy%'
       OR t.title LIKE '%Jason%'
       OR t.title LIKE 'Saw%')
);

ALTER TABLE movie_info_idx ADD COLUMN IF NOT EXISTS optimal_parachute_q30b_title BOOLEAN DEFAULT false;
UPDATE movie_info_idx mi_idx
SET optimal_parachute_q30b_title = true
FROM title t
WHERE t.id = mi_idx.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2000 AND (t.title LIKE '%Freddy%'
       OR t.title LIKE '%Jason%'
       OR t.title LIKE 'Saw%')
);

ALTER TABLE cast_info ADD COLUMN IF NOT EXISTS optimal_parachute_q30b_title BOOLEAN DEFAULT false;
UPDATE cast_info ci
SET optimal_parachute_q30b_title = true
FROM title t
WHERE t.id = ci.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2000 AND (t.title LIKE '%Freddy%'
       OR t.title LIKE '%Jason%'
       OR t.title LIKE 'Saw%')
);

ALTER TABLE movie_keyword ADD COLUMN IF NOT EXISTS optimal_parachute_q30b_title BOOLEAN DEFAULT false;
UPDATE movie_keyword mk
SET optimal_parachute_q30b_title = true
FROM title t
WHERE t.id = mk.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2000 AND (t.title LIKE '%Freddy%'
       OR t.title LIKE '%Jason%'
       OR t.title LIKE 'Saw%')
);

ALTER TABLE complete_cast ADD COLUMN IF NOT EXISTS optimal_parachute_q30b_title BOOLEAN DEFAULT false;
UPDATE complete_cast cc
SET optimal_parachute_q30b_title = true
FROM title t
WHERE t.id = cc.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2000 AND (t.title LIKE '%Freddy%'
       OR t.title LIKE '%Jason%'
       OR t.title LIKE 'Saw%')
);

                
-------------
-- 30c
-------------

ALTER TABLE cast_info ADD COLUMN IF NOT EXISTS optimal_parachute_q30c_name BOOLEAN DEFAULT false;
UPDATE cast_info ci
SET optimal_parachute_q30c_name = true
FROM name n
WHERE n.id = ci.person_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    n.gender = 'm'
);

                
-------------
-- 31a
-------------

ALTER TABLE cast_info ADD COLUMN IF NOT EXISTS optimal_parachute_q31a_name BOOLEAN DEFAULT false;
UPDATE cast_info ci
SET optimal_parachute_q31a_name = true
FROM name n
WHERE n.id = ci.person_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    n.gender = 'm'
);

                
-------------
-- 31b
-------------

ALTER TABLE movie_info ADD COLUMN IF NOT EXISTS optimal_parachute_q31b_title BOOLEAN DEFAULT false;
UPDATE movie_info mi
SET optimal_parachute_q31b_title = true
FROM title t
WHERE t.id = mi.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2000 AND (t.title LIKE '%Freddy%'
       OR t.title LIKE '%Jason%'
       OR t.title LIKE 'Saw%')
);

ALTER TABLE movie_info_idx ADD COLUMN IF NOT EXISTS optimal_parachute_q31b_title BOOLEAN DEFAULT false;
UPDATE movie_info_idx mi_idx
SET optimal_parachute_q31b_title = true
FROM title t
WHERE t.id = mi_idx.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2000 AND (t.title LIKE '%Freddy%'
       OR t.title LIKE '%Jason%'
       OR t.title LIKE 'Saw%')
);

ALTER TABLE cast_info ADD COLUMN IF NOT EXISTS optimal_parachute_q31b_title BOOLEAN DEFAULT false;
UPDATE cast_info ci
SET optimal_parachute_q31b_title = true
FROM title t
WHERE t.id = ci.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2000 AND (t.title LIKE '%Freddy%'
       OR t.title LIKE '%Jason%'
       OR t.title LIKE 'Saw%')
);

ALTER TABLE movie_keyword ADD COLUMN IF NOT EXISTS optimal_parachute_q31b_title BOOLEAN DEFAULT false;
UPDATE movie_keyword mk
SET optimal_parachute_q31b_title = true
FROM title t
WHERE t.id = mk.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2000 AND (t.title LIKE '%Freddy%'
       OR t.title LIKE '%Jason%'
       OR t.title LIKE 'Saw%')
);

ALTER TABLE movie_companies ADD COLUMN IF NOT EXISTS optimal_parachute_q31b_title BOOLEAN DEFAULT false;
UPDATE movie_companies mc
SET optimal_parachute_q31b_title = true
FROM title t
WHERE t.id = mc.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    t.production_year > 2000 AND (t.title LIKE '%Freddy%'
       OR t.title LIKE '%Jason%'
       OR t.title LIKE 'Saw%')
);

ALTER TABLE cast_info ADD COLUMN IF NOT EXISTS optimal_parachute_q31b_name BOOLEAN DEFAULT false;
UPDATE cast_info ci
SET optimal_parachute_q31b_name = true
FROM name n
WHERE n.id = ci.person_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    n.gender = 'm'
);

                
-------------
-- 31c
-------------

                
-------------
-- 32a
-------------

                
-------------
-- 32b
-------------

                
-------------
-- 33a
-------------

ALTER TABLE info_type ADD COLUMN IF NOT EXISTS optimal_parachute_q33a_movie_info_idx BOOLEAN DEFAULT false;
UPDATE info_type it2
SET optimal_parachute_q33a_movie_info_idx = true
FROM movie_info_idx mi_idx2
WHERE it2.id = mi_idx2.info_type_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    mi_idx2.info < '3.0'
);

ALTER TABLE title ADD COLUMN IF NOT EXISTS optimal_parachute_q33a_movie_info_idx BOOLEAN DEFAULT false;
UPDATE title t2
SET optimal_parachute_q33a_movie_info_idx = true
FROM movie_info_idx mi_idx2
WHERE t2.id = mi_idx2.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    mi_idx2.info < '3.0'
);

ALTER TABLE movie_link ADD COLUMN IF NOT EXISTS optimal_parachute_q33a_movie_info_idx BOOLEAN DEFAULT false;
UPDATE movie_link ml
SET optimal_parachute_q33a_movie_info_idx = true
FROM movie_info_idx mi_idx2
WHERE ml.linked_movie_id = mi_idx2.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    mi_idx2.info < '3.0'
);

ALTER TABLE movie_companies ADD COLUMN IF NOT EXISTS optimal_parachute_q33a_movie_info_idx BOOLEAN DEFAULT false;
UPDATE movie_companies mc2
SET optimal_parachute_q33a_movie_info_idx = true
FROM movie_info_idx mi_idx2
WHERE mi_idx2.movie_id = mc2.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    mi_idx2.info < '3.0'
);

                
-------------
-- 33b
-------------

ALTER TABLE info_type ADD COLUMN IF NOT EXISTS optimal_parachute_q33b_movie_info_idx BOOLEAN DEFAULT false;
UPDATE info_type it2
SET optimal_parachute_q33b_movie_info_idx = true
FROM movie_info_idx mi_idx2
WHERE it2.id = mi_idx2.info_type_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    mi_idx2.info < '3.0'
);

ALTER TABLE title ADD COLUMN IF NOT EXISTS optimal_parachute_q33b_movie_info_idx BOOLEAN DEFAULT false;
UPDATE title t2
SET optimal_parachute_q33b_movie_info_idx = true
FROM movie_info_idx mi_idx2
WHERE t2.id = mi_idx2.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    mi_idx2.info < '3.0'
);

ALTER TABLE movie_link ADD COLUMN IF NOT EXISTS optimal_parachute_q33b_movie_info_idx BOOLEAN DEFAULT false;
UPDATE movie_link ml
SET optimal_parachute_q33b_movie_info_idx = true
FROM movie_info_idx mi_idx2
WHERE ml.linked_movie_id = mi_idx2.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    mi_idx2.info < '3.0'
);

ALTER TABLE movie_companies ADD COLUMN IF NOT EXISTS optimal_parachute_q33b_movie_info_idx BOOLEAN DEFAULT false;
UPDATE movie_companies mc2
SET optimal_parachute_q33b_movie_info_idx = true
FROM movie_info_idx mi_idx2
WHERE mi_idx2.movie_id = mc2.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    mi_idx2.info < '3.0'
);

ALTER TABLE movie_link ADD COLUMN IF NOT EXISTS optimal_parachute_q33b_link_type BOOLEAN DEFAULT false;
UPDATE movie_link ml
SET optimal_parachute_q33b_link_type = true
FROM link_type lt
WHERE lt.id = ml.link_type_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    lt.link LIKE '%follow%'
);

                
-------------
-- 33c
-------------

ALTER TABLE info_type ADD COLUMN IF NOT EXISTS optimal_parachute_q33c_movie_info_idx BOOLEAN DEFAULT false;
UPDATE info_type it2
SET optimal_parachute_q33c_movie_info_idx = true
FROM movie_info_idx mi_idx2
WHERE it2.id = mi_idx2.info_type_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    mi_idx2.info < '3.5'
);

ALTER TABLE title ADD COLUMN IF NOT EXISTS optimal_parachute_q33c_movie_info_idx BOOLEAN DEFAULT false;
UPDATE title t2
SET optimal_parachute_q33c_movie_info_idx = true
FROM movie_info_idx mi_idx2
WHERE t2.id = mi_idx2.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    mi_idx2.info < '3.5'
);

ALTER TABLE movie_link ADD COLUMN IF NOT EXISTS optimal_parachute_q33c_movie_info_idx BOOLEAN DEFAULT false;
UPDATE movie_link ml
SET optimal_parachute_q33c_movie_info_idx = true
FROM movie_info_idx mi_idx2
WHERE ml.linked_movie_id = mi_idx2.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    mi_idx2.info < '3.5'
);

ALTER TABLE movie_companies ADD COLUMN IF NOT EXISTS optimal_parachute_q33c_movie_info_idx BOOLEAN DEFAULT false;
UPDATE movie_companies mc2
SET optimal_parachute_q33c_movie_info_idx = true
FROM movie_info_idx mi_idx2
WHERE mi_idx2.movie_id = mc2.movie_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    mi_idx2.info < '3.5'
);

ALTER TABLE movie_companies ADD COLUMN IF NOT EXISTS optimal_parachute_q33c_company_name BOOLEAN DEFAULT false;
UPDATE movie_companies mc1
SET optimal_parachute_q33c_company_name = true
FROM company_name cn1
WHERE cn1.id = mc1.company_id -- replicate join condition
  -- Replicate predicate from the probe side
  AND (
    cn1.country_code != '[us]'
);
