# Dockerfile

# Specify a Cloudera Data Science Workbench base image
FROM docker.repository.cloudera.com/cdsw/engine:8
RUN rm /etc/apt/sources.list.d/*

# install java develop kit and rJava
RUN apt-get update && \
    apt-get install -y default-jdk
RUN R CMD javareconf
RUN R -e "install.packages('rJava', dependencies = TRUE)"

# install devtools
RUN apt-get update
RUN apt-get install -y \
    build-essential \ 
    libcurl4-gnutls-dev \
    libxml2-dev \
    libssl-dev \
    libgit2-dev \
# install other
    libfontconfig1-dev \
    libcairo2-dev \
    libharfbuzz-dev \
    libfribidi-dev \
    libfreetype6-dev \
    libpng-dev \
    libtiff5-dev \
    libjpeg-dev \
    libboost-dev

RUN apt install -y software-properties-common
RUN apt-add-repository ppa:cran/libgit2
RUN apt-get update
RUN apt-get install -y libssh2-1-dev libgit2-dev 
ADD pkgs /home/cdsw/pkgs

RUN R -e "baseR = as.data.frame(installed.packages()); pkgs = read.csv('/home/cdsw/pkgs/pkgs.csv'); toInstall = setdiff(pkgs[,1], baseR[,1]); install.packages(toInstall)"

# create folders
RUN mkdir -p /home/cdsw/rstudio/temp
RUN mkdir -p /home/cdsw/rstudio/jdbc
RUN mkdir -p /home/cdsw/rstudio/analysis
RUN mkdir -p /home/cdsw/rstudio/result

RUN R -e "setwd('/home/cdsw/pkgs'); install.packages('BH'); install.packages('/home/cdsw/pkgs/RcppEigen_0.3.3.7.0.tar.gz', repos = NULL, type = 'source'); install.packages('/home/cdsw/pkgs/openxlsx_4.1.0.tar.gz', repos = NULL, type = 'source'); install.packages('/home/cdsw/pkgs/latticeExtra_0.6-28.tar.gz', repos = NULL, type = 'source'); install.packages('rms'); install.packages('Hmisc'); devtools::install('./Andromeda', upgrade = 'never'); devtools::install('./DatabaseConnector', upgrade = 'never'); devtools::install('./ParallelLogger', upgrade = 'never'); devtools::install('./FeatureExtraction', upgrade = 'never'); devtools::install('./Cyclops', upgrade = 'never'); devtools::install('./EmpiricalCalibration', upgrade = 'never'); devtools::install('./MethodEvaluation', upgrade = 'never');  devtools::install('./OhdsiRtools', upgrade = 'never'); devtools::install('./OhdsiSharing', upgrade = 'never'); devtools::install('ROhdsiWebApi', upgrade = 'never'); devtools::install('./CohortMethod', upgrade = 'never'); devtools::build('./CohortDiagnostics'); devtools::build('./PatientLevelPrediction')"

# install JDBC driver
#RUN R -e "DatabaseConnector::downloadJdbcDrivers(dbms = 'oracle',pathToDriver = '/home/cdsw/rstudio/jdbc')"

# PLP settings
#RUN R -e "reticulate::install_miniconda()"
#RUN R -e "PatientLevelPrediction::configurePython(envname='r-reticulate', envtype = 'conda');devtools::install_github('rstudio/keras');keras::install_keras(method = 'conda');"
#RUN R -e "reticulate::conda_install(envname='r-reticulate', packages = c('scikit-survival'), forge = T, pip = T)"
#RUN R -e "reticulate::conda_install(envname='r-reticulate', packages = c('pytorch', 'torchvision', 'cpuonly'), forge = TRUE, pip = FALSE, channel = 'pytorch', pip_ignore_installed = TRUE, conda = 'auto')"

