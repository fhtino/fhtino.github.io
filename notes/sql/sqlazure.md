---
layout: notes
---
# Sql Azure
## Indexes and statistics maintenance script

https://techcommunity.microsoft.com/t5/azure-database-support-blog/how-to-maintain-azure-sql-indexes-and-statistics/ba-p/368787  
https://github.com/yochananrachamim/AzureSQL/blob/master/AzureSQLMaintenance.txt  

## Contained datebase users

```sql
-- Create a 'contained database' user
CREATE USER Test1 WITH PASSWORD='aaaaHD&GFG/D%$!~3K984Bl*'  

-- Assign roles
EXEC sp_addrolemember 'db_datareader', 'Test1';
EXEC sp_addrolemember 'db_datawriter', 'Test1';

-- List users/roles
SELECT 
	members.[name] as user_name,
	roles.[name] as role_name
FROM sys.database_role_members 
    JOIN sys.database_principals roles ON database_role_members.role_principal_id = roles.principal_id
    JOIN sys.database_principals members ON database_role_members.member_principal_id = members.principal_id
ORDER BY 	
	members.[name], 
	roles.[name]
	
-- Delete the user
DROP USER Test1
```

## Count tables rows

```sql
SELECT OBJ.name AS ObjectName ,PS.row_count
FROM sys.dm_db_partition_stats AS PS
     INNER JOIN sys.objects AS OBJ ON PS.object_id = OBJ.object_id
     INNER JOIN sys.indexes AS IDX ON PS.object_id = IDX.object_id AND PS.index_id = IDX.index_id
WHERE IDX.is_primary_key = 1
ORDER BY OBJ.name
```

## Clear plan cache
Like the "old" DBCC FREEPROCCACHE

```sql
select count(*) from sys.dm_exec_cached_plans;
ALTER DATABASE SCOPED CONFIGURATION CLEAR PROCEDURE_CACHE;
select count(*) from sys.dm_exec_cached_plans;
```
