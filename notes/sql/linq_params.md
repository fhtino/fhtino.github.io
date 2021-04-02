---
layout: notes
---
# Hack: how to prevent Linq to Entities to use parameters

```
*** DRAFT ***
```

SQL query parameters are great and Sql Server deals with tehem correctly, saving pre-compiled and optimixed execution plans. 
But sometime, in some special cases, cached execution plans do not run fine with some parameters values. 
This is because the plan is created, and then cached, upon parameters values passed on the first call. Following calls could have values that would run faster using another plans. But it's too late: SQL server will continue to use the old plan.
A couple of interesting articles about the topic:  https://www.sqlshack.com/query-optimization-techniques-in-sql-server-parameter-sniffing/ and 
 https://www.sqlshack.com/sql-server-2016-parameter-sniffing/

To prevent SQL Server to reuse a previously cached plan, you have to use a different query. Even small changes into the query syntax, trigger SQL Server to recalculate the execution plan. 
These two queries generate two different cached plans. The two plans could be equivalent but from Sql Server point of view, they are two differnet plan linked to different quieries.
```SQL
SELECT id,name,age FROM Customer WHERE ID=4
SELECT id,name,age FROM Customer WHERE ID=7
```
If we use a parameter, the plan is cache once and always used, regardless the value of the parameter(s).
```SQL
SELECT id,name,age FROM user WHERE ID=@IDParam
```

As told, in some cases this is not the best behaviour and with millions of record, joins and complex where conditions the cached plan could behave very badly with some parameters and very well with some others. 
The two link highlights some approaches to solve this. 
However the real catch-all solution for these particular cases is not to use parameters at all.

### A useful query for looking at cached execution plans

Note: on some old (?) versiona of sql-server, [p].dbid is not filled. When filled, it's very usefull for restricting the query on target database only.

```SQL
SELECT top 50
[qs].[last_execution_time],
[p].dbid,
[qs].[execution_count],
[qs].[total_logical_reads]/[qs].[execution_count] [AvgLogicalReads],
[qs].[max_logical_reads],
[t].*,
[p].[query_plan]
FROM sys.dm_exec_query_stats [qs]
CROSS APPLY sys.dm_exec_sql_text([qs].sql_handle) [t]
CROSS APPLY sys.dm_exec_query_plan([qs].[plan_handle]) [p]
--WHERE 	[p].dbid=123
where [t].[text] like '%something%'
order by last_execution_time desc
```

## Entity Framework issues and parameters-free query
Unforunatelly, when working with EntityFramework, we do not have control over the automatically generated sql query. 
EF always uses parameters when possibile. Currently - as far as I know - there is no way to "ask" EF to create plain query without parameters.
But... in some cases, EF doesn't use parameters. One of them is the sql "IN" clause, Contains() in Linq. 
In such a case, EF generates a query like this:

```SQL
SELECT id,name,age FROM Customer WHERE countryID IN (78,12,4,154)
```

With only one element in Contains clause, the generated SQL is like this:

```SQL
SELECT id,name,age FROM Customer WHERE 89 = countryID 
```

In both cases, the query is "plain", without parameters. 
This will force SQL engine to create a new plane, re-evaluating which is the best strategy to use.

So, in some cases when can slightly change the Linq query to have a sql query without parameters. 
Example, instead of writing:

```csharp
int catID = 89;
var db = DBUtility.GetDBLogContext();
var query = from x in db.Customer select x;
query = query.Where(x => x.countryID == catID);
 ```
we can have the same output data writing this:

```csharp
int catID = 89;
var db = DBUtility.GetDBLogContext();
var query = from x in db.Customer select x;
int[] values = new int[] { catID };
query = query.Where(x => values.Contains(x.CategoryID));
```

The running sql query will be like this:
```SQL
SELECT 
   [Extent1].[ID] AS [ID], 
   [Extent1].[Name] AS [Name], 
   [Extent1].[Age] AS [Age], 
   [Extent1].[CountryID] AS [CountryID]
FROM  
   [Customers] AS [Extent1] 
WHERE 
   89 = [Extent1].[CategoryID] 
```

The generated sql query is "parameters free"  :)


