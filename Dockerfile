FROM python:2.7-alpine
MAINTAINER thomas.monguillon "thomas.monguillon@orange.com"
ARG NEUTRON_BRANCH=master
ENV NEUTRON_BRANCH $NEUTRON_BRANCH
WORKDIR /opt
RUN apk add --no-cache \
    bash \
    wget \
    curl \
    libffi \
    libxslt \
    mariadb-client
# Install build-deps, pip install packages and clean deps (to keep image small)
RUN apk add --no-cache --virtual build-deps \
        git \
        gcc \
        linux-headers \
        libc-dev \
        python-dev \
        openssl-dev \
        libffi-dev \
        libxml2-dev \
        libxslt-dev \
        mariadb-dev \
    && pip install MySQL-python pymysql pymysql_sa \
    && git clone --branch $NEUTRON_BRANCH --depth=1 https://github.com/openstack/requirements \
    && git clone --branch $NEUTRON_BRANCH --depth=1 https://github.com/openstack/neutron \
    && git clone --branch $NEUTRON_BRANCH --depth=1 https://github.com/openstack/python-openstackclient \
#    && pip install /opt/neutron -c /opt/requirements/upper-constraints.txt -r /opt/neutron/requirements.txt -r /opt/requirements/requirements.txt \
#    && pip install /opt/python-openstackclient -r /opt/python-openstackclient/requirements.txt -r /opt/requirements/requirements.txt \
    && rm -rf /root/.cache \
#    && rm -rf /opt/* \
#    && rm -rf /var/cache/apk/* \
    && apk del build-deps
CMD []