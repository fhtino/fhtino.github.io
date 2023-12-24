---
layout: notes
---

# Azure Resources

## Queries

### Resources information (from AZ command line)
List information about resources: name, type, creation datetime, etc.

```
az resource list --query [].[name,type,createdTime] --output table --subscription "my subscription name" 
```

### Resources information (from Resource Graph Explorer)
Run from Resource Graph Explorer (e.g. Azure Portal --> All resources --> Open query)
```
resources
| project name, type, properties.creationTime, properties.CreationDate, properties
```