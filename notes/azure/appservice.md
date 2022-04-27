---
layout: notes
---

# App Service

## Logs types

Details here: https://docs.microsoft.com/en-us/azure/app-service/troubleshoot-diagnostic-logs  


|  |  Kudu | Notes |
| ------ | ------ | ------ |
| Application logging *1 | D:\home\LogFiles\Application\diagnostics-20220425.txt | # for .net core --> logging info <br/> # .net framework --> ? |
| Web server logging (file system) | D:\home\LogFiles\http\RawLogs | Standard W3C log files |
| Detailed Error Messages | D:\home\LogFiles\DetailedErrors\ErrorPage000026.htm | Max 50 files. One for each error response.  |
| Failed request tracing  | D:\home\LogFiles\W3SVC1083336721\fr000017.xml | Max 50 files. One file for each failed request (even 404) |

*1 : file system output : auto turns off in 12 hours.  Blob storage: no auto turn-off

<br/>
