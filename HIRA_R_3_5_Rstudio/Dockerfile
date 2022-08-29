# Dockerfile

# Specify a Rocker/Rstudio image
FROM rocker/verse:3.5.1

LABEL maintanier "HIRA"

# install java develop kit and rJava
RUN apt-get update && \ 
    apt-get install -y default-jdk\
    build-essential \ 
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
    libboost-dev \
    libbz2-dev \
    libpcre3-dev \
    libssh2-1-dev \
    libgit2-dev 

RUN R CMD javareconf

# copy pkgs list
ADD pkgs /home/rstudio/pkgs

# create folders
RUN mkdir /home/rstudio/jdbc

# install/update packages using the cran latest/archive site
RUN R -e "source('/home/rstudio/pkgs/installPackages.R')"

