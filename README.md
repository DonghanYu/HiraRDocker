# HiraRDocker

## Overview ##

This repository contains Dockerfiles for different Docker containers of interest to R users. 

## Getting Started ##

To get started right away, ensure you have [Docker installed](https://docs.docker.com/installation/) first.

1) HIRA_R_3_5_CDSW 
1-1) Build a dockerfile to the image with `docker build -t hira_cdsw:latest .`
1-2) Start a container with `docker run -dit hira_cdsw`
1-3) Check the name of container with `docker ps`
1-4-1) Execute a terminal with `winpty docker exec -it [container name] bash`
1-4-2) If you are in powershell, please execute a terminal with `powershell docker exec -it [container name] bash`

2) HIRA_R_3_5_Rstudio
1-1) Build a dockerfile with `docker build -t hira_rstudio:latest .`
1-2) Start a container with `docker run -dit -p 8787:8787 -e PASSWORD=password -e ROOT=TRUE hira_rstudio`.
1-3) You can access the Rstudio with `localhost:8787` in your chrome browser
1-4) ID: rstudio (default) Password: password

## Status ##

This is work in progress.