#!/bin/bash

set -e

bundle exec rake db:migrate
bundle exec rspec spec
bundle exec rake cucumber 
