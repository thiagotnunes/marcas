#!/bin/bash

set -e

bundle exec rake db:migrate:test
bundle exec rake spec
bundle exec rake cucumber 
