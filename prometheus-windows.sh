#!/bin/bash

Installing Prometheus 

1. Go to Prometheus Download page at https://prometheus.io/download/
2. Search stable (LTS) version of Prometheus, select windows platform
3. Install prometheus untill finish
4. Run Prometheus.exe
4. Test it using http://localhost:9090

Installing Windows Exporter
1. Download windows exporter MSI Installation using latest release on https://github.com/prometheus-community/windows_exporter/releases/tag/v0.31.3
2. Install windows exporter untill finish
3. Test it using http://localhost:9182
4. Keep Windows Exporter Default Config

Configure Prometheus Server Configuration
1. edit prometheus.yml config
2. Add this config below 

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
   
  - job_name: "node_exporter_metrics"
    scrape_interval: 5s
    static_configs:
      - targets: ["localhost:9182"]

3. Restart Prometheus, then check again in Grafana Dashboard
4. Check also in prometheus web page in localhost:9090, makesure windows exporter is UP