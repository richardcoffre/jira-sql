SELECT 
(select i.pname from issuetype i where a.issuetype = i.id) AS DDE_TYPE,
concat((select p.pkey from project p where p.ID = a.project), "-", a.issuenum) as DDE_NUM, 
a.CREATED,
count(NEWSTRING) AS NB_VERSIONS
,
(SELECT i.NEWSTRING 
FROM changeitem i, changegroup g
WHERE g.id = i.groupid
AND g.issueid  = a.id
AND FIELD = "Fix Version"
ORDER BY i.ID DESC
LIMIT 1) AS DERNIERE_VERSION,

(SELECT i.NEWSTRING 
FROM changeitem i, changegroup g
WHERE g.id = i.groupid
AND g.issueid  = a.id
AND FIELD = "Story points"
ORDER BY i.ID DESC
LIMIT 1) AS STORY_POINTS

FROM jiraissue a, changegroup b, changeitem c 
WHERE a.id = b.issueid AND b.id = c.groupid
AND FIELD = 'Fix Version'
AND a.CREATED >= '2016-07-01'
AND NEWSTRING IS NOT NULL
GROUP BY DDE_NUM
ORDER BY DDE_NUM