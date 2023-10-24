#!/usr/bin/env bash

echo "Running pre-push hook"
./scripts/brakeman.bash
./scripts/rspec.bash

# $? stores exit value of the last command
if [ $? -ne 0 ]; then
 echo "Brakeman and Tests must pass before pushing!"
 exit 1
fi
