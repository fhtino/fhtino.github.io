---
layout: notes
---

# Azure misc

## Virtual Machines

### Remove old 2.0 diagnostic extension from Linux VM

```<language>
az vm extension list --resource-group MyResGroupName --vm-name MyVMName  
az vm extension delete --name Microsoft.Insights.VMDiagnosticsSettings --resource-group MyResGroupName --vm-name MyVMName  
```

## Application Insights and Log Analytics

List Applicaton Insights and connected Log Analytics Workspace
```<language>
resources
| where ['type'] == "microsoft.insights/components"  
| project name, WorkSpaceID = tostring(split(properties.WorkspaceResourceId, "/")[-1])
| order by WorkSpaceID
```
