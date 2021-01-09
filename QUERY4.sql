WITH Ltable(EID,EName,Latency) AS (
select E.Employee_ID,E.Employee_Name,AVG(DATEDIFF(DAY,C.FilledDateTime,C.HandledDateTime)) as Latency
from Complaints C,Employee E
where C.Employee_ID = E.Employee_ID 
GROUP BY E.Employee_ID,E.Employee_Name
)

SELECT EID,EName,Latency
FROM Ltable
WHERE Latency = (SELECT             
MIN(Latency) FROM Ltable);
