---
layout: notes
---

# Application Insights queries


#### Billed /ingest data

```c
union *
| where timestamp > ago(24h)
| summarize Bytes=sum(_BilledSize), Cnt=count() by bin(timestamp, 1h)
```


#### Applicaton Insights and connected Log Analytics workspaces

```c
resources
| where ['type'] == "microsoft.insights/components"  
| project name, WorkSpaceID = tostring(split(properties.WorkspaceResourceId, "/")[-1])
| order by WorkSpaceID
```

