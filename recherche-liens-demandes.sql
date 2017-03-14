/*
On recherche les demandes et leurs liens. Ces liens sont différents des epics et des sous-tâches
*/
SELECT i.ID, i.issuenum, i.project, COUNT(l.ID)
FROM jiraissue i, issuelink l
WHERE (i.ID = l.SOURCE OR i.ID = l.DESTINATION)
AND l.linktype NOT IN (10100, 10101)
GROUP BY i.ID, i.issuenum, i.project