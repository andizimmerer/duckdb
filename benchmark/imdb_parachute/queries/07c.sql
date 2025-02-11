SELECT min(n.name) AS cast_member_name,
       min(pi.info) AS cast_member_info
FROM aka_name AS an,
     cast_info AS ci,
     info_type AS it,
     link_type AS lt,
     movie_link AS ml,
     name AS n,
     person_info AS pi,
     title AS t
WHERE an.name IS NOT NULL
  AND (an.name LIKE '%a%'
       OR an.name LIKE 'A%')
  AND it.info ='mini biography'
  AND lt.link in ('references',
                  'referenced in',
                  'features',
                  'featured in')
  AND n.name_pcode_cf BETWEEN 'A' AND 'F'
  AND (n.gender='m'
       OR (n.gender = 'f'
           AND n.name LIKE 'A%'))
  AND pi.note IS NOT NULL
  AND t.production_year BETWEEN 1980 AND 2010
  AND n.id = an.person_id
  AND n.id = pi.person_id
  AND ci.person_id = n.id
  AND t.id = ci.movie_id
  AND ml.linked_movie_id = t.id
  AND lt.id = ml.link_type_id
  AND it.id = pi.info_type_id
  AND pi.person_id = an.person_id
  AND pi.person_id = ci.person_id
  AND an.person_id = ci.person_id
  AND ci.movie_id = ml.linked_movie_id
  -- parachute columns
  AND an.optimal_parachute_q7c_name = true
  AND pi.optimal_parachute_q7c_name = true
  AND ci.optimal_parachute_q7c_name = true
  AND n.optimal_parachute_q7c_person_info = true
  AND it.optimal_parachute_q7c_person_info = true
  AND an.optimal_parachute_q7c_person_info = true
  AND ci.optimal_parachute_q7c_person_info = true
  AND ci.optimal_parachute_q7c_title = true
  AND ml.optimal_parachute_q7c_title = true
;