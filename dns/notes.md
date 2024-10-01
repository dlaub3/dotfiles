## restart services and check check the logs

```bash
sudo systemctl enable dnsmasq
sudo systemctl start dnsmasq
sudo systemctl status dnsmasq

sudo systemctl restart NetworkManager
sudo systemctl status NetworkManager

sudo systemctl restart systemd-resolved
sudo systemctl status systemd-resolved
```

## debug

```bash
dig @127.0.0.1 my.domain +short
dig @127.0.0.53 my.domain +short # systemd-resolved
resolvectl query my.domain
nslookup my.domain
```
