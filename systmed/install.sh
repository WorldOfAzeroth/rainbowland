#!/bin/bash
sudo cp as.sh /usr/bin/
sudo cp ws.sh /usr/bin/
sudo cp authserver.service /lib/systemd/system/
sudo cp worldserver.service /lib/systemd/system/
sudo systemctl daemon-reload

