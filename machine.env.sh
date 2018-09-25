#!/usr/bin/env bash

## Source this script (. ./machine.env.sh) to configure Docker for access to
## this machine.

eval $(docker-machine env grapevine)
