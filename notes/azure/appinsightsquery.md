---
layout: notes
---

# Application Insights

## Queries on data

Run from Application Insight resource --> Logs

#### Billed ingested data

```c
union *
| where timestamp > ago(24h)
| summarize MBytes=sum(_BilledSize)/1024/1024, Cnt=count() by bin(timestamp, 1h)
```

## Queries on resources

Run from Resource Graph Explorer (e.g. Azure Portal --> All resources --> Open query)

### Applicaton Insights and connected Log Analytics workspaces

```
resources
| where ['type'] == "microsoft.insights/components" 
| project name, resourceGroup, location, WorkSpaceID = tostring(split(properties.WorkspaceResourceId, "/")[-1]), properties.IngestionMode
| order by WorkSpaceID
```

### Applicaton Insights Metric alert and connected ActionGroups

```
resources
| where type == 'microsoft.insights/metricalerts'
| order by type asc
| project  name, type, properties, actions = properties.actions
| mv-expand actions
| project  name, type, ActionGroup = split(actions.actionGroupId, "/")[-1]
| order by name asc
```

