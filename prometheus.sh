#!/bin/bash

1. Download & Extract Prometheus Stable version on https://prometheus.io/download/
wget https://github.com/prometheus/prometheus/releases/download/v3.5.0/prometheus-3.5.0.linux-amd64.tar.gz
tar xvf prometheus-3.5.0.linux-amd64.tar.gz

2. Move prometheus binaries to /usr/local/bin

sudo mv prometheus-3.5.0.linux-amd64/prometheus /usr/local/bin/
sudo mv prometheus-3.5.0.linux-amd64/promtool /usr/local/bin/
sudo mkdir /etc/prometheus
sudo mv prometheus-3.5.0.linux-amd64/prometheus.yml /etc/prometheus
# sudo mv prometheus-3.5.0.linux-amd64/consoles /etc/prometheus
# sudo mv prometheus-3.5.0.linux-amd64/console_libraries /etc/prometheus

3. Set Executable permission
sudo chmod +x /usr/local/bin/prometheus
sudo chmod +x /usr/local/bin/promtool

3. Edit Prometheus Config to add Node Exporter in /etc/prometheus/prometheus.yml

# my global config
global:
  scrape_interval: 15s # Set the scrape interval to every 15 seconds. Default is every 1 minute.
  evaluation_interval: 15s # Evaluate rules every 15 seconds. The default is every 1 minute.
  # scrape_timeout is set to the global default (10s).

# Alertmanager configuration
alerting:
  alertmanagers:
    - static_configs:
        - targets:
          # - alertmanager:9093

# Load rules once and periodically evaluate them according to the global 'evaluation_interval'.
rule_files:
  # - "first_rules.yml"
  # - "second_rules.yml"

# A scrape configuration containing exactly one endpoint to scrape:
# Here it's Prometheus itself.
scrape_configs:
  # The job name is added as a label `job=<job_name>` to any timeseries scraped from this config.
  - job_name: "prometheus"

    # metrics_path defaults to '/metrics'
    # scheme defaults to 'http'.

    static_configs:
      - targets: ["localhost:9090"]
       # The label name is added as a label `label_name=<label_value>` to any timeseries scraped from this config.
        labels:
          app: "prometheus"
  - job_name: 'node_exporter'
    static_configs:
      - targets: ['localhost:9100']

4. Create Systemd Service for Prometheus Running
sudo vim /etc/systemd/system/prometheus.service

5. Add this configuration

[Unit]
Description=Prometheus
After=network.target

[Service]
User=prometheus
Group=prometheus
Type=simple
ExecStart=/usr/local/bin/prometheus --config.file=/etc/prometheus/prometheus.yml --storage.tsdb.path=/var/lib/prometheus/
Restart=on-failure

[Install]
WantedBy=multi-user.target

6. Add prometheus User
sudo useradd -rs /bin/false prometheus

7. Create folder for storing TSDB Prometheus Storage
sudo mkdir -p /var/lib/prometheus/

6. Reload System 
sudo systemctl daemon-reload
sudo systemctl start prometheus
sudo systemctl enable prometheus