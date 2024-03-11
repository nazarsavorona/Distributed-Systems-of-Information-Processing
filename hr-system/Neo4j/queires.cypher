MATCH (u:User {login: 'user1'})-[:LIVES_IN]->(c:City)
MATCH (u)-[:WORKED_IN]->(company:Company)
MATCH (u)-[:LIKES]->(h:Hobby)
RETURN u, c, company, collect(h) AS hobbies

MATCH (u:User {login: 'user1'})-[:LIKES]->(h:Hobby)
RETURN h.name AS hobby

MATCH (u:User)
WITH collect(DISTINCT u) AS users
MATCH (h:Hobby)
  WHERE ALL(user IN users
    WHERE (user)-[:LIKES]->(h))
RETURN h.name AS common_hobby

MATCH (u:User)-[:LIVES_IN]->(c:City)
RETURN DISTINCT c.name AS city

MATCH (city:City {name: 'Kyiv'})<-[:LIVES_IN]-(u:User)-[:LIKES]->(h:Hobby)
RETURN DISTINCT h.name AS hobby

MATCH (u1:User)-[:WORKED_IN]->(company:Company)<-[:WORKED_IN]-(u2:User)
  WHERE id(u1) < id(u2)
RETURN collect(DISTINCT u1.login) + collect(DISTINCT u2.login) AS users