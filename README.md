# IOT – PI4

Controle de ambiente de bancada eletrônica com ESP32‑S3, MQTT, Telegraf, InfluxDB, Node.js, e NGINX.

## Sobre
Este projeto, "IOT – PI4", é um sistema completo para monitoramento e controle de ambiente de bancada eletrônica.  
Ele utiliza o ESP32‑S3 para coleta de dados, MQTT para comunicação em tempo real, Telegraf para integração, InfluxDB para armazenamento de séries temporais, um front-end desenvolvido em Vite+React rodando em Node.js, e um Proxy Reverso NGINX.

## Tecnologias
- **ESP32‑S3** – microcontrolador responsável por ler sensores e enviar dados via MQTT.
- **MQTT / Mosquitto** – protocolo leve de mensagens para comunicação entre dispositivos.
- **InfluxDB** – banco de dados de séries temporais para armazenamento das leituras dos sensores.
- **Docker Compose** – orquestração dos serviços (MQTT, InfluxDB, Node.js, NGINX) em containers.
- **Python (simulator.py)** – script opcional para simular dados sensoriais.

## Estrutura do Repositório
- `Programa_ESP32_S3_PI4.ino` – código para o ESP32‑S3.
- `mosquitto.conf` – configuração do broker MQTT.
- `Dockerfile` – configuração da construção do container do Front-End.
- `nginx.conf` – configuração do Proxy reverso NGINX.
- `influxdb-init.iql` – script para inicialização do banco InfluxDB.
- `docker-compose.yml` – orquestração dos containers Docker.
- `simulator.py` – simula dados sensoriais (opcional).

## Instalação e Execução

0. **Dependencias**

Essa versão é feita para ser executada em um ambiente Debian sendo executado em um sistema de arquitetura Arm V7 32bits

Se assegure de ter instalado Docker-CE, Docker-CE-CLI, Containerd.io, Docker-BuildX-Plugin, e Docker-Compose-Plugin.
Para instruções em como instalar em debian visite:
https://docs.docker.com/engine/install/debian/ 

Ou use armbian-config no Armbian e instale através da interface gráfica.

Recomenda-se também a instalação do Portainer-ce

1. **Clone o repositório do Back-End (este) e entre na pasta**

```bash
git clone -b Back-ARM32V7 https://github.com/brunohss/IOT---PI4.git
cd IOT---PI4
```

2. **Clone o repositório do Front-End**
```bash
git clone -b feat/auth https://github.com/damacosta/frontend-bh.git
```

3. Inicialize os serviços com Docker Compose na pasta do repositório

```bash
docker-compose up -d
```

   Apos isso abra o portainer clique em container e em icone de start

4. Carregue o firmware no ESP32‑S3 ou utilize o Simulador

    Abra Programa_ESP32_S3_PI4.ino no Arduino IDE ou VSCode PlatformIO e envie para o dispositivo.

    Rodar simulador de dados

5. Rodar o simulador (sem hardware)

    No seu host:

```bash
python -m venv simulator
./simulator/Scripts/Activate.ps1 #se no windows
pip install paho-mqtt
python simulator.py
```

   Ele publica a cada 2s no tópico lab/bench/bench01/telemetry (JSON com temp, hum, lux, noise_db, co2, voc, pm25, pm10).

6. Acesse o Front-End rodando em http://localhost:5173
