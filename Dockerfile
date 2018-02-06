FROM ubuntu:xenial
MAINTAINER thomas.monguillon "thomas.monguillon@orange.com"
ARG NEUTRON_BRANCH=master
ENV NEUTRON_BRANCH $NEUTRON_BRANCH
WORKDIR /opt

RUN apt-get -q update
RUN apt-get install -qy --no-install-recommends \
                            neutron-server \
                            python-neutronclient \
                            python-keystoneclient 
CMD []
