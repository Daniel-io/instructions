1. Create .env file in project root 
<!-- ======================================================================================================= -->





ENV=development
API_URL=https://api.example.com



NOTES:
ENV - can be used in front end to optionally show logs depending on it is either prod or dev enviorment
API_URL - the api the front calls to access my backend









2. Install dotenv and webpack DefinePlugin
<!-- ======================================================================================================= -->





npm install dotenv --save-dev



NOTES:
- dotenv reads your .env file and makes the environment variables available in Node.
- DefinePlugin is built into Webpack, so you don’t need to install it separately.




You just import it in your webpack.config.js like this:

```js
const webpack = require('webpack');
```

* Import dotenv package into webpack config

```js
const dotenv = require('dotenv');
```

ES5

```js

import webpack from 'webpack';
import dotenv from 'dotenv';

```



* dotenv.config() actually reads your .env file and parses it into an object you can use.


```js
const env = dotenv.config().parsed || {};
```


* Format variables for DefinePlugin


```js
const envKeys = Object.keys(env).reduce((prev, next) => {
  prev[`process.env.${next}`] = JSON.stringify(env[next]);
  return prev;
}, {});
```



* Add in plugins



```js
new webpack.DefinePlugin(envKeys), // 🔥 Add this line to inject env variables
```








3. Test in front end
<!-- ======================================================================================================= -->



```js
console.log(process.env.ENV); // "development"
```









4. Create a config file (cleaner option)
To avoid scattering process.env all over your code, you can centralize access to environment variables in a config file:
<!-- ======================================================================================================= -->



🔹 src/global/config.js

```js
export const ENV = process.env.ENV;
export const API_URL = process.env.API_URL;



// IMPORT WHERE NEEDED
import { ENV, API_URL } from './config.js';
```







<!-- FINAL EXAMPLE -->





```js

const HtmlWebpackPlugin = require('html-webpack-plugin');
const CopyWebpackPlugin = require('copy-webpack-plugin');

const path = require('path');
const webpack = require('webpack');
const dotenv = require('dotenv');




const env = dotenv.config().parsed || {};

// Format variables for DefinePlugin
const envKeys = Object.keys(env).reduce((prev, next) => {
  prev[`process.env.${next}`] = JSON.stringify(env[next]);
  return prev;
}, {});




module.exports = {
  mode: 'development',  // or 'production' depending on your needs
  entry: './src/js/index.js',  // your main JS file
  output: {
    filename: 'bundle.js',  // output bundled file
    path: path.resolve(__dirname, 'dist'),  // output folder
    clean: true,
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
        use: ['style-loader', 'css-loader'], // Use CSS and Style loaders to bundle CSS
      },
    ],
  },
  devServer: {
    static: {
      directory: path.join(__dirname, 'dist'),  // updated from contentBase
    },
    compress: true,
    port: 9000,
    open: true,  // automatically open the browser
    watchFiles: ['src/**/*'], // <-- Add this line
  },
  plugins: [
    new webpack.DefinePlugin(envKeys), // 🔥 Add this line to inject env variables
    new HtmlWebpackPlugin({
      template: './src/index.html'
    }),
    new CopyWebpackPlugin({
      patterns: [
       { from: 'public', to: 'public' } // copy everything from root public/ to dist/public/
      ]
    })
  ]
};

```



<!-- ES6 -->
```js

import HtmlWebpackPlugin from 'html-webpack-plugin';
import CopyWebpackPlugin from 'copy-webpack-plugin';

import path from 'path';
import { fileURLToPath } from 'url';

import webpack from 'webpack';
import dotenv from 'dotenv';

// Needed because __dirname doesn't exist in ES modules
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

// Reads your .env file and parses it into an object you can use
const env = dotenv.config().parsed || {};

// Format variables for DefinePlugin
const envKeys = Object.keys(env).reduce((prev, next) => {
  prev[`process.env.${next}`] = JSON.stringify(env[next]);
  return prev;
}, {});

export default {
  mode: 'development', // or 'production'
  entry: './src/js/index.js', //change for actual entry
  output: {
    filename: 'bundle.js',
    path: path.resolve(__dirname, 'dist'),
    clean: true, 
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
        use: ['style-loader', 'css-loader'], // Use CSS and Style loaders to bundle CSS
      },
    ],
  },
  devServer: {
    static: {
      directory: path.join(__dirname, 'dist'),
    },
    compress: true,
    port: 9000,
    open: true,
    watchFiles: ['src/**/*'],
  },
  plugins: [
    new webpack.DefinePlugin(envKeys),
    new HtmlWebpackPlugin({
      template: './src/index.html' // professional: source HTML
    }),
    new CopyWebpackPlugin({
      patterns: [
        { from: 'public', to: 'public' } // copy everything from root public/ to dist/public/
      ]
    })
  ]
};

```