#!/bin/bash

# Installing Grafana

# 1. Open Grafana Download Page
# https://grafana.com/grafana/download
# 2. Select version > 12.2.0, Edition > OSS (Not Enterprise)
# 3. Select for Windows
# 4. Download MSI Installer
# 5. Install the Grafana untill finish, test using http://localhost:3000

# Adding Prometheus as data source

# 1. Go to Data Source > Add New Data Source > Prometheus
# 2. Add Prometheus Server URL to http://localhost:9090 > Save & test
# 3. Next is to Configure Grafana Dashboard

# Import Dashboard for Windows Exporter

# 1. Go to Dashboard > New > Import 
# 2. Input Windows Exporter 2025 Latest Dashboard ID 23942 > Load
# 3. Select prometheus as Data Source 
# 4. We can find another Dashboard at grafana.com/dashboard
# 5. We can see the windows exporter dashboard on Grafana > Dashboard
