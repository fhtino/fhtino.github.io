---
layout: notes
---
<br/>

|  |  |
| -- | -- |
| GET with client certificate | curl.exe --verbose --insecure --request GET --cert-type p12 --cert ./clientcert.pfx:pfxpassword https://www.example.com/helloworld |
| Output to null | curl.exe --output nul https://www.example.com/  |
| Speed limiter  | curl.exe --limit-rate 200k https://www.example.com/ |
| Force max tls version (1) | curl --verbose --tls-max 1.2 https://tls-v1-2.badssl.com:1012/ |


Notes:  
(1) supported opnly on recent verions. Tested on 7.79.1
