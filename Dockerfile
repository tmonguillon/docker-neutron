FROM ubuntu:xenial
MAINTAINER thomas.monguillon "thomas.monguillon@orange.com"

RUN apt-get -q update \
    && apt-get install -qy --no-install-recommends \
                            software-properties-common \
                            vim \
    && add-apt-repository -y cloud-archive:pike \
    && apt-get -q update \
    && apt-get install -qy --no-install-recommends \
                            neutron-server \
                            neutron-openvswitch-agent \
                            python-neutronclient \
                            python-openstackclient \
                            python-setuptools \
                            mysql-client \
                            openvswitch-switch \
                            supervisor \
    && easy_install pip \
    && pip install networking-sfc

WORKDIR /opt
COPY neutron.sql /opt/neutron.sql
COPY neutron.conf /etc/neutron/neutron.conf
COPY ml2_conf.ini /etc/neutron/plugins/ml2/ml2_conf.ini
COPY supervisord.conf /etc/supervisord.conf
COPY bootstrap.sh /etc/bootstrap.sh
RUN chown root:root /etc/bootstrap.sh && chmod a+x /etc/bootstrap.sh

EXPOSE 9696/tcp

ENTRYPOINT ["/etc/bootstrap.sh"]
#CMD []
