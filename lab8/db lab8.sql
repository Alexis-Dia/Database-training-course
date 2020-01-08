**********************************************************************************************************************

USE [Cariages]

GO

CREATE PROCEDURE NUMBERS
(@Output int OUTPUT)
AS
SELECT c.brandId, c.[year], c.[number]
FROM [Car] c
WHERE YEAR(c.[year]) = @Output

DROP PROCEDURE NUMBERS

GO
EXECUTE NUMBERS @Output=2010


**********************************************************************************************************************

USE [Cariages]

GO
INSERT INTO [dbo].[Driver] ([lastName],[firstName],[patronymic],[birthDay])
     VALUES ('Ivanov5','Ivan5','Ivanovich5', GETDATE())

GO
CREATE PROCEDURE BIRTHDAYS
AS
SELECT d.[lastName], d.[firstName], d.[patronymic], d.[birthDay]
FROM [Driver] AS d
WHERE MONTH(d.[birthDay]) = MONTH(GETDATE()) AND DAY(d.[birthDay]) = DAY(GETDATE())

DROP PROCEDURE BIRTHDAYS

GO
EXECUTE BIRTHDAYS

**********************************************************************************************************************

USE [Cariages]

GO
CREATE PROCEDURE SUMMARY_DISTANCE
(@Summary_distance int OUTPUT)
AS
SELECT c.number, j.summary_distance FROM 
[Cariages].[dbo].[Car] AS c
INNER JOIN
(SELECT carId, SUM(distance) as summary_distance FROM [Cariages].[dbo].[Journal] GROUP BY carId) as j
ON c.id = j.carId
WHERE @Summary_distance >= summary_distance
GO

DROP PROCEDURE SUMMARY_DISTANCE

GO
EXECUTE SUMMARY_DISTANCE @Summary_distance=443


**********************************************************************************************************************



