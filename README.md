# IOT – PI4

Controle de ambiente de bancada eletrônica com ESP32‑S3, InfluxDB, MQTT e dashboard.

## Sobre
Este projeto, "IOT – PI4", é um sistema completo para monitoramento e controle de ambiente de bancada eletrônica.  
Ele utiliza o ESP32‑S3 para coleta de dados, MQTT para comunicação em tempo real, InfluxDB para armazenamento de séries temporais e Telegraf para integração.

## Tecnologias
- **ESP32‑S3** – microcontrolador responsável por ler sensores e enviar dados via MQTT.
- **MQTT / Mosquitto** – protocolo leve de mensagens para comunicação entre dispositivos.
- **InfluxDB** – banco de dados de séries temporais para armazenamento das leituras dos sensores.
- **Docker Compose** – orquestração dos serviços (MQTT, InfluxDB, Node‑RED, Grafana) em containers.
- **Python (simulator.py)** – script opcional para simular dados sensoriais.

## Estrutura do Repositório
- `Programa_ESP32_S3_PI4.ino` – código para o ESP32‑S3.
- `mosquitto.conf` – configuração do broker MQTT.
- `influxdb-init.iql` – script para inicialização do banco InfluxDB.
- `docker-compose.yml` – orquestração dos containers Docker.
- `simulator.py` – simula dados sensoriais (opcional).

## Instalação e Execução

1. **Clone o repositório**
```bash
git clone -b Back-ARM32V7 https://github.com/brunohss/IOT---PI4.git
cd IOT---PI4
```
2. Inicialize os serviços com Docker Compose na pasta do repositório
```bash
docker-compose up -d
```
   Apos isso abre o docker desktop clica em container e em icone de start

3. Carregue o firmware no ESP32‑S3 ou utilize o Simulador

    Abra Programa_ESP32_S3_PI4.ino no Arduino IDE ou VSCode PlatformIO e envie para o dispositivo.

    Rodar simulador de dados
```bash
pip install paho-mqtt
python3 simulator.py
```

5. Acesse as interfaces
  
    - MQTT: tcp://localhost:1883 (e websockets em 9001)

    - InfluxDB 1.8: http://localhost:8086 

Dica: veja logs se algo não subir:

```bash
docker compose ps
docker logs mosquitto
docker logs influxdb
```

6. Rodar o simulador (sem hardware)

    No seu host:
```bash
cd iot-bench-env
pip install paho-mqtt
python simulator.py
```

   Ele publica a cada 2s no tópico lab/bench/bench01/telemetry (JSON com temp, hum, lux, noise_db, co2, voc, pm25, pm10).
