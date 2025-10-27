#!/bin/bash

set -e

sudo -v

if [ $? -ne 0 ]; then
  echo "Falha na autenticação. Saindo..."
  exit 1
fi

if ( "$HOSTNAME" -ne "techsense"); then
sudo hostnamectl set-hostname "techsense"
echo "Reinicie o Armbian, o nome do host será alterado para techsense, se estiver acessando via rede acesse através do novo nome"
fi

# Add Docker's official GPG key:
sudo apt update
sudo apt install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.>
sudo apt update

sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

if [ $? -ne 0 ]; then
  echo "Falha na instalação de dependências. Saindo..."
  exit 1
else

git clone -b feat/dashboard-modv1 https://github.com/damacosta/frontend-bh.git

docker-compose up -d

fi
