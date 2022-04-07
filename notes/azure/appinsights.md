---
layout: notes
---

## Sampling

### Sampling in in Azure functions

**[[Tests done running Function locally on Visual Studio]]**

```json
  "logging": {
    "applicationInsights": {
      "enablePerformanceCountersCollection": false,
      "samplingSettings": {
        "isEnabled": true,
        "evaluationInterval": "00:00:10",
        "maxTelemetryItemsPerSecond": 2,
        "samplingPercentageDecreaseTimeout": "00:00:05",
        "samplingPercentageIncreaseTimeout": "00:00:05",
        "includedTypes": "Request"
      }
    }
  }
```

Important points:
 - maxTelemetryItemsPerSecond : the maximum number of Requests sent to Application Insights service when sampling is active. (see below)
 - samplingPercentageDecreaseTimeout and samplingPercentageIncreaseTimeout should be set to a low value, like 5 seconds. The default, 2 and 15 minutes, are too high. Low values allow the sampling algorithm to activate faster.
 - if you activate Request exclusion i.e. "excludedTypes": "Request"  the sampling will not work. This is because all activities in Azure Functions are requests.
 - "includedTypes": "Request" is not strictly required because it's the default. However, a more declarative config is better IMHO. 
 - disable performance counters if not really required --> "enablePerformanceCountersCollection": false
 - it's possible to fix a max and min sampling level with options maxSamplingPercentage and minSamplingPercentage
 - when running Functions on local emulator, it shows the application insights setup running values in the logs before starting the functions. This is usefull to check the real values used.

<br/>
<br/>

### Sampling in Asp.Net - .NET Framework

- Got to: App Service --> Kudu --> Debug console --> /site/wwwroot/
- Edit ApplicationInsights.config
- Add / edit the following section:

```
<!-- 4% sample fixed rate with a max of 5 items (i.e. requests) per seconds -->
<Add Type="Microsoft.ApplicationInsights.WindowsServer.TelemetryChannel.AdaptiveSamplingTelemetryProcessor, Microsoft.AI.ServerTelemetryChannel">
  <MaxTelemetryItemsPerSecond>5</MaxTelemetryItemsPerSecond>
  <InitialSamplingPercentage>4</InitialSamplingPercentage>
  <MinSamplingPercentage>4</MinSamplingPercentage>
  <MaxSamplingPercentage>4</MaxSamplingPercentage>
</Add>
```
 - Save and restart the app service
 
 
## Availability - web monitoring 

**Standard (preview) tests**

```
az monitor app-insights web-test list
az monitor app-insights web-test list --output table
az monitor app-insights web-test show --resource-group Monitoring --name httpscheck-xxxxx-httpmonitoring
az monitor app-insights web-test update --resource-group Monitoring --name httpscheck-xxxxx-httpmonitoring --timeout=10
```








