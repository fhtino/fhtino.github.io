---
layout: notes
---

## Azure Virtual Machines

### Remove old 2.0 diagnostic extension from Linux VM

```<language>
az vm extension list --resource-group MyResGroupName --vm-name MyVMName  
az vm extension delete --name Microsoft.Insights.VMDiagnosticsSettings --resource-group MyResGroupName --vm-name MyVMName  
```

