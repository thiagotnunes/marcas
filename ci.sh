#!/bin/bash

set -e

bundle exec rake spec
bundle exec rake cucumber 
