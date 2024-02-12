-- Забрати резюме конкретного працівника
SELECT u.*, r.*, c.name AS city_name, h.name AS hobby_name, pj.*, i.name AS institution_name
FROM users u
         JOIN resumes r ON u.id = r.user_id
         JOIN cities c ON r.city_id = c.id
         JOIN user_hobbies uh ON u.id = uh.user_id
         JOIN hobbies h ON uh.hobby_id = h.id
         JOIN user_previous_jobs upj ON u.id = upj.user_id
         JOIN previous_jobs pj ON upj.job_id = pj.id
         JOIN institutions i ON pj.institution_id = i.id
WHERE u.id = :userId;

-- Забрати всі хоббі, які існують в резюме конкретного працівника
SELECT h.name
FROM hobbies h
         JOIN user_hobbies uh ON h.id = uh.hobby_id
WHERE uh.user_id = :userId;

-- Забрати всі хоббі, які існують в резюме усіх працівників
SELECT h.name
FROM hobbies h
         JOIN user_hobbies uh ON h.id = uh.hobby_id;

-- Забрати всі хоббі, які в кожному резюме працівників
SELECT h.name
FROM hobbies h
WHERE NOT EXISTS(SELECT *
                 FROM users u
                          JOIN user_hobbies uh ON u.id = uh.user_id
                 WHERE NOT EXISTS(SELECT *
                                  FROM user_hobbies uh2
                                  WHERE uh2.user_id = u.id AND uh2.hobby_id = h.id));


-- Забрати всі міста, що зустрічаються в резюме усіх працівників
SELECT DISTINCT c.name
FROM cities c
         JOIN resumes r ON c.id = r.city_id;

-- Забрати всі міста, які зустрічаються в кожному резюме працівників
SELECT c.name
FROM cities c
WHERE NOT EXISTS(SELECT *
                 FROM users u
                          JOIN resumes r ON u.id = r.user_id
                 WHERE r.city_id != c.id);

-- Забрати хоббі всіх здобувачів, що мешкають в заданому місті
SELECT h.name
FROM hobbies h
         JOIN user_hobbies uh ON h.id = uh.hobby_id
         JOIN resumes r ON uh.user_id = r.user_id
         JOIN cities c ON r.city_id = c.id
WHERE c.name = :cityName;

-- Забрати всіх здобувачів, що працювали в одному закладі, заклад ми не вказуємо
SELECT u.login
FROM users u
         JOIN user_previous_jobs upj ON u.id = upj.user_id
GROUP BY u.id
HAVING COUNT(DISTINCT upj.job_id) > 1;
