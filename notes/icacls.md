---
layout: notes
---

# icacls

Offical documentation: https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/icacls  

|  |  |
| -- | -- |
| ```icacls folderX /grant fooUser:(OI)(CI)F``` | Assign full control to fooUser on folderX  |
| ```icacls folderX /remove fooUser``` | Remove permissions for fooUser on folderX |
| ```icacls folderX /inheritance:e``` | Activate inheritance on folderX |
| ```icacls folderX /inheritance:d``` | Deactivate inheritance on folderX. Existing permission are copied. |
| ```icacls folderX /reset /t``` | **[Very dangerous]** Reset all the permissions to inherited only. | 


### Inheritance

Using /T with /grant like ```icacls folderX /grant fooUser:(OI)(CI)F /T``` is not the right way to apply the inheritance. The command apply the same permission to all items, traversing all sub-folders. 
If you want to apply inheritance correctly, activate the inheritance on the folder (normally it is already actve) and apply permission only to top-folder. Then Windows will propagate them to subfolders. This could require seconds or minutes if there are many files and folders. To check if a permission comes as inherited, check the presence of (I) on permissions list.

```
icacls notes /t

notes BUILTIN\Administrators:(I)(OI)(CI)(F)     
      BUILTIN\Users:(I)(OI)(CI)(RX)
      
notes\azfunctions BUILTIN\Administrators:(I)(OI)(CI)(F)                  
                  BUILTIN\Users:(I)(OI)(CI)(RX)                  

notes\wsl2.md BUILTIN\Administrators:(I)(F)             
              BUILTIN\Users:(I)(RX)             
```
