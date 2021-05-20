truncate table Food

DBCC SHRINKFILE (N'Test001' , 1)
DBCC SHRINKFILE (N'Test001_log' , 1)

-- TABLOCK,
-- BATCHSIZE=1000,
-- , FIELDTERMINATOR = ','

BULK INSERT Food FROM 'food.csv' WITH (BATCHSIZE=100, CODEPAGE='1252',  FIRSTROW=2 , FIELDTERMINATOR = ',', MAXERRORS = 2000)

select count(1) from Food

exec sys.sp_spaceused  @objname='Food'   

ALTER INDEX [PK_Food] ON  Food REBUILD 

exec sys.sp_spaceused  @objname='Food' 
 

DBCC SHRINKFILE (N'Test001' , 1)
DBCC SHRINKFILE (N'Test001_log' , 1)
