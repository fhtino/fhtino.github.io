---
layout: notes
---

# GIT

## Username (and password) in the URL

*** Security risks and concerns, here! Be careful! ***  

You can specify username and password in the GIT https url. If you clone that way, the url with username and password will be stored in the .git/config file. Be careful!

The following examples use an Azure DevOps Personal Acces Token (PAT). In such a case, username is useless. Only PAT 'abc...xyz' is relevant for authentication.

```shell

git pull https://fake:abc...xyz@XXXXXX.visualstudio.com/DefaultCollection/XXXXX/_git/XXXXX  

git push https://fake:abc...xyz@XXXXXX.visualstudio.com/DefaultCollection/XXXXX/_git/XXXXX  HEAD

git pull https://fake:abc...xyz@XXXXXX.visualstudio.com/DefaultCollection/XXXXX/_git/XXXXX  HEAD

```
 
