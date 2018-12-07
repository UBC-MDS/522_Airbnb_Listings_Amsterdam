# Docker file for Airbnb_Listings_Amesterdam
#Jielin Yu (Dec 06, 2018)

# Description: This Makefile can be run to create our automatic
#							 data analysis pipeline.

#Usage:
# To build the docker image: docker build --tag final_report:0.1 .

# To create the report: docker run --rm -e PASSWORD=test -v <YOUR-PATH-TO-PROJECT-DIRECTORY>:/home/rstudio/final_report final_report:0.1 make -C '/home/rstudio/final_report' all
# To clean the report: docker run --rm -e PASSWORD=test -v <YOUR-PATH-TO-PROJECT-DIRECTORY>:/home/rstudio/final_report final_report:0.1 make -C '/home/rstudio/final_report' clean

#Use rocker/tidyverse as the base image
FROM rocker/tidyverse

#Install R package
RUN Rscript -e "install.packages('here')"
RUN Rscript -e "install.packages('gridExtra')"

#Install python 3
RUN apt-get update \
  && apt-get install -y python3-pip python3-dev \
  && cd /usr/local/bin \
  && ln -s /usr/bin/python3 python \
  && pip3 install --upgrade pip

#Get python package dependencies
RUN apt-get install -y python3-tk

#Install python packages
RUN pip3 install numpy
RUN pip3 install pandas
RUN pip3 install scikit-learn
RUN pip3 install seaborn
RUN apt-get install -y graphviz && pip install graphviz
RUN apt-get update && \
    pip3 install matplotlib && \
    rm -rf /var/lib/apt/lists/*

# get OS updates and install build tools RUN apt-get update
RUN apt-get install -y build-essential

# install graphviz RUN apt-get install -y graphviz
# install git RUN apt-get install -y wget

RUN apt-get install -y make git

# clone, build makefile2graph,
# then copy key makefile2graph files to usr/bin so they will be in $PATH

RUN git clone https://github.com/lindenb/makefile2graph.git
RUN make -C makefile2graph/.
RUN cp makefile2graph/makefile2graph usr/bin
RUN cp makefile2graph/make2graph usr/bin
