-- Experiments adding and removing big varbinary data

-- DBCC SHRINKFILE (N'Test001' , 1)
-- DBCC SHRINKFILE (N'Test001_log' , 1)

-- Create the test table
--CREATE TABLE dbo.DataTable ( ID int NOT NULL IDENTITY (1, 1), Name nvarchar(50) NOT NULL, BinData varbinary(MAX) NULL )  ON [PRIMARY]	 TEXTIMAGE_ON [PRIMARY]
--ALTER TABLE dbo.DataTable ADD CONSTRAINT PK_DataTable PRIMARY KEY CLUSTERED ( ID ) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]


DECLARE @i int = 0


-- fill a big Varbinary variable
DECLARE @bigVarbin varbinary (max) = 0x;  -- empty
SET @i = 0
WHILE @i < 200
BEGIN
    SET @i = @i + 1   
	SELECT @bigVarbin = @bigVarbin + CRYPT_GEN_RANDOM(1000) ; 
END
select Len(@bigVarbin)


-- empty table
TRUNCATE TABLE [DataTable]


-- fill the table
SET @i = 0
WHILE @i < 1000
BEGIN
    SET @i = @i + 1   
	INSERT INTO [DataTable] ([Name],[BinData]) VALUES ('name', @bigVarbin);	
END
SELECT top(5) * FROM DataTable
SELECT count(1) FROM DataTable


-- remove part of the data
EXEC sp_spaceused 'DataTable';
UPDATE [DataTable] SET [BinData] = NULL WHERE ID >500
--DELETE FROM [DataTable] WHERE ID >500
EXEC sp_spaceused 'DataTable';


 
 