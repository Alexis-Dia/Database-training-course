SELECT 
      AVG([shortYear])
  FROM [Cariages].[dbo].[Car]
  
**********************************************************************************************************************

SELECT brand, COUNT(brand)
  FROM Cariages.dbo.Brand GROUP BY brand HAVING COUNT(brand) > 0

**********************************************************************************************************************

SELECT driverId, SUM(distance)
  FROM Cariages.dbo.Journal GROUP BY driverId

**********************************************************************************************************************

SELECT COUNT(*)
  FROM Cariages.dbo.Journal WHERE CONVERT(VARCHAR(250), departure, 126) LIKE '2019-11%'

**********************************************************************************************************************

SELECT driverId
  FROM Cariages.dbo.Journal WHERE distance = (SELECT MAX(distance) FROM Cariages.dbo.Journal)

**********************************************************************************************************************

  SELECT driverId, COUNT(driverId) counted_trip FROM Cariages.dbo.Journal WHERE CONVERT(VARCHAR(250), departure, 126) LIKE '2020-01%'  GROUP BY driverId

**********************************************************************************************************************

SELECT COUNT(*)/31.0 as averagePerMonth FROM Cariages.dbo.Journal WHERE CONVERT(VARCHAR(250), departure, 126) LIKE '2020-01%'

**********************************************************************************************************************



