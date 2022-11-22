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
