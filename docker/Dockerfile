FROM ubuntu:18.04

ENV LD_LIBRARY_PATH /usr/local/lib

RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get -y install wget \
  cmake \
  build-essential \
  libbz2-dev \
  libssl-dev \
  git \
  ruby \
  ruby-dev \
  nodejs \
  python \
  libpq-dev

RUN gem install bundler

WORKDIR /tmp/compile-dir

COPY dependencies/boost.sh boost.sh
RUN bash /tmp/compile-dir/boost.sh

COPY dependencies/cppnetlib.sh cppnetlib.sh
RUN bash /tmp/compile-dir/cppnetlib.sh

# crails-front dependency
COPY dependencies/cheerp.sh cheerp.sh
RUN bash /tmp/compile-dir/cheerp.sh

# crails-cache dependency
RUN apt-get -y install libmemcached-dev

# crails-odb dependency
COPY dependencies/odb.sh odb.sh
RUN bash /tmp/compile-dir/odb.sh

# crails
COPY dependencies/crails.sh crails.sh
RUN bash /tmp/compile-dir/crails.sh

# setup
ENV CRAILS_SHARED_DIR /usr/local/share/crails

COPY scripts/package.sh /usr/local/bin/package.sh
RUN chmod +x /usr/local/bin/package.sh

RUN mkdir -p /opt/webapp
WORKDIR /opt/webapp
