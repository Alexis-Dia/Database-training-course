
SELECT *
  FROM
  [dbo].[Journal]
  LEFT JOIN
  [dbo].[Driver]
  ON [dbo].[Journal].[driverId] = [dbo].[Driver].[id]
  ORDER BY [dbo].[Driver].[lastName]
GO
 
**********************************************************************************************************************

SELECT temp1.carId, temp1.departure, temp1.lastName, temp1.[firstName], [dbo].[Car].* FROM 
(SELECT [dbo].[Journal].id as journal_id, [dbo].[Journal].carId, [dbo].[Journal].departure, [dbo].[Driver].lastName, [dbo].[Driver].firstName
  FROM
  [dbo].[Journal]
  LEFT JOIN
  [dbo].[Driver]
  ON [dbo].[Journal].[driverId] = [dbo].[Driver].[id]
  WHERE [dbo].[Journal].departure > (GETDATE() - 7)) as temp1 
  LEFT JOIN
  [dbo].[Car]
  ON temp1.carId = [dbo].[Car].id
  ORDER BY temp1.[lastName]
GO

**********************************************************************************************************************

SELECT * FROM 
(SELECT * FROM [Cariages].[dbo].[Journal] 
WHERE (year(GETDATE()) - year([dbo].[Journal].departure)) > 10) as temp1
LEFT JOIN
[Cariages].[dbo].[Car]
ON temp1.carId = [Cariages].[dbo].[Car].[id]

**********************************************************************************************************************

SELECT [dbo].[Driver].*, temp1.departure FROM 
(SELECT * FROM [Cariages].[dbo].[Journal] 
WHERE DATEPART(m, departure) = DATEPART(m, DATEADD(m, -1, getdate()))
AND DATEPART(yyyy, departure) = DATEPART(yyyy, DATEADD(m, -1, getdate()))) as temp1
LEFT JOIN
[Cariages].[dbo].[Driver]
ON temp1.[driverId]= [dbo].[Driver].id

**********************************************************************************************************************

SELECT lastName FROM [Cariages].[dbo].[Driver] INTERSECT SELECT lastName FROM [Cariages].[dbo].[Driver] GROUP BY lastName HAVING count(*) > 1;

**********************************************************************************************************************


**********************************************************************************************************************

SELECT * FROM 
(SELECT [Cariages].[dbo].Journal.carId FROM [Cariages].[dbo].Journal
RIGHT JOIN 
(SELECT departure FROM [Cariages].[dbo].Journal where departure > (GETDATE() - 7) GROUP BY departure HAVING count(departure) > 1) as temp1
ON temp1.departure = [Cariages].[dbo].Journal.departure) as temp2
LEFT JOIN
[Cariages].[dbo].[Car]
ON [Cariages].[dbo].[Car].id = temp2.carId

**********************************************************************************************************************



