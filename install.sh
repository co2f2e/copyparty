#!/bin/bash
set -e

INSTALL_DIR="/opt/copyparty"
DATA_DIR="/opt/copyparty/data"
PORT=$1
USERNAME=$2
PASSWORD=$3

if [ "$#" -ne 3 ]; then
  echo "Usage: $0 <PORT> <USERNAME> <PASSWORD>"
  echo "Example: $0 5800 username password"
  exit 1
fi

echo "[1/5] Installing dependencies..."
apt update
apt install -y python3 wget

echo "[2/5] Creating directories..."
mkdir -p $INSTALL_DIR $DATA_DIR
cd $INSTALL_DIR

echo "[3/5] Downloading copyparty..."
wget -N https://github.com/9001/copyparty/releases/latest/download/copyparty-sfx.py
chmod +x copyparty-sfx.py

echo "[4/5] Creating systemd service..."
cat >/etc/systemd/system/copyparty.service <<EOF
[Unit]
Description=copyparty file server
After=network.target

[Service]
[Unit]
Description=copyparty file server
After=network.target

[Service]
EXECStar=/usr/bin/python3 /opt/copyparty/copyparty-sfx.py -v /opt/copyparty/data -a "$USERNAME:$PASSWORD" --http-only -p $PORT
WorkingDirectory=$INSTALL_DIR
Restart=always
RestartSec=5           
StartLimitBurst=3       
StartLimitIntervalSec=60 
User=root

[Install]
WantedBy=multi-user.target
EOF

echo "[5/5] Starting service..."
systemctl daemon-reexec
systemctl daemon-reload
systemctl enable copyparty
systemctl start copyparty

echo "===================================="
echo "copyparty installation completed"
echo "Access URL: http://$(hostname -I | awk '{print $1}'):$PORT"
echo "Username: $USERNAME"
echo "Password: $PASSWORD"
echo "===================================="
