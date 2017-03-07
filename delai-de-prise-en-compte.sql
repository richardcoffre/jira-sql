select (select p.pkey from project p where p.ID = dde.project) AS PROJECT, concat((select p.pkey from project p where p.ID = dde.project), "-", dde.issuenum) as DDE_NUM, 
/* dde.project, dde.issuenum, */
(select i.pname from issuetype i where dde.issuetype = i.id) AS DDE_TYPE,
dde.CREATED as DATE_CREATION, 
(SELECT b.created FROM jiraissue a, changegroup b, changeitem c 
WHERE a.id = b.issueid AND b.id = c.groupid
AND FIELD = 'status'
AND NEWSTRING = "En Affinage"
AND a.issuenum = dde.issuenum
AND a.project = dde.project
ORDER BY b.created ASC LIMIT 1)
as DATE_EN_AFFINAGE, 
datediff((SELECT b.created FROM jiraissue a, changegroup b, changeitem c 
WHERE a.id = b.issueid AND b.id = c.groupid
AND FIELD = 'status'
AND NEWSTRING = "En Affinage"
AND a.issuenum = dde.issuenum
AND a.project = dde.project
ORDER BY b.created ASC LIMIT 1),dde.CREATED) as DELAI,
(select pname from issuestatus where ID = dde.issuestatus) as DDE_STATUT, 
dde.CREATED AS DATE_CREATION,
dde.UPDATED AS DATE_LAST_UPDATE
from jiraissue dde
where dde.CREATED >= '2016-07-01';