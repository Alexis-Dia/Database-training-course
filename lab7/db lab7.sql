GO
DROP VIEW journal_view; 
GO
CREATE VIEW journal_view ([id], [carId], [driverId], [departure], [weight], [distance], [arrival], [departureDate], [deparureTime], [arrivalDate], [arrivalTime], [lastName])
AS SELECT journal1.[id], journal1.[carId], journal1.[driverId], journal1.[departure], journal1.[weight], journal1.[distance], journal1.[arrival], journal1.[departureDate],
 journal1.[deparureTime], journal1.[arrivalDate], journal1.[arrivalTime], driver1.lastName
FROM [Cariages].[dbo].[Journal] AS journal1
LEFT JOIN 
[Cariages].[dbo].[Driver] AS driver1
ON journal1.driverId = driver1.id

SELECT driverId, SUM(distance) FROM journal_view GROUP BY driverId HAVING SUM(distance) = (SELECT MAX(temp1.duration) from (SELECT SUM(distance) as duration FROM journal_view GROUP BY driverId) as temp1)


SELECT * FROM 
[Cariages].[dbo].[Driver] as result2
LEFT JOIN  
(SELECT driverId, SUM(distance) FROM journal_view GROUP BY driverId HAVING SUM(distance) = (SELECT MAX(temp1.duration) from (SELECT SUM(distance) as duration FROM journal_view GROUP BY driverId) as temp1))
ON temp1.driverId = result2.id;




**********************************************************************************************************************



**********************************************************************************************************************



**********************************************************************************************************************




**********************************************************************************************************************


**********************************************************************************************************************


**********************************************************************************************************************



**********************************************************************************************************************



