#!/bin/bash

set -e

bundle exec rake db:migrate
bundle exec rake spec
bundle exec rake cucumber 
