# Dockerfile

# Specify a Cloudera Data Science Workbench base image
FROM docker.repository.cloudera.com/cdsw/engine:8
RUN rm /etc/apt/sources.list.d/*

# Install java develop kit and rJava
RUN apt-get update && \
    apt-get install -y default-jdk
RUN R CMD javareconf
RUN R -e "install.packages('rJava', dependencies = TRUE)"

# Install other libs
RUN apt-get update && \
    apt-get install -y build-essential \ 
    libcurl4-gnutls-dev \
    libxml2-dev \
    libssl-dev \
    libgit2-dev \
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
RUN apt-get update && \ 
    apt-get install -y libssh2-1-dev \
    libgit2-dev 

# Copy pkgs into docker
ADD pkgs /home/cdsw/pkgs

# Create folders
RUN mkdir /home/cdsw/temp /home/cdsw/jdbc /home/cdsw/study /home/cdsw/result

# Install base packages
RUN R -e "baseR = as.data.frame(installed.packages()); pkgs = read.csv('/home/cdsw/pkgs/pkgs.csv'); toInstall = setdiff(pkgs[,1], baseR[,1]); install.packages(toInstall)"

# Install other packages for OHDSI packages
RUN R -e "setwd('/home/cdsw/pkgs'); install.packages('BH'); install.packages('/home/cdsw/pkgs/RcppEigen_0.3.3.7.0.tar.gz', repos = NULL, type = 'source'); install.packages('/home/cdsw/pkgs/openxlsx_4.1.0.tar.gz', repos = NULL, type = 'source'); install.packages('/home/cdsw/pkgs/latticeExtra_0.6-28.tar.gz', repos = NULL, type = 'source'); install.packages('rms'); install.packages('Hmisc');"

# Install OHDSI packages
RUN R -e "setwd('/home/cdsw/pkgs'); install.packages('/home/cdsw/pkgs/SqlRender_1.9.2.tar.gz', repos = NULL, type = 'source'); install.packages('/home/cdsw/pkgs/Andromeda_0.6.1.tar.gz', repos = NULL, type = 'source'); install.packages('/home/cdsw/pkgs/DatabaseConnector_5.0.4.tar.gz', repos = NULL, type = 'source'); install.packages('/home/cdsw/pkgs/ParallelLogger_2.0.2.tar.gz', repos = NULL, type = 'source'); install.packages('/home/cdsw/pkgs/FeatureExtraction_3.1.1.tar.gz', repos = NULL, type = 'source'); install.packages('/home/cdsw/pkgs/Cyclops_3.1.2.tar.gz', repos = NULL, type = 'source'); install.packages('/home/cdsw/pkgs/EmpiricalCalibration_2.1.0.tar.gz', repos = NULL, type = 'source'); install.packages('/home/cdsw/pkgs/MethodEvaluation_2.1.0.tar.gz', repos = NULL, type = 'source'); install.packages('/home/cdsw/pkgs/OhdsiRTools_2.0.0.tar.gz', repos = NULL, type = 'source'); install.packages('/home/cdsw/pkgs/OhdsiSharing_0.2.2.tar.gz', repos = NULL, type = 'source'); install.packages('/home/cdsw/pkgs/ROhdsiWebApi_1.3.1.tar.gz', repos = NULL, type = 'source'); install.packages('/home/cdsw/pkgs/CohortMethod_4.2.0.tar.gz', repos = NULL, type = 'source'); install.packages('/home/cdsw/pkgs/CohortDiagnostics_2.0.0.tar.gz', repos = NULL, type = 'source'); install.packages('/home/cdsw/pkgs/PatientLevelPrediction_5.0.5.tar.gz', repos = NULL, type = 'source');"

# Install JDBC driver for DatabaseConnector
RUN R -e "DatabaseConnector::downloadJdbcDrivers(dbms = 'oracle', pathToDriver = '/home/cdsw/jdbc')"

# Python configuration
RUN R -e "reticulate::install_miniconda()"
RUN R -e "PatientLevelPrediction::configurePython(envname='r-reticulate', envtype = 'conda');devtools::install_github('rstudio/keras');keras::install_keras(method = 'conda');"
RUN R -e "reticulate::conda_install(envname='r-reticulate', packages = c('scikit-survival'), forge = TRUE, pip = TRUE)"
RUN R -e "reticulate::conda_install(envname='r-reticulate', packages = c('pytorch', 'torchvision', 'cpuonly'), forge = TRUE, pip = FALSE, channel = 'pytorch', pip_ignore_installed = TRUE, conda = 'auto')"

