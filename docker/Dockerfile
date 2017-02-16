FROM            amazonlinux:2016.09
MAINTAINER      KOTAIMEN <kotaimen.c@gmail.com>

RUN             set -ex \
                && yum install -y \
                    python27-pip \
                    python27-devel \
                    python27-virtualenv \
                    bzip2 \
                    findutils \
                    gcc \
                    gcc-c++ \
                    swig

ENV             WORKDIR=/lambda
ENV             PREFIX=${WORKDIR}/venv

VOLUME          ${WORKDIR}
WORKDIR         ${WORKDIR}

