FROM phusion/baseimage:0.9.22
MAINTAINER Maxime Baudette "baudette@kth.se"
# Based on Dockerfile from OM Webbook by Arunkumar Palanisamy "arunkumar.palanisamy@liu.se"

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

RUN apt-get update
# Install wget
RUN apt-get install -y wget

# Add OpenModelica stable build
RUN for deb in deb deb-src; do echo "$deb http://build.openmodelica.org/apt `lsb_release -cs` stable"; done | sudo tee /etc/apt/sources.list.d/openmodelica.list
RUN wget -q http://build.openmodelica.org/apt/openmodelica.asc -O- | sudo apt-key add -

# Update index (again)
RUN apt-get update

# Install OpenModelica
RUN apt-get install -y openmodelica

RUN apt-get install -y python-pip python-dev build-essential
RUN apt-get install -y git \
                       python-numpy

# Install OMPython
RUN python -m pip install -U https://github.com/OpenModelica/OMPython/archive/master.zip

# Add User
RUN useradd smartslab

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
