---
layout: notes
---
# Sql Server LocalDB
## Switching from an old to a newer version

By default LocalDB instance has the name **MSSQLLocalDB** and you can connect to using the standard name-server syntax:  **(localdb)\mssqllocaldb**  In my case, SSMS shows that my version is 13.1.4001.0.  
After installing LocalDB 2019 nothing changed. The LocalDB engine behind instance MSSQLLocalDB remains the old one.
My undestanding: if you already have an installed version of MS LocalDB, instaling a new one will not upgrade your running intance. You have to do it manually, deleting the old intance and creating a new one with the same name.   
Keep in mind that **you will lose the mapping** with all your corrunt databases. After updating, you must manually re-attach the mdf+ldf files using SSMS.

Move to the folder containing the latest version of SqlLocalDB.exe utily, in my case:
```
C:\Program Files\Microsoft SQL Server\150\Tools\Binn>
```

Verify the current running version with:
```
C:\\\> SqlLocalDB.exe info "MSSQLLocalDB"

Name:               MSSQLLocllDB
Version:            13.1.4001.0
Shared name:
Owner:              MyPC\MyUser
Auto-create:        Yes
State:              Running
Last start time:    06/03/2021 15:09:33
Instance pipe name: np:\\.\pipe\LOCALDB#EC724767\tsql\query
```

Close all application using LocalDB and then stop the instance:

```
C:\\\> SqlLocalDB.exe stop "MSSQLLocalDB"
LocalDB instance "MSSQLLocalDB" stopped.
```

Delete the current instance:

```
C:\\\> SqlLocalDB.exe delete "MSSQLLocalDB"
LocalDB instance "MSSQLLocalDB" deleted.
```

Create a new instance with the default name. SqlLocalDB.exe will automatically map it to the latest version of the engine.

```
C:\\\> SqlLocalDB.exe create "MSSQLLocalDB"
LocalDB instance "MSSQLLocalDB" created with version 15.0.2000.5.
```

Verify the runnig version:

```
C:\\\> SqlLocalDB.exe info "MSSQLLocalDB"
Name:               MSSQLLocalDB
Version:            15.0.2000.5
Shared name:
Owner:              MyPC\MyUser
Auto-create:        Yes
State:              Running
Last start time:    06/03/2021 15:15:17
Instance pipe name: np:\\.\pipe\LOCALDB#79DCB0D4\tsql\query
```

Re-attach the previously running database files  (SSMS --> Database --> Attach --> ... )
