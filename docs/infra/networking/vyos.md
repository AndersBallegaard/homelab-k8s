# Vyos
Two VYOS Routers are used to provide external connectivity to the cluster, eventually this should be automated using cloud-init for VYOS, but right now i can't be bothered, so this is how they are setup

## Specs
Both of the virtual routers have these specs, and are being run on proxmox. The specs are probably subject to change depending on the volume of traffic. But even with a full IPv6 internet routing table being annouced to them from AS201911 they seem happy with these modest specs.

* 1 core
* 2GB Ram
* 1 NIC in AS201911 Transit network
* 1 NIC in K8S network

## General router baseline
* Setup accounts
* Setup update checking
* Disable SSH Password auth

```bash
# Unless you want me, and only me to login to your router, i would sudgest changing this key
set system login user anders authentication public-keys JUMPHOST key 'AAAAB3NzaC1yc2EAAAADAQABAAABgQC8LOd5EgLmJiqWlikJMBNqn92c1TMyDYYJybmMRwu3ysOcf5jWwzVx1d6jZOPboH241Q3Rg59AtqJpFLEDis0myVvdLfcZa88DsjhfFUgDA4LMatItoUpqj2xKwJsTHKWjaSL5zVGv1rXOnMv3CA90Cye7NrEP11AxrLeCawpsQC/Gwcrc7JLoKrYK1bz2zPI9WwPonKhOUC0zfpAX9G9mj3Ybp7aogYAsBweoFw4X533usswFDkPZl9SYnetufEZ/XGgl3TFoDETsQ4Ddztazu9snPRwlIyAq2Lv1+tU2hc2lKu0AWv4zPehEdMz8dXodB1bfkD63Rpy004Naa+tboJnJQUUpfZqqVEpI0byp7t64suAU1IvmgZo02A3kg6m+HJuMU6k1hAbrgXttRWR/fRDSvdGydPiyi+8mSvVYrstcpH63mvMw2gVOkoDeBzP+ClejkCoTLuXSb38reAivG0j02FyyoWRrBumfBHJb6lC8hUHQi04DfX2B/G+0UVM='
set system login user anders authentication public-keys JUMPHOST type 'ssh-rsa'

set system name-server '2606:4700:4700::1111'
set system update-check auto-check
set system update-check url 'https://raw.githubusercontent.com/vyos/vyos-nightly-build/refs/heads/current/version.json'

set service ssh disable-password-authentication
set system domain-name 'k8s.srv6.dk'

set interfaces ethernet eth0 description 'AS201911_TRANSIT'
set interfaces ethernet eth1 description 'K8S_NETWORK'
```

## Firewall configuration
Since these servers are technicly directly connected to the internet, a few firewall rules to help secure the servers are in order. These are the rules i have chosen to create for now, mixing security with ease of administration. Obiviously, you probably want some thigher rules in enviorments where security is more of a concern

* I have other firewalls for the rest of my ASN so i generally trust anything from one of my ASN's IP's
* I am ok with permitting all outgoing traffic from the k8s cluster
* I want to allow port 80 and 443 in from the entire internet, for services.
* Obiviously ICMPv6, BGP, link local should also be allowed given the setup


```bash
set firewall ipv6 input filter default-action 'drop'
set firewall ipv6 input filter default-log
set firewall ipv6 input filter rule 1 action 'accept'
set firewall ipv6 input filter rule 1 description 'Allow everything from AS201911 (my networks)'
set firewall ipv6 input filter rule 1 source address '2a0e:97c0:ae0::/44'
set firewall ipv6 input filter rule 2 action 'accept'
set firewall ipv6 input filter rule 2 description 'Accept BGP'
set firewall ipv6 input filter rule 2 destination port '179'
set firewall ipv6 input filter rule 2 protocol 'tcp'
set firewall ipv6 input filter rule 3 action 'accept'
set firewall ipv6 input filter rule 3 description 'Accept link-local'
set firewall ipv6 input filter rule 3 source address 'fe80::/16'
set firewall ipv6 input filter rule 4 action 'accept'
set firewall ipv6 input filter rule 4 protocol 'ipv6-icmp'
set firewall ipv6 input filter rule 10 action 'accept'
set firewall ipv6 input filter rule 10 description 'Allow anything out from K8S'
set firewall ipv6 input filter rule 10 inbound-interface name 'eth1'
set firewall ipv6 input filter rule 30 action 'accept'
set firewall ipv6 input filter rule 30 description 'Allow HTTP/HTTPS to K8S'
set firewall ipv6 input filter rule 30 destination address '2a0e:97c0:ae3::/48'
set firewall ipv6 input filter rule 30 destination port 'http,https'
set firewall ipv6 input filter rule 30 protocol 'tcp'
```

## BGP Config
The BGP config here is quite simple, create peerings to AS201911, and create a listen group to dynamicly allow in K8S nodes. There is no reason to send anything other than a default route to the nodes, so we do that and limit the memory consumption to have more room for containers.
```bash
set policy prefix-list6 DEFAULT rule 1 action 'permit'
set policy prefix-list6 DEFAULT rule 1 prefix '::/0'
set policy route-map EXPORT_DEFAULT rule 10 action 'permit'
set policy route-map EXPORT_DEFAULT rule 10 match ipv6 address prefix-list 'DEFAULT'
set policy route-map EXPORT_DEFAULT rule 20 action 'deny'
set protocols bgp address-family ipv6-unicast redistribute connected
set protocols bgp listen range 2a0e:97c0:ae3:fff0::/64 peer-group 'K8S'
set protocols bgp neighbor 2a0e:97c0:ae0:102::1 address-family ipv6-unicast
set protocols bgp neighbor 2a0e:97c0:ae0:102::1 remote-as '201911'
set protocols bgp neighbor 2a0e:97c0:ae0:102::2 address-family ipv6-unicast
set protocols bgp neighbor 2a0e:97c0:ae0:102::2 remote-as '201911'
set protocols bgp peer-group K8S address-family ipv6-unicast route-map export 'EXPORT_DEFAULT'
set protocols bgp peer-group K8S password 'REPLACEWITHPASSWORD'
set protocols bgp peer-group K8S remote-as 'external'
set protocols bgp system-as '65666'
```

## Router specific configuration for r01.k8s.srv6.dk
```bash
set protocols bgp parameters router-id '127.0.1.1'
set interfaces ethernet eth0 address '2a0e:97c0:ae0:102::c001/64'
set interfaces ethernet eth1 address '2a0e:97c0:ae3:fff0::1/64'
set interfaces loopback lo address '2a0e:97c0:ae3:ffff::1/128'
set system host-name 'r01'

```

## Router specific configuration for r02.k8s.srv6.dk
To be build when the direction of everything is a bit more stable
```bash
set protocols bgp parameters router-id '127.0.1.2'
set interfaces ethernet eth0 address '2a0e:97c0:ae0:102::c002/64'
set interfaces ethernet eth1 address '2a0e:97c0:ae3:fff0::2/64'
set interfaces loopback lo address '2a0e:97c0:ae3:ffff::2/128'
set system host-name 'r02'
```