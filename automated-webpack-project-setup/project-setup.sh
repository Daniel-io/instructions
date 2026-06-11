#!/bin/bash

# INSTRUCTIONS
# chmod +x project-setup.sh
# ./project-setup.sh

# Initialize npm project
npm init -y

# Install development dependencies
npm install --save-dev \
  babel-loader \
  @babel/core \
  @babel/preset-env \
  webpack \
  webpack-cli \
  webpack-dev-server \
  style-loader \
  css-loader \
  html-webpack-plugin \
  copy-webpack-plugin \
  dotenv

# Create Babel configuration
cat > .babelrc << 'EOF'
{
  "presets": ["@babel/preset-env"]
}
EOF