#!/bin/bash

set -e

bundle exec rake db:migrate
rspec spec
bundle exec rake cucumber 
