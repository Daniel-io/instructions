#!/bin/bash

# INSTRUCTIONS
# chmod +x folder-setup.sh
# ./folder-setup.sh

# Create project directories
mkdir -p \
  server/services \
  src/app/css \
  src/app/js/api \
  src/app/js/config \
  src/app/js/test \
  public/images

# Create project files
touch \
  .env \
  .gitignore \
  src/app/js/index.js