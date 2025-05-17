FROM rocker/tidyverse:latest

RUN apt-get update && apt-get install -y \
    sudo \
    gdebi-core \
    pandoc \
    pandoc-citeproc \
    libcurl4-gnutls-dev \
    libcairo2-dev \
    libxt-dev \
    libssl-dev \
    libssh2-1-dev \
    libpq-dev \
    && R -e "install.packages(c('shiny', 'xgboost', 'data.table', 'caret', 'h2o'), repos='https://cloud.r-project.org')"

RUN R -e "install.packages('h2o', repos = 'https://h2o-release.s3.amazonaws.com/h2o/latest_stable/R')"

EXPOSE 3838
CMD ["R", "-e", "shiny::runApp('/home/rstudio/app/predict_shiny.R', host='0.0.0.0', port=3838)"]