---
layout: notes
---

# Azure Functions

## Custom home-page, catch-all and custom http bindings

Playing with `route` in `host.json` and `routePrefix` in `HttpTrigger`, we can get:
 - removing `/api` from the http URL
 - changing the home-page of the Function
 - create a catch-all for all not-mapped http requests
 - custom function mapping

&gt;&gt;&gt; **Some tricks are not official nor documented. Use them at your own risk.** &lt;&lt;&lt;

Remove the `/api` from URL, setting routePrefix to empty in the `host.json` file:

    "http": {
      "routePrefix": ""
    }

Custom homepage: create an http function with `Route = "/"`

```csharp
[FunctionName("HomePage")]
public static async Task<IActionResult> Run(
    [HttpTrigger(AuthorizationLevel.Anonymous, "get", "post", Route = "/")] HttpRequest req,
    ILogger log)
{            
    return new ContentResult()
    {
        Content = "<html><body><h1>This is my home page</h1></body></html>",
        ContentType = "text/html",
        StatusCode = 200
    };
}
```

Catch-all http requests, with `Route = "{*url}"`. Important: http function are mapped in alphabetic order. Name the catch all function with "zzz" or something similar at the beginning to place it a the end of list. Otherwise, it will hide some functions.

```csharp
[FunctionName("ZZZCatchAll")]
public static async Task<IActionResult> Run(
    [HttpTrigger(AuthorizationLevel.Anonymous, "get", "post", Route = "{*url}")] HttpRequest req,
    ILogger log)
{
    string responseMessage = $"Catch-all! - {DateTime.UtcNow.ToString("O")} - {req.Path}";
    return new OkObjectResult(responseMessage);
}
```

Custom path, e.g. `https//xxxxxxxxxxxxx.azurewebsites.net/mycustompath/isalive2`

```csharp
[FunctionName("isalive2")]
public static async Task<IActionResult> Run(
    [HttpTrigger(AuthorizationLevel.Anonymous, "get", "post", Route = "mycustompath/isalive2")] HttpRequest req,
    ILogger log)
{
    // ...
}
```

<br/>


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
