// Create cities
CREATE (c1:City {name: 'Kyiv'})
CREATE (c2:City {name: 'Lviv'})
CREATE (c3:City {name: 'Odesa'})

// Create companies
CREATE (companyA:Company {name: 'Company A'})
CREATE (companyB:Company {name: 'Company B'})
CREATE (companyC:Company {name: 'Company C'})

// Create hobbies
CREATE (h1:Hobby {name: 'football'})
CREATE (h2:Hobby {name: 'reading'})
CREATE (h3:Hobby {name: 'swimming'})
CREATE (h4:Hobby {name: 'cooking'})

// Create users
CREATE (u1:User {login: 'user1', password: 'pass1'})
CREATE (u2:User {login: 'user2', password: 'pass2'})
CREATE (u3:User {login: 'user3', password: 'pass3'})
CREATE (u4:User {login: 'user4', password: 'pass4'})
CREATE (u5:User {login: 'user5', password: 'pass5'})

// Associate users with cities
CREATE (u1)-[:LIVES_IN]->(c1)
CREATE (u2)-[:LIVES_IN]->(c1)
CREATE (u3)-[:LIVES_IN]->(c2)
CREATE (u4)-[:LIVES_IN]->(c1)
CREATE (u5)-[:LIVES_IN]->(c2)

// Associate users with companies
CREATE (u1)-[:WORKED_IN]->(companyA)
CREATE (u2)-[:WORKED_IN]->(companyA)
CREATE (u3)-[:WORKED_IN]->(companyB)
CREATE (u4)-[:WORKED_IN]->(companyC)
CREATE (u5)-[:WORKED_IN]->(companyB)

// Associate users with hobbies
CREATE (u1)-[:LIKES]->(h1)
CREATE (u1)-[:LIKES]->(h2)
CREATE (u2)-[:LIKES]->(h1)
CREATE (u2)-[:LIKES]->(h3)
CREATE (u3)-[:LIKES]->(h1)
CREATE (u3)-[:LIKES]->(h4)
CREATE (u4)-[:LIKES]->(h1)
CREATE (u4)-[:LIKES]->(h2)
CREATE (u5)-[:LIKES]->(h1)
CREATE (u5)-[:LIKES]->(h3)
CREATE (u5)-[:LIKES]->(h4)

// Delete all nodes
MATCH (n)
DETACH DELETE n
