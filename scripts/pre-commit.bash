#!/usr/bin/env bash

echo "Running pre-push hook"
./scripts/rubocop.bash

# $? stores exit value of the last command
if [ $? -ne 0 ]; then
 echo "Rubocop Linting and Rspec Tests must pass before pushing!"
 exit 1
fi
