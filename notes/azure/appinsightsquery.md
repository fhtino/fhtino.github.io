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

#### Applicaton Insights Metric alert and connected ActionGroups

```c
resources
| where type == 'microsoft.insights/metricalerts'
| order by type asc
| project  name, type, properties, actions = properties.actions
| mv-expand actions
| project  name, type, ActionGroup = split(actions.actionGroupId, "/")[-1]
| order by name asc
```

