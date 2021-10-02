---
layout: notes
---

|  |  |
| -- | -- |
| GET with client certificate | curl.exe --verbose --insecure --request GET --cert-type p12 --cert ./clientcert.pfx:pfxpassword https://www.example.com/helloworld |
| Output to null | curl.exe --output nul https://www.example.com/  |
| Speed limiter  | curl.exe --limit-rate 200k https://www.example.com/ |

