---
layout: notes
---

# Functions

## Usage Metrics and Billing

Azure Functions are billed based on **GB-seconds** and total number of executions. For each execution, it considers the GB of used RAM multiplied by the seconds of exectution. At the comment, in Europe region, it is &euro; 0.000015/GB-s and &euro; 0.183 per million of executions.  
Example: a function runs 10 times and every execution lasts 4 seconds and uses 0.5 GB ram:

| | Pricing | Total |
| -- | -- |
| 10 x 4 x 0.5 = 20 GB-s | &euro; 0.000015 /GB-s  | &euro; 0,0003 | 
| 10 runs |  &euro; 0.000000183 /run |  &euro; 0.00000183  |
| | | **&euro; 0.00030183** |


From the example it is clear that the majority of the costs of an Azure Function normally comes from RAM and execution time. So, keep RAS usage as low as possible, and be as fast as possible.


The metrics exposed on Azure Portal, are based on **MB-milliseconds**. So, a conversion is required: divided the MB-milliseonds value by 1024000 to get the GB-seconds value.  
Example: on a day, an Azure Function accumulated 4.5 billion MB-milliseconds. The corresponding GB-seconds is: `4.5 x 10^9 / 1024000 =~ 4.5 x 10^3 = 4500 GB-seconds` corresponding to &euro; 0.0675

<br/>To summarize:

| Description | Unit |
| --| -- |
| Billing Execution Unit |  GB-seconds |
| Portal and Metric Execution Unit | MS-milliseconds |
