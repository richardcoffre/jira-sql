SELECT NEWSTRING AS VERSION_LIVREE, concat((select p.pkey from project p where p.ID = a.project), "-", a.issuenum) as DDE_NUM FROM jiraissue a, changegroup b, changeitem c 
WHERE a.id = b.issueid AND b.id = c.groupid
AND FIELD = 'Fix Version'
AND NEWSTRING like '2.2%'
UNION
SELECT NEWSTRING AS VERSION_LIVREE, concat((select p.pkey from project p where p.ID = a.project), "-", a.issuenum) as DDE_NUM FROM jiraissue a, changegroup b, changeitem c 
WHERE a.id = b.issueid AND b.id = c.groupid
AND FIELD = 'Fix Version'
AND NEWSTRING like '3.%'
ORDER BY VERSION_LIVREE, DDE_NUM ASC;