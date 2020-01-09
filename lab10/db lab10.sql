**********************************************************************************************************************
DROP TRIGGER journalCheck
DROP TRIGGER checkArrival
DROP TRIGGER checkDeparture

USE [Cariages]
GO

GO
CREATE TABLE [dbo].[audit_journal] (
recdate SMALLDATETIME,
carIdOld INT,
carIdNew INT ,
driverIdOld INT,
driverIdNew INT ,
departureOld SMALLDATETIME,
departureNew SMALLDATETIME ,
weightOld DECIMAL(18, 2),
weightNew DECIMAL(18, 2) ,
distanceOld DECIMAL(18, 2),
distanceNew DECIMAL(18, 2) ,
arrivalNew SMALLDATETIME,
arrivalOld SMALLDATETIME );

GO
CREATE Trigger journalCheck ON dbo.Journal AFTER
UPDATE, DELETE
AS
BEGIN
DECLARE @carIdOld INT, @carIdNew INT
DECLARE @driverIdOld INT, @driverIdNew INT
DECLARE @departureOld SMALLDATETIME, @departureNew SMALLDATETIME
DECLARE @weightOld DECIMAL(18, 2), @weightNew DECIMAL(18, 2)
DECLARE @distanceOld DECIMAL(18, 2), @distanceNew DECIMAL(18, 2)
DECLARE @arrivalOld SMALLDATETIME, @arrivalNew SMALLDATETIME
SET @carIdOld = (select [carId] from deleted)
SET @carIdNew = (select [carId] from inserted)
SET @driverIdOld = (select [driverId] from deleted)
SET @driverIdNew = (select [driverId] from inserted)
SET @departureOld = (select [departure] from deleted)
SET @departureNew = (select [departure] from inserted)
SET @weightOld = (select [weight] from deleted)
SET @weightNew = (select [weight] from inserted)
SET @distanceOld = (select [distance] from deleted)
SET @distanceNew = (select [distance] from inserted)
SET @arrivalOld = (select [arrival] from deleted)
SET @arrivalNew = (select [arrival] from inserted);
INSERT INTO [dbo].[audit_journal] VALUES
(GETDATE(), @carIdOld, @carIdNew, @driverIdOld, @driverIdNew, @departureOld, @departureNew,
@weightOld, @weightNew, @distanceOld, @distanceNew, @arrivalOld, @arrivalNew)
END

SELECT * FROM [dbo].[audit_journal];

DROP TRIGGER journalCheck
DROP TRIGGER checkArrival
DROP TRIGGER checkDeparture
DROP table [dbo].[audit_journal]

DELETE FROM [dbo].[audit_journal]
WHERE id = 44

UPDATE [dbo].[Journal]
SET [arrival] = '2020-01-30 18:59:00'
WHERE [id] = 43

**********************************************************************************************************************

DROP TRIGGER journalCheck
DROP TRIGGER checkArrival
DROP TRIGGER checkDeparture

USE [Cariages]
GO

GO
CREATE TRIGGER checkDeparture ON dbo.Journal
AFTER INSERT, UPDATE
AS
BEGIN
DECLARE @departure SMALLDATETIME
SET @departure = (SELECT departure FROM inserted)
IF (8 = datepart(m, @departure) AND 31 = datepart(d, @departure))
BEGIN
ROLLBACK TRANSACTION
PRINT 'День дальнобойщика, вы не можете задавать в БД запись на этот день!'
END
ELSE PRINT 'Строка вставлена/изменена'
END

select departure from Journal;
datepart(@departure, getdate())

DROP TRIGGER journalCheck
DROP TRIGGER checkArrival
DROP TRIGGER checkDeparture

USE [Cariages]
GO

INSERT INTO [dbo].[Journal]
           ([carId]
           ,[driverId]
           ,[departure]
           ,[weight]
           ,[distance]
           ,[arrival]
           ,[departureDate]
           ,[deparureTime]
           ,[arrivalDate]
           ,[arrivalTime])
     VALUES
           (4
           ,1
           ,'2019-08-30 11:00:00.000'
           ,144.0
           ,244.0
           ,'2019-08-30 20:00:00.000'
           ,'2019-08-30'
           ,'11:00:00.000'
           ,'2019-08-30'
           ,'20:00:00.000')
GO


**********************************************************************************************************************

DROP TRIGGER journalCheck
DROP TRIGGER checkArrival
DROP TRIGGER checkDeparture

USE [Cariages]
GO

GO
CREATE TRIGGER checkArrival ON dbo.Journal AFTER INSERT
AS
BEGIN
DECLARE @departure SMALLDATETIME
DECLARE @arrival SMALLDATETIME
SET @departure = (SELECT departure FROM inserted)
SET @arrival = (SELECT arrival FROM inserted)
if @departure < @arrival
begin
UPDATE [Journal]
SET arrival = departure
end
END

DROP TRIGGER journalCheck
DROP TRIGGER checkArrival
DROP TRIGGER checkDeparture

USE [Cariages]
GO

INSERT INTO [dbo].[Journal]
           ([carId]
           ,[driverId]
           ,[departure]
           ,[weight]
           ,[distance]
           ,[arrival]
           ,[departureDate]
           ,[deparureTime]
           ,[arrivalDate]
           ,[arrivalTime])
     VALUES
           (4
           ,1
           ,'2019-11-15 11:00:00.000'
           ,399.0
           ,199.0
           ,'2019-11-17 11:00:00.000'
           ,'2019-11-15'
           ,'11:00:00.000'
           ,'2019-11-17'
           ,'11:00:00.000')
GO


**********************************************************************************************************************

DROP TRIGGER journalCheck
DROP TRIGGER checkArrival
DROP TRIGGER checkDeparture
DROP TRIGGER prevent_drop_triggers

USE [Cariages]
GO

create trigger prevent_drop_trigger on database
for drop_trigger
as print 'For removing trigger its necesery to disable prevent_drop_triggers'
rollback

DROP TRIGGER checkDeparture

**********************************************************************************************************************




