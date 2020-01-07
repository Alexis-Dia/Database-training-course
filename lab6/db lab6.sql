CREATE TABLE [Cariages].[dbo].[LongJourneys] (
	id int IDENTITY(1,1) NOT NULL,
	carId int,
	driverId int,
	departure smalldatetime,
	[weight] numeric(18,0),
	distance numeric(18,0),
	arrival smalldatetime,
	departureDate date,
	departureTime time(7),
	arrivalDate date,
	arrivalTime time(7)
);
INSERT INTO [Cariages].[dbo].[LongJourneys]
           ([carId]
           ,[driverId]
           ,[departure]
           ,[weight]
           ,[distance]
           ,[arrival]
           ,[departureDate]
           ,[departureTime]
           ,[arrivalDate]
           ,[arrivalTime])
SELECT carId,[driverId],[departure],[weight],[distance],[arrival],[departureDate],[deparureTime],[arrivalDate],[arrivalTime]
FROM  [Cariages].[dbo].[Journal]
WHERE (SELECT DATEDIFF(day, departure, arrival)) > 1;
SELECT * 
FROM  [Cariages].[dbo].[LongJourneys]
WHERE (SELECT DATEDIFF(day, departure, arrival)) > 1;

**********************************************************************************************************************

GO
ALTER TABLE [Cariages].[dbo].[Car] ADD [yearOfReceipt] smalldatetime;
GO
UPDATE [Cariages].[dbo].[Car] 
SET [yearOfReceipt] = DATEADD(YEAR, 2, year);
GO

SELECT * FROM [Cariages].[dbo].[Car]; 
ALTER TABLE [Cariages].[dbo].[Car] DROP COLUMN [yearOfReceipt];

**********************************************************************************************************************

USE [Cariages] 
CREATE INDEX indexYearNumber ON [Cariages].[dbo].[Car]([year], [number])

**********************************************************************************************************************

GO
INSERT INTO [dbo].[Car] ([brandId],[year],[number],[shortYear],[yearOfReceipt]) VALUES (4,'1988-06-21 00:00:00','VV-4321',1988,'1990-06-21 00:00:00')
INSERT INTO [dbo].[Car] ([brandId],[year],[number],[shortYear],[yearOfReceipt]) VALUES (4,'1979-06-21 00:00:00','VV-4321',1979,'1981-06-21 00:00:00')
GO
DELETE FROM [Cariages].[dbo].[Car]
WHERE (YEAR(GETDATE()) - YEAR([year])) > 25
SELECT * FROM [Cariages].[dbo].[Car]
GO


**********************************************************************************************************************

GO
INSERT INTO [dbo].[Driver] ([lastName],[firstName],[patronymic],[birthDay]) VALUES ('Vasilev', 'Arkadiy', 'Arkkadievich', '1923-04-04 00:00:00')
GO
DELETE FROM [Cariages].[dbo].[Driver]
WHERE (YEAR(GETDATE()) - YEAR([birthDay])) > 65
SELECT * FROM [Cariages].[dbo].[Driver]
GO


**********************************************************************************************************************


**********************************************************************************************************************



**********************************************************************************************************************



