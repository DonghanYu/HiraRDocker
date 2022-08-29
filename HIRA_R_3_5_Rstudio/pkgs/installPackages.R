# Install R packages

cran = 'http://cran.r-project.org'

# 1) basic install list
try(install.packages('rJava', dependencies = T));
basicList = c('rlang', 'lifecycle', 'vctrs', 'ellipsis', 'hms', 'purrr', 
              'progress', 'cpp11', 'tzdb', 'vroom', 'glue', 'cli', 'pillar',
              'R.methodsS3', 'R.oo', 'R.utils', 'tibble','tidyselect', 'dplyr',
              'tidyr', 'dbplyr', 'fastmap', 'htmltools', 'sass', 'Rserve', 'systemfonts',
              'gdtools','zip', 'uuid', 'officer', 'rvg', 'survival', 'sys', 'cachem',
              'jquerylib', 'openssl', 'isoband', 'ggplot2', 'htmlwidgets')

# 2) install dependency packages
baseR = as.data.frame(installed.packages('/usr/local/lib/R/site-library'));
baseR = rbind(baseR, as.data.frame(installed.packages(lib.loc = '/usr/local/lib/R/library')));
pkgs = read.csv('/home/rstudio/pkgs/pkgs.csv');
dependencies = unique(unlist(tools::package_dependencies(pkgs$Package)));
dependencies = dependencies[!is.element(dependencies, unique(baseR$Package))];

toPreInstall = c(basicList, dependencies)

if(length(toPreInstall) != 0) try(install.packages(toPreInstall, repos = cran));
rm(toPreInstall);

# 2) install packages or version update
install_diff = function(toInstall){for(i in 1:nrow(toInstall)){
  tryCatch({install.packages(paste0(toInstall[i,1]), repos = cran)},
           error = try({install.packages(paste0(cran, '/src/contrib/Archive/',
                                                toInstall[i,1], '/', toInstall[i,1], '_', toInstall[i,2], '.tar.gz'),
                                         repos = NULL, type ='source')}))}};

baseR = as.data.frame(installed.packages());
toInstall = merge(pkgs[,c(1,3)], baseR[,c(1,3)], by = c('Package'), all.x = T);
toInstall[,2] = as.character(toInstall[,2]); toInstall[,3] = as.character(toInstall[,3]);
toInstall_na = toInstall[is.na(toInstall$Version.y),];
toInstallList = toInstall_na
##### adding update when the major version has been changed
#toInstall = toInstall[substring(toInstall[,2],1,1) != substring(toInstall[,3],1,1),];
#toInstallList = rbind(toInstall, toInstall_na); 
#####
toInstallList = toInstallList[!is.na(toInstallList[,2]),];
toInstallList = unique(toInstallList);
install_diff(toInstallList);
rm(toInstallList);rm(baseR);rm(pkgs);

# 3) install OHDSI packages
install.packages('/home/rstudio/pkgs/Andromeda_0.6.1.tar.gz', repos = NULL, type = 'source');
install.packages('/home/rstudio/pkgs/SqlRender_1.9.2.tar.gz', repos = NULL, type = 'source');
install.packages('/home/rstudio/pkgs/DatabaseConnector_5.0.4.tar.gz', repos = NULL, type = 'source');
install.packages('/home/rstudio/pkgs/ParallelLogger_2.0.2.tar.gz', repos = NULL, type = 'source');
install.packages('/home/rstudio/pkgs/FeatureExtraction_3.1.1.tar.gz', repos = NULL, type = 'source');
install.packages('/home/rstudio/pkgs/Cyclops_3.1.2.tar.gz', repos = NULL, type = 'source');
install.packages('/home/rstudio/pkgs/EmpiricalCalibration_2.1.0.tar.gz', repos = NULL, type = 'source');
install.packages('/home/rstudio/pkgs/MethodEvaluation_2.1.0.tar.gz', repos = NULL, type = 'source');
install.packages('/home/rstudio/pkgs/OhdsiRTools_2.0.0.tar.gz', repos = NULL, type = 'source');
install.packages('/home/rstudio/pkgs/OhdsiSharing_0.2.2.tar.gz', repos = NULL, type = 'source');
install.packages('/home/rstudio/pkgs/ROhdsiWebApi_1.3.1.tar.gz', repos = NULL, type = 'source');
install.packages('/home/rstudio/pkgs/CohortMethod_4.2.0.tar.gz', repos = NULL, type = 'source');
install.packages('/home/rstudio/pkgs/CohortDiagnostics_2.0.0.tar.gz', repos = NULL, type = 'source');
install.packages('/home/rstudio/pkgs/PatientLevelPrediction_5.0.5.tar.gz', repos = NULL, type = 'source');


# 4) install JDBC driver
DatabaseConnector::downloadJdbcDrivers(dbms = 'oracle',pathToDriver = '/home/rstudio/jdbc');

# 5) conda environment settings
reticulate::install_miniconda();
PatientLevelPrediction::configurePython(envname='r-reticulate', envtype = 'conda');
devtools::install_github('rstudio/keras');
keras::install_keras(method = 'conda');
reticulate::conda_install(envname='r-reticulate', packages = c('scikit-survival'), forge = TRUE, pip = TRUE);
reticulate::conda_install(envname='r-reticulate', packages = c('pytorch', 'torchvision', 'cpuonly'), forge = TRUE, pip = FALSE, channel = 'pytorch', pip_ignore_installed = TRUE, conda = 'auto')
