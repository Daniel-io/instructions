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
  vitest.config.js \
  src/app/index.html \
  src/app/js/index.js \
  src/app/css/style.css \
  src/app/js/test/sanity.test.js \
  server/server.js

# Create index.html content
cat > src/app/index.html <<'EOF'
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Arcade</title>
  </head>
  <body>
    <div id="app"></div>
    <canvas class="canvas" width="800" height="600"></canvas>
  </body>
</html>
EOF

# Create .env file content
cat > .env <<'EOF'
ENV=development
API_URL=https://api.example.com
PORT=3000
EOF

# Create style.css content
cat > src/app/css/style.css <<'EOF'
* {
  box-sizing: border-box;
  background-color: red 
}

body {
  font-family: sans-serif;
}
EOF




cat > webpack.config.js <<'EOF'
import path from 'path'
import { fileURLToPath } from 'url'

import HtmlWebpackPlugin from 'html-webpack-plugin'
import CopyWebpackPlugin from 'copy-webpack-plugin'

import webpack from 'webpack'
import dotenv from 'dotenv'

const env = dotenv.config().parsed || {}

const envKeys = Object.keys(env).reduce((prev, next) => {
  prev[`process.env.${next}`] = JSON.stringify(env[next])
  return prev
}, {})

// Needed because __dirname doesn't exist in ES modules
const __filename = fileURLToPath(import.meta.url)
const __dirname = path.dirname(__filename)

export default {
  mode: 'development',
  entry: './src/app/js/index.js',
  output: {
    filename: 'bundle.js',
    path: path.resolve(__dirname, 'dist'),
    clean: true
  },
  module: {
    rules: [
      {
        test: /\.js$/,
        exclude: /node_modules/,
        use: {
          loader: 'babel-loader',
        },
      },
      {
        test: /\.css$/,
        use: ['style-loader', 'css-loader'],
      },
    ],
  },
  devServer: {
    watchFiles: ['src/**/*'],
    static: {
      directory: path.join(__dirname, 'dist')
    },
    compress: true,
    port: 9000,
    open: true
  },
  plugins: [
    new webpack.DefinePlugin(envKeys),
    new HtmlWebpackPlugin({
      template: './src/app/index.html'
    }),
    new CopyWebpackPlugin({
      patterns: [
        { from: 'public', to: 'public' }
      ]
    })
  ]
}
EOF


cat > src/app/js/index.js << 'EOF'
import '../css/style.css'
console.log(process.env.ENV);
EOF


cat > src/app/js/test/sanity.test.js <<'EOF'
import { describe, it, expect } from "vitest";

describe("sanity check", () => {
  it("should pass", () => {
    expect(1 + 1).toBe(2);
  });
});
EOF


cat > vitest.config.js <<'EOF'
import { defineConfig } from "vitest/config";

export default defineConfig({
  test: {
    environment: "jsdom"
  }
});
EOF


cat > .gitignore <<'EOF'
# Node dependencies
node_modules/

# Build output
dist/
build/
coverage/
scratch/

# Ignore real env files
.env
.env.*

# But keep example template
!.env.example

# Optional: log files
npm-debug.log*
yarn-debug.log*
yarn-error.log*
*.log
*.cache
*.local

# Optional: OS-specific junk
.DS_Store
Thumbs.db

# 🧠 Editor & IDE Files
.vscode/
.idea/
.history/
EOF


cat > server/server.js <<'EOF'
// Creates your Express app instance
import express from "express";

const app = express();

// This line enables JSON body parsing for incoming requests.
app.use(express.json());

const PORT = process.env.PORT || 3000;

// Sanity check
app.get("/", (req, res) => res.send("Server running!"));

app.listen(PORT, () => console.log(`Server running on port ${PORT}`));
EOF

echo "✅ Folder structure created successfully!"