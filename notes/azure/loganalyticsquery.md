---
layout: notes
---

# Log Analytics queries

### General

#### Number of items per type

```c
union *
| where TimeGenerated > ago(20d)
| summarize CNT=count() by bin(TimeGenerated, 1d), Type
| order by TimeGenerated, Type
| render areachart 
```

### One Log Analytics collects data from different application insights

#### Requests per AppName

```c
AppRequests 
| where TimeGenerated > ago(7d)
| project TimeGenerated, appname=tostring(split(_ResourceId, "/")[-1])
| summarize count() by appname, bin(TimeGenerated, 4h)
| render areachart 
```


#### Billed data per AppName

```c
union *    
| where TimeGenerated > ago(30d)
| project TimeGenerated, ResourceID=tostring(split(_ResourceId, "/")[-1]), _BilledSize
| summarize BilledSizeMB= sum(_BilledSize) / 1024/1024 by  ResourceID, bin(TimeGenerated, 1d)
| render areachart
```



