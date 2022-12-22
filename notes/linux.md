---
layout: notes
---

# Linux

## Network IP address

https://netplan.io/reference

Edit network configuation and apply it:

```shell
sudo nano /etc/netplan/01-netcfg.yaml
```

```yaml
network:
  version: 2
  renderer: networkd
  ethernets:
    ens3:
      dhcp4: no
      addresses:
        - 192.168.1.10/24
      gateway4: 192.168.1.1
      nameservers:
        addresses: [192.168.1.1]
```

```shell
sudo netplan apply
```

Verify assigned address:

```shell
ip address
```
```shell
2: ens3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether XXXXXXXXXXXXXXX brd ff:ff:ff:ff:ff:ff
    inet 192.168.1.10/24 brd 192.168.1.255 scope global ens3
       valid_lft forever preferred_lft forever
    inet6 XXXXXXXXXXXXXXXX/64 scope link
       valid_lft forever preferred_lft forever
```

## Wait for a host to be available

```shell
#!/bin/bash

CheckIsAlive () {
  # $1 : hostname or ip address
  # $2 : tcp port
  # $3 : max number of retries
  # $4 : sleep between retries
  # $5 : nc timeout

  echo "start"
  echo $1 $2 $3 $4 $5
  counter_is_alive=0

  while [ $counter_is_alive -lt $3 ];
  do
    echo "Counter: $counter_is_alive"
    nc -zvw$5 $1 $2
    if [ $? -eq 0 ]; then counter_is_alive=$3; else sleep $4; fi
    let counter_is_alive=counter_is_alive+1
  done

  echo "end"
}

CheckIsAlive www.google.com 443 10 5 2
```