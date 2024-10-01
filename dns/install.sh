#!/bin/bash

sudo mkdir -p /etc/systemd/system/dnsmasq.service.d/

for file in $(ls *.conf); do
  dest=$(head -n1 $file | sed "s/# //g")
  sudo unlink "${dest}"
  sudo cp "${file}" "${dest}"
done

sudo systemctl enable dnsmasq
sudo systemctl start dnsmasq
echo "sudo systemctl status dnsmasq"

sudo systemctl restart NetworkManager
echo "sudo systemctl status NetworkManager"

sudo systemctl restart systemd-resolved
echo "sudo systemctl status systemd-resolved"
