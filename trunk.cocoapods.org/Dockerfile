FROM ruby:2.1.3
MAINTAINER Son Pham <son.pham@jmango360.com>
 
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys B97B0AFCAA1A47F044F244A07FCC7D46ACCC4CF8
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" > /etc/apt/sources.list.d/pgdg.list
RUN apt-get update && apt-get -y -q install python-software-properties software-properties-common \
    && apt-get -y -q install postgresql-9.3 postgresql-client-9.3 postgresql-contrib-9.3 libpq-dev postgresql-server-dev-9.3
RUN apt-get install dnsutils -y
RUN apt-get -y install locales
RUN apt-get -y install cmake
RUN echo 'en_US.UTF-8 UTF-8'>>/etc/locale.gen
RUN locale-gen
ENV LANG en_US.UTF-8

# install things globally, for great justice
ENV GEM_HOME /usr/local/bundle
ENV PATH $GEM_HOME/bin:$PATH
RUN gem install bundler \
	&& bundle config --global path "$GEM_HOME" \
	&& bundle config --global bin "$GEM_HOME/bin"
RUN mkdir /usr/src/app
WORKDIR /usr/src/app

RUN echo nameserver 8.8.8.8 > /etc/resolv.conf
RUN echo nameserver 8.8.4.4 > /etc/resolv.conf
 
COPY . /usr/src/app
 
#!/bin/bash

RUN gem update bundler

RUN bundle install
RUN cd Humus 
RUN bundle install
RUN cd ..

EXPOSE 4567

