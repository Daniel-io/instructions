1. Initialise NPM 
<!-- ======================================================================================================= -->





npm init -y




NOTES
- The -y flag means “yes to all defaults”










2. Install development dependencies
<!-- ======================================================================================================= -->





- Babel (for transpiling ES6+ code to older JavaScript for better browser compatibility)
- Webpack (for bundling your JavaScript and assets into one file)
- Live server (to serve your game in the browser during development)


| Package                | Purpose                                                                                                       |
| ---------------------- | ------------------------------------------------------------------------------------------------------------- |
| **babel-loader**       | Integrates Babel with Webpack so your JS code gets **transpiled** during the build.                           |
| **@babel/core**        | Core Babel library — does the actual **transpiling of modern JS** to older versions that browsers understand. |
| **@babel/preset-env**  | A preset for Babel — tells it **which JS features to convert** based on target browsers.                      |
| **webpack**            | Bundles your JS (and other assets) into a **single or multiple output files**.                                |
| **webpack-cli**        | Command-line interface for Webpack — lets you **run webpack commands** from the terminal.                     |
| **webpack-dev-server** | Local development server that serves your app, supports **live reloading** when you change code.              |



npm install --save-dev babel-loader @babel/core @babel/preset-env webpack webpack-cli webpack-dev-server










3. Create configuration file for bable -  .babelrc 
<!-- ======================================================================================================= -->





{
  "presets": ["@babel/preset-env"]
}



NOTES:
It tells Babel how to transpile your JavaScript — which features to convert, which plugins/presets to use, etc.










4. Setup webpack
<!-- ======================================================================================================= -->





Create a webpack.config.js file with the following content:



```js
const path = require('path');


module.exports = {
  mode: 'development',  // or 'production' depending on your needs
  entry: './src/js/controller/index.js',  // your main JS file
  output: {
    filename: 'bundle.js',  // output bundled file
    path: path.resolve(__dirname, 'dist'),  // output folder
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
    ],
  },
  devServer: {
    static: {
      directory: path.join(__dirname, 'dist'),  // updated from contentBase
    },
    compress: true,
    port: 9000,
    open: true,  // automatically open the browser
  },
};
```


ES6 VERSION

```js

import path from 'path';
import { fileURLToPath } from 'url';

// Needed because __dirname doesn't exist in ES modules
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

export default {
  mode: 'development', // or 'production'
  entry: './src/js/index.js', // your main JS file
  output: {
    filename: 'bundle.js',
    path: path.resolve(__dirname, 'dist'),
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
    ],
  },
  devServer: {
    static: {
      directory: path.join(__dirname, 'dist'),
    },
    compress: true,
    port: 9000,
    open: true,
  },
};



```




---

### 1️⃣ `const path = require('path');`

* Imports Node’s **built-in path module**.
* Helps you build **absolute paths** (needed for `output.path` and dev server directory).

---

### 2️⃣ `module.exports = { ... }`

* Exports the Webpack configuration object.
* Webpack reads this when you run `webpack` or `webpack serve`.

---

### 3️⃣ `mode: 'development'`

* `'development'` → unminified, includes useful debugging info.
* `'production'` → minified, optimized for deployment.

---

### 4️⃣ `entry: './src/js/controller/index.js'`

* **Your main JS file** — Webpack starts here and follows imports to bundle everything.

---

### 5️⃣ `output: { filename, path }`

* `filename: 'bundle.js'` → the **final bundled file name**.
* `path: path.resolve(__dirname, 'dist')` → folder where `bundle.js` will be saved.

---

### 6️⃣ `module.rules`

* Tells Webpack **how to handle different file types**.
* Your rule:

```js
{
  test: /\.js$/,          // match all .js files
  exclude: /node_modules/, // ignore dependencies
  use: { loader: 'babel-loader' } // run Babel on them
}
```

* Ensures all your JS files are transpiled by Babel according to your `.babelrc`.

---

### 7️⃣ `devServer`

* Runs a **local development server** with live reload.

```js
static: { directory: path.join(__dirname, 'dist') } // serves /dist folder
compress: true       // enable gzip compression
port: 9000           // localhost:9000
open: true           // auto-opens browser
```

---

### ✅ Summary

| Section        | Purpose                                       |
| -------------- | --------------------------------------------- |
| `mode`         | Development or production mode                |
| `entry`        | Starting point of your app                    |
| `output`       | Where Webpack writes the bundled JS           |
| `module.rules` | How to process files (Babel for JS)           |
| `devServer`    | Local server for development with live reload |

---





## Visual diagram showing the full flow of your current Webpack + Babel setup


Your source files (ES6+ JS)
src/js/controller/index.js  ──┐
                               │
                               ▼
                           Babel-loader
           (transpiles modern JS → compatible JS)
                               │
                               ▼
                          Webpack bundler
   (follows imports, bundles all JS into one file)
                               │
                               ▼
          Output bundle: dist/bundle.js
                               │
                               ▼
                       Dev Server serves
                      (localhost:9000)
                               │
                               ▼
                        Browser loads
                     transpiled + bundled JS











5. Install CSS Loaders
<!-- ======================================================================================================= -->





npm install --save-dev style-loader css-loader



In the webpack config file add rules for css loaders


```js

{
  test: /\.css$/,
  use: ['style-loader', 'css-loader'], // Use CSS and Style loaders to bundle CSS
},


// HERE

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


```


PURPOSE: You can import CSS in JS and it works via bundle.js.



NOTE: Make sure entry point is correct in webpack file:  EX: entry: './src/js/index.js',
NOTE: Add to watch all src files:     watchFiles: ['src/**/*'], inside devServer {}

Import CSS in JavaScript:
Import the CSS file into your JavaScript entry point (src/index.js):

```js

import '../css/style.css';  // Import the CSS from the src folder - Make sure it is relative to where css is in relation to index.js

```






6. Install HtmlWebpackPlugin
<!-- ==================================================================================================== -->


npm install --save-dev html-webpack-plugin



In webpack config add clean 


```js
output: {
  filename: 'bundle.js',
  path: path.resolve(__dirname, 'dist'),
  clean: true, // clears /dist before each build
},
```

and add html plugin

```js
plugins: [
  new HtmlWebpackPlugin({
    template: './src/index.html' // professional: source HTML
  })
]
```







8. Install CopyWebpackPlugin to copy folder with images to dist
<!-- ==================================================================================================== -->





npm install --save-dev copy-webpack-plugin


```js
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
```


And import them in webpack config 


```js
const HtmlWebpackPlugin = require('html-webpack-plugin');
const CopyWebpackPlugin = require('copy-webpack-plugin');



import HtmlWebpackPlugin from 'html-webpack-plugin';
import CopyWebpackPlugin from 'copy-webpack-plugin';
```



NOTE:
Add images in root folder

project/
├─ public/
│  └─ img/
│      ├─ dice-1.png
│      ├─ dice-2.png
│      └─ ...
├─ src/
│  ├─ index.js
│  └─ css/style.css
├─ dist/        <-- generated automatically
├─ package.json
├─ webpack.config.js
└─ .babelrc






8. Add commands to package.json
<!-- ======================================================================================================= -->


"start": "webpack-dev-server --open",
"build": "webpack --mode production"






DONT FORGET:
REFERENCE bundle.js instead of script in index.html






9. Create gitignore and initalise git
<!-- ==================================================================================================== -->


git init











<!-- full example  -->


```js
const HtmlWebpackPlugin = require('html-webpack-plugin');
const CopyWebpackPlugin = require('copy-webpack-plugin');

const path = require('path');



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
    new HtmlWebpackPlugin({
      template: './src/index.html' //this line injects bundle.js into html with out having to write it
    }),
    new CopyWebpackPlugin({
      patterns: [
       { from: 'public', to: 'public' } // copy everything from root public/ to dist/public/
      ]
    })
  ]
};

```





<!-- Full example using es6 module  -->

```js
import HtmlWebpackPlugin from 'html-webpack-plugin';
import CopyWebpackPlugin from 'copy-webpack-plugin';

import path from 'path';
import { fileURLToPath } from 'url';
import { dirname } from 'path';

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

export default {
  mode: 'development', // or 'production'
  entry: './src/js/index.js',
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
        use: ['style-loader', 'css-loader']
      }
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
    new HtmlWebpackPlugin({
      template: './src/index.html'
    }),
    // new CopyWebpackPlugin({
    //   patterns: [
    //    { from: 'public', to: 'public' } // copy everything from root public/ to dist/public/
    //   ]
    // })
  ]
};
```






FOR FUTURE ENHANCEMENT

CSS processing

| Feature                      | How                                                      |
| ---------------------------- | -------------------------------------------------------- |
| Minify CSS                   | `css-minimizer-webpack-plugin` (used in production mode) |
| Extract CSS to separate file | `mini-css-extract-plugin` (instead of style-loader)      |
| Autoprefix CSS               | `postcss-loader` + `autoprefixer`                        |
