---
layout: notes
---

# Resources

## Queries

List information about resources: name, type, creation datetime, etc.

```
az resource list --query [].[name,type,createdTime] --output table --subscription "my subscription name" 
```

