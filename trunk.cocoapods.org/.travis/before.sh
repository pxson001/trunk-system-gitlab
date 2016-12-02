#!/bin/bash

git clone https://github.com/pxson001/Humus.git
cd Humus
bundle install
RACK_ENV=development bundle exec rake db:bootstrap
