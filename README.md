# HiraRDocker

## Overview ##

이 레포지토리에는 HIRA CDM 사용자를 위한 Dockerfile이 포함되어 있습니다. 이 Dockerfile은 심사평가원의 내부 분석 환경을 모방한 것으로 외부 연구자들이 분석 패키지를 보다 쉽게 작성할 수 있도록 하기 위한 것입니다. dockerfile은 coludera data science workbench 이미지용과 rstudio 이미지용의 두 가지로 제공됩니다. R 3.5를 기반으로 기본 분석 패키지와 OHDSI 분석 패키지를 포함한 환경이 제공됩니다.

This repository contains Dockerfiles for the HIRA CDM users. This Dockerfile mimics HIRA's internal analysis environment and it is intended to make it easier for external researchers to write analysis packages. The dockerfiles are provided in two forms: coludera data science workbench image and rstudio image. Based on the R version 3.5, the default analysis package, the OHDSI analysis package.

## Getting Started ##

To get started right away, ensure you have [Docker installed](https://docs.docker.com/installation/) first.

## 1) HIRA_R_3_5_CDSW 

Dockerfile for the Cloudera DataScience Workbench with R version 3.5

1-1) Build a dockerfile to the image with `docker build -t hira_cdsw:latest .`

1-2) Start a container with `docker run -dit hira_cdsw`

1-3) Check the name of container with `docker ps`

1-4-1) Execute a terminal with `winpty docker exec -it [container name] bash`

1-4-2) If you are in powershell, please execute a terminal with `powershell docker exec -it [container name] bash`

## 2) HIRA_R_3_5_Rstudio

Dockerfile for the R studio with R version 3.5

1-1) Build a dockerfile with `docker build -t hira_rstudio:latest .`

1-2) Start a container with `docker run -dit -p 8787:8787 -e PASSWORD=password -e ROOT=TRUE hira_rstudio`.

1-3) You can access the Rstudio with `localhost:8787` in your chrome browser

1-4) ID: rstudio (default) Password: password

## Status ##

This is work in progress.
