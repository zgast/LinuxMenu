#!/bin/sh
sudo cp -r ./setting-scripts/ ~/.setting-scripts
sudo chmod 777 -R ~/.setting-scripts/
sudo cp -r ./LinuxMenu/ /opt/LinuxMenu
sudo cp ./linux_menu.desktop /usr/share/applications/linux_menu.desktop

echo "successfully installed"
