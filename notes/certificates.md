---
layout: notes
---

# X509 Certificates - command line

|  |  |
| -- | -- |
| cer --> pfx without private key  | `openssl pkcs12 -export -nokeys -in certificate.cer -out pkcs12.pfx` |
| get info about server certificates | `openssl s_client -showcerts -servername www.google.com -connect www.google.com:443` |
| detailed tls handshake steps | `openssl s_client -connect www.google.com:443 -msg -tlsextdebug` |
| verify certificate | `certutil.exe -urlfetch -verify  certificate.cer` |
| dump tls versions and cipher suites | `nmap -script ssl-enum-ciphers -p 443 hostname` |
| http get with client certificate | `curl.exe --insecure https://server/mytest --verbose --cert-type P12 --cert certificate.pfx:password` |

- openssl: you can find openssl.exe already installed under "c:\Program Files\Git\usr\bin\openssl.exe"
- certutil: all parameters here 
https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/certutil


