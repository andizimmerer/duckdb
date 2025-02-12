SELECT min(an.name) AS alternative_name,
       min(chn.name) AS voiced_character_name,
       min(n.name) AS voicing_actress,
       min(t.title) AS american_movie
FROM aka_name AS an,
     char_name AS chn,
     cast_info AS ci,
     company_name AS cn,
     movie_companies AS mc,
     name AS n,
     role_type AS rt,
     title AS t
WHERE ci.note in ('(voice)',
                  '(voice: Japanese version)',
                  '(voice) (uncredited)',
                  '(voice: English version)')
  AND cn.country_code ='[us]'
  AND n.gender ='f'
  AND n.name like '%An%'
  AND rt.role ='actress'
  AND ci.movie_id = t.id
  AND t.id = mc.movie_id
  AND ci.movie_id = mc.movie_id
  AND mc.company_id = cn.id
  AND ci.role_id = rt.id
  AND n.id = ci.person_id
  AND chn.id = ci.person_role_id
  AND an.person_id = n.id
  AND an.person_id = ci.person_id
  -- parachute columns
  AND t.optimal_parachute_q9c_cast_info = true
  AND mc.optimal_parachute_q9c_cast_info = true
  AND rt.optimal_parachute_q9c_cast_info = true
  AND n.optimal_parachute_q9c_cast_info = true
  AND chn.optimal_parachute_q9c_cast_info = true
  AND an.optimal_parachute_q9c_cast_info = true
  AND ci.optimal_parachute_q9c_name = true
  AND an.optimal_parachute_q9c_name = true
;