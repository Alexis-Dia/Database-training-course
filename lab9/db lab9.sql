**********************************************************************************************************************
USE [Cariages]

GO
CREATE FUNCTION CarAge(@number varchar(250))
RETURNS INT
BEGIN
DECLARE @age smalldatetime
SET @age = (SELECT [year] FROM [Cariages].[dbo].[Car] WHERE [number] = @number)
RETURN (YEAR(GETDATE()) - YEAR(@age))
END

DROP FUNCTION CarAge

GO
SELECT dbo.CarAge('HT-8381') AS CarAge
SELECT dbo.CarAge('HT-0105') AS CarAge

**********************************************************************************************************************

USE [Cariages]

GO
CREATE FUNCTION CarListByDeparture(@departureDate smalldatetime)
RETURNS TABLE
AS
RETURN
SELECT c.*, j.departure
FROM [Cariages].[dbo].[Journal] j
INNER JOIN
[Cariages].[dbo].[Car] c
ON j.carId = c.id
WHERE [departure] = @departureDate

DROP FUNCTION CarListByDeparture

GO
SELECT * FROM dbo.CarListByDeparture('2019-12-08 00:00:00')


**********************************************************************************************************************

GO
CREATE FUNCTION CariagesWithDriverAndBrand()
RETURNS TABLE
AS
RETURN
SELECT b.brand, result3.* FROM [Cariages].[dbo].[Brand] AS b
RIGHT JOIN
(SELECT d.lastName, d.firstName, d.patronymic, result2.* FROM [Cariages].[dbo].[Driver] AS d
RIGHT JOIN
(SELECT c.brandId, c.year, c.number, result1.carId, result1.driverId FROM [Cariages].[dbo].[Car] AS c
RIGHT JOIN
(SELECT j.departure, j.carId, j.driverId FROM [Cariages].[dbo].[Journal] AS j WHERE
departure >= dateadd(day, (8 - datepart(dw, getdate())), CONVERT(date,getdate()))
AND departure <  dateadd(day, 7 + (8 - datepart(dw, getdate())), CONVERT(date,getdate())))  AS result1
ON c.id = result1.carId) AS result2
ON d.id = result2.driverId) AS result3
ON b.id = result3.brandId

DROP FUNCTION CariagesWithDriverAndBrand

GO
SELECT * FROM dbo.CariagesWithDriverAndBrand()

**********************************************************************************************************************




