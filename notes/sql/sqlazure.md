---
layout: notes
---
# Sql Azure
## Indexes and statistics maintenance script

https://techcommunity.microsoft.com/t5/azure-database-support-blog/how-to-maintain-azure-sql-indexes-and-statistics/ba-p/368787  
https://github.com/yochananrachamim/AzureSQL/blob/master/AzureSQLMaintenance.txt  

## Count tables rows

```sql
SELECT OBJ.name AS ObjectName ,PS.row_count
FROM sys.dm_db_partition_stats AS PS
     INNER JOIN sys.objects AS OBJ ON PS.object_id = OBJ.object_id
     INNER JOIN sys.indexes AS IDX ON PS.object_id = IDX.object_id AND PS.index_id = IDX.index_id
WHERE IDX.is_primary_key = 1
ORDER BY OBJ.name
```

