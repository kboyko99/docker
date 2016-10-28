#!/bin/sh +x

sudo chmod -R 777 '/etc/apt/sources.list'
sudo chmod -R 777 '/etc/apt/sources.list.d/'
sudo chmod -R 777 '/var/cache/apt/archives/'
sudo chmod -R 777 '/var/cache/debconf/'
sudo sed -i 's/wheezy/jessie/' '/etc/apt/sources.list'
sudo sed -i 's/wheezy/jessie/' '/etc/apt/sources.list.d/raspi.list'
sudo rm '/var/cache/apt/archives/lock'
sudo rm '/var/cache/debconf/*.dat'
sudo apt-get --yes purge $(dpkg -l | awk '/^rc/ { print $2 }')
git clone https://github.com/hypriot/rpi-docker-builder.git
sudo apt-get install -y apt-transport-https
wget -q https://packagecloud.io/gpg.key -O - | sudo apt-key add -
echo 'deb https://packagecloud.io/Hypriot/Schatzkiste/debian/ wheezy main' |  sudo tee '/etc/apt/sources.list.d/hypriot.list'
sudo apt-get install -y docker-hypriot
sudo usermod -aG docker $(whoami)
sudo systemctl enable docker
cd '~/rpi-docker-builder' | sudo sh build.sh || sudo sh build.sh | sudo sh run-builder.sh || make all
echo 'Docker info:'
sudo docker info
echo 'Docker version:'
docker version
