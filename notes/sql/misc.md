---
layout: notes
---
# sql misc

## xact_abort

```sql
SET xact_abort ON
```

## Update statistics on all tables

```sql
DECLARE @currentTableName nvarchar(max) = ''

DROP TABLE IF EXISTS #tableListUpdateStats

SELECT '[' + table_schema + '].[' + table_name + ']' as TableNameFull INTO #tableListUpdateStats 
       FROM information_schema.tables WHERE TABLE_TYPE = 'BASE TABLE' ORDER BY table_schema, table_name

WHILE 1=1
BEGIN
	SET @currentTableName = (select top(1) TableNameFull from #tableListUpdateStats where TableNameFull > @currentTableName order by TableNameFull)
	IF @currentTableName IS NULL BREAK
	DECLARE @sqlCommand nvarchar(max)  = 'UPDATE STATISTICS ' + @currentTableName + ' '
	PRINT @sqlCommand
	EXEC sp_executesql  @sqlCommand	
END

DROP TABLE IF EXISTS #tableListUpdateStats
```
