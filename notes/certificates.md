---
layout: notes
---

|  |  |
| -- | -- |
| cer --> pfx without private key  | openssl pkcs12 -export -nokeys -in certificate.cer -out pkcs12.pfx |
| get info about server certificates | openssl s_client -showcerts -servername www.google.com -connect www.google.com:443 |
| verify certificate | certutil.exe -urlfetch -verify  certificate.cer |

- openssl: you can find openssl.exe already installed under "c:\Program Files\Git\usr\bin\openssl.exe"
- certutil: all parameters here 
https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/certutil


