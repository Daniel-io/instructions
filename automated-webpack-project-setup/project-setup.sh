#!/bin/bash

set -e  # stop if anything fails

# INSTRUCTIONS
# chmod +x project-setup.sh
# ./project-setup.sh

echo "📦 Initializing npm project..."
npm init -y

echo "📥 Installing runtime dependencies..."
npm install express dotenv cors

echo "🛠 Installing dev dependencies..."
npm install -D \
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
  vitest \
  jsdom 
  

echo "⚙️ Creating Babel config..."
cat > .babelrc <<'EOF'
{
  "presets": ["@babel/preset-env"]
}
EOF

echo "📄 Configuring package.json..."

npm pkg set \
  type="module" \
  scripts.start="webpack-dev-server --open" \
  scripts.build="webpack --mode production" \
  scripts.test="vitest" \
  scripts.server="node server/server.js"

echo "✅ Project setup complete!"