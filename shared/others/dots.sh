#!/usr/bin/env bash

# current directory
dir=$(dirname ${BASH_SOURCE[0]})

# environment
symlink $dir/.environment ~/.environment
