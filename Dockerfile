FROM dunedaq/sl7-minimal
RUN mkdir /work /entry
WORKDIR /work

ENV TERM=xterm-256color
ENV SHELL=/bin/bash

RUN yum install -y https://repo.opensciencegrid.org/osg/3.6/osg-3.6-el7-release-latest.rpm
RUN yum install -y --setopt=tsflags=nodocs \
    wget \
    gcc     \ 
    gcc-c++ \
    make \
 && yum -y clean all
#Libraries
RUN yum install -y --setopt=tsflags=nodocs \
    uuid-c++-devel \
    libuuid-devel \
 && yum -y clean all
RUN yum install -y epel-release
RUN yum install -y edhat-lsb-core gcc-gfortran pcre-devel \
mesa-libGL-devel mesa-libGLU-devel glew-devel ftgl-devel mysql-devel \
fftw-devel cfitsio-devel graphviz-devel libuuid-devel \
avahi-compat-libdns_sd-devel openldap-devel python-devel numpy \
libxml2-devel gsl-devel readline-devel R-devel R-Rcpp-devel R-RInside-devel

RUN yum install -y osg-wn-client voms-clients cigetcert krb5-libs \
    krb5-workstation htop sudo pip vim tmux
# We log in as a sudo user instead of ROOT to prevent 
# file write problems in a shared directory.
RUN useradd -m -s /bin/bash -u 1000 james
RUN usermod -aG james james
RUN usermod -aG wheel james
RUN passwd -d james


COPY kx509 /usr/bin/kx509
COPY krb5.conf /etc/krb5.conf
# COPY init.sh /usr/bin/setup_lar
COPY dircolors.ansi-dark /entry/dircolors
COPY jierans.keytab /entry
RUN chown 1000:1000 /entry/jierans.keytab
RUN chmod 700 /entry/jierans.keytab

USER james
ENTRYPOINT "/bin/bash"
