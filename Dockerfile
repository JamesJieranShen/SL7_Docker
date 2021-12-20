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
COPY entrypoint.sh /entry
COPY bashrc /entry/bashrc
COPY dircolors.ansi-dark /entry/discolors
COPY jierans.keytab /entry
ENTRYPOINT ["/entry/entrypoint.sh"]
# CMD "/entry/entrypoint.sh"
# CMD "/bin/bash"
