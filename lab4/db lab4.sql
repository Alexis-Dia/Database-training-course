
select * From Cariages.dbo.Driver where id IN (select driverId From Cariages.dbo.Journal where departure > (GETDATE() - 7));
 
**********************************************************************************************************************

select * From Cariages.dbo.Car where brandId IN (select id From Cariages.dbo.Brand where brand = 'VW');

**********************************************************************************************************************

SELECT *
FROM Cariages.dbo.Car
WHERE EXISTS (SELECT * FROM Cariages.dbo.Journal
WHERE Cariages.dbo.Car.id = Cariages.dbo.Journal.carId
AND Cariages.dbo.Car.brandId IN (SELECT Cariages.dbo.Brand.id FROM Cariages.dbo.Brand WHERE Cariages.dbo.Brand.brand IN ('VW', 'Scania')));

**********************************************************************************************************************

SELECT * FROM Cariages.dbo.Driver WHERE id IN (SELECT driverId FROM Cariages.dbo.Journal WHERE distance = (SELECT MAX(distance) FROM Cariages.dbo.Journal));


**********************************************************************************************************************

select * From Cariages.dbo.Driver where id NOT IN (select driverId From Cariages.dbo.Journal where departure > (GETDATE() - 3));


**********************************************************************************************************************


**********************************************************************************************************************


**********************************************************************************************************************



