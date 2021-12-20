FROM dunedaq/sl7-minimal
RUN mkdir /work /entry
WORKDIR /work

ENV TERM=xterm-256color
ENV SHELL=/bin/bash

RUN yum install -y https://repo.opensciencegrid.org/osg/3.6/osg-3.6-el7-release-latest.rpm
RUN yum install -y osg-wn-client voms-clients cigetcert krb5-libs krb5-workstation htop
RUN yum install -y --setopt=tsflags=nodocs \
    wget \
    gcc     \ 
    gcc-c++ \
    make \
 && yum -y clean all

#Libraries
RUN yum install -y --setopt=tsflags=nodocs \
    boost-devel \
    python-devel \
    libzip-devel \
    libX11-devel \
    libXmu-devel \
    libXext-devel \
    libXt-devel \
    libXpm-devel \
    libXft-devel \
    freeglut-devel \
    uuid-c++-devel \
    libuuid-devel \
 && yum -y clean all
COPY kx509 /usr/bin/kx509
COPY krb5.conf /etc/krb5.conf
COPY init.sh /usr/bin/setup_lar
COPY dircolors.ansi-dark /entry/dircolors
COPY jierans.keytab /entry

RUN kinit -kt /entry/jierans.keytab jierans@FNAL.GOV
RUN kx509
RUN voms-proxy-init -rfc -noregen -voms dune:/dune/Role=Analysis -valid 24:00
ENTRYPOINT "/bin/bash"
