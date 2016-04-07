#!/bin/bash -eux

set -e

export DEBIAN_FRONTEND=noninteractive

##
## Install some apps
##
echo "==> Installing Ubuntu packages."
apt-get install --assume-yes \
    curl \
    git \
    libssl-dev \
    libffi-dev \
    mariadb-client-5.5 \
    mariadb-server-5.5 \
    libmariadbclient-dev \
    python-dev \
    unzip \
    vim

# Install current pip
echo "==> Installing current pip."
apt-get remove --assume-yes python-requests python-pip
wget https://bootstrap.pypa.io/get-pip.py -O - | python

# Need for ssl and urllib3
pip install pyopenssl ndg-httpsclient pyasn1 requests virtualenv virtualenvwrapper

