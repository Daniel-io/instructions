

<!-- Commands -->
npm init -y
npm install --save-dev babel-loader @babel/core @babel/preset-env webpack webpack-cli webpack-dev-server
npm install --save-dev style-loader css-loader
npm install --save-dev html-webpack-plugin
npm install --save-dev copy-webpack-plugin
npm install dotenv --save-dev



<!-- Create -->

create .babelrc file

```json
{
  "presets": ["@babel/preset-env"]
}
```



add commands in package.json

"start": "webpack-dev-server --open",
"build": "webpack --mode production"



