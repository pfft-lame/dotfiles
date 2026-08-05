#!/bin/bash

cargo install kanata

# /usr/bin/ is managed by fedora/RPM, it might cause issues later
sudo mkdir -p /usr/local/bin/
sudo mv $HOME/.cargo/bin/kanata /usr/local/bin/
sudo chown root:root /usr/local/bin/kanata
sudo restorecone /usr/local/bin/kanata

# add systemd service file
sudo tee /etc/systemd/system/kanata.service >/dev/null <<'EOF'
[Unit]
Description=Kanata Service
Requires=local-fs.target
After=local-fs.target

[Service]
ExecStartPre=/usr/bin/modprobe uinput
ExecStart=/usr/local/bin/kanata -c /home/sharath/.config/kanata/kanata.kbd
Restart=no

[Install]
WantedBy=sysinit.target
EOF

# enable service
sudo systemctl daemon-reload
sudo systemctl enable --now kanata.service
