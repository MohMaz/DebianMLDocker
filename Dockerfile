FROM debian:latest

MAINTAINER Mohammad Mazraeh

RUN apt-get update
RUN apt-get upgrade
# Install Network Packages
RUN apt-get -y install telnet
RUN apt-get -y install net-tools
RUN apt-get -y install apt-utils

RUN apt-get -y install build-essential
RUN apt-get -y install libc6 
RUN apt-get -y install gfortran
RUN apt-get -y install curl git wget automake
#RUN apt-get -y install gcc-core gtkdoc libtool pkg-config
RUN apt-get -y install libcairo2-dev
RUN apt-get -y install libblas-dev
RUN apt-get -y install liblapack-dev
RUN apt-get -y install liblapacke
RUN apt-get -y install libxml2 libxml2-dev
RUN apt-get -y install libigraph0 libigraph0-dev
RUN apt-get -y install python3.4 python3.4-dev
RUN wget https://bootstrap.pypa.io/get-pip.py
RUN python3.4 get-pip.py
RUN python3.4 -m pip install cython
RUN python3.4 -m pip install setuptools
RUN python3.4 -m pip install numpy
RUN python3.4 -m pip install pandas
RUN python3.4 -m pip install scipy
RUN python3.4 -m pip install scikit-learn
RUN python3.4 -m pip install statsmodels
RUN python3.4 -m pip install python-igraph
RUN python3.4 -m pip install pybrain
RUN python3.4 -m pip install cherrypy jinja2
### Adding SSH-Server
RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:screencast' | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]

