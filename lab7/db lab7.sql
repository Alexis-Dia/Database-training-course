GO
DROP VIEW journal_view; 
GO
CREATE VIEW journal_view ([id], [carId], [driverId], [departure], [weight], [distance], [arrival], [departureDate], [deparureTime], [arrivalDate], [arrivalTime], [fullName])
AS SELECT journal1.[id], journal1.[carId], journal1.[driverId], journal1.[departure], journal1.[weight], journal1.[distance], journal1.[arrival], journal1.[departureDate],
 journal1.[deparureTime], journal1.[arrivalDate], journal1.[arrivalTime], driver1.lastName + ' ' + driver1.firstName + ' ' + driver1.patronymic
FROM [Cariages].[dbo].[Journal] AS journal1
LEFT JOIN
[Cariages].[dbo].[Driver] AS driver1
ON journal1.driverId = driver1.id

SELECT [fullName], SUM(distance) as sum_distance FROM journal_view GROUP BY [fullName] HAVING SUM(distance) = (SELECT MAX(temp1.duration) from (SELECT SUM(distance) as duration FROM journal_view GROUP BY [fullName]) as temp1)


SELECT d.birthDay FROM
[Cariages].[dbo].[Driver] as d
RIGHT JOIN
(SELECT driverId AS a, SUM(distance) FROM journal_view  AS result1 GROUP BY driverId HAVING SUM(distance) = (SELECT MAX(temp1.duration) from (SELECT SUM(distance) as duration FROM journal_view GROUP BY driverId) as temp1)) AS result0
ON result0.driverId = d.id;

**********************************************************************************************************************

GO
DROP VIEW cariages_avg_view
GO
CREATE VIEW cariages_avg_view ([departure], [departureCount])
AS SELECT departure, CAST(COUNT(departure) as decimal(10,5)) FROM [Cariages].[dbo].[Journal] GROUP BY departure

SELECT * FROM cariages_avg_view
SELECT * FROM cariages_avg_view WHERE [departureCount] > (SELECT AVG([departureCount]) FROM cariages_avg_view)

**********************************************************************************************************************

GO
DROP VIEW cariages_min_max_distance_view
GO
CREATE VIEW cariages_min_max_distance_view ([driverId], [distance])
AS SELECT (driver1.lastName + ' ' + driver1.firstName + ' ' + driver1.patronymic), AVG(distance)
FROM [Cariages].[dbo].[Journal] AS journal1
LEFT JOIN
[Cariages].[dbo].[Driver] AS driver1
ON journal1.driverId = driver1.id
WHERE DATEPART(m, [departure]) = DATEPART(m, DATEADD(m, 0, getdate())) GROUP BY (driver1.lastName + ' ' + driver1.firstName + ' ' + driver1.patronymic);

SELECT * FROM cariages_min_max_distance_view ORDER BY distance DESC;


**********************************************************************************************************************

GO
DROP VIEW cariages_car_count_view
GO
CREATE VIEW cariages_car_count_view ([name], departureCount)
AS
SELECT (b.brand + ' ' + b.model + ' ' + result2.number), COUNT(departure) as departureCount FROM [Cariages].[dbo].[Brand] AS b
LEFT JOIN
(SELECT car1.brandId, car1.number, journal1.*
FROM [Cariages].[dbo].[Journal] AS journal1
LEFT JOIN
[Cariages].[dbo].[Car] AS car1
ON journal1.carId = car1.id) AS result2
ON result2.brandId = b.id
WHERE DATEPART(m, result2.departure) = DATEPART(m, DATEADD(m, -1, getdate()))  GROUP BY (b.brand + ' ' + b.model + ' ' + result2.number)

SELECT * FROM cariages_car_count_view;
SELECT * FROM cariages_car_count_view WHERE departureCount = (SELECT MAX(departureCount) FROM cariages_car_count_view);

**********************************************************************************************************************






