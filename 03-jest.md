1. Install Jest
<!-- ======================================================================================================= -->



npm install --save-dev jest










2. Install type/jest when writing Typescript test
<!-- ======================================================================================================= -->



npm i --save-dev @types/jest







3. Add test command to script in package.json
<!-- ======================================================================================================= -->





```json
{
  "scripts": {
    "test": "jest"
  }
}
```







Typical structure:

```
/src
  /js
    /controller
    /view
    /utils
      logger.js
      loggerTypes.js
      loggerConstants.js
  /tests
    logger.test.js
```






4. Install fro testing none node JS - DOM
<!-- ======================================================================================================= -->



npm install --save-dev jest-environment-jsdom


and create jest.config.js 




```js

// if your package.json does NOT have "type": "module"

module.exports = {
  testEnvironment: "jsdom"
};



// If your package.json does have "type": "module"


export default {
  testEnvironment: "jsdom"
};

```



NOTE: IF USING type:module rename webpack config to "webpack.config.cjs" or re-write using modenr es6 js





<!-- EXAMPLE TEST  -->



```js

describe('Sanity test', () => {


  test('Sanity test: 1 + 2 = 3', () => {
    const sum = (a, b) => a + b;
    expect(sum(1, 2)).toBe(3);
  })

})





// jsdom gives us a fake browser DOM
describe('basic DOM test', () => {
  test('changes text content of an element', () => {
    // Setup: create a fake DOM element
    document.body.innerHTML = `<p id="greeting">Hello</p>`;

    // Action: modify the DOM
    const p = document.getElementById('greeting');
    p.textContent = 'Hi there!';

    // Assert: verify change
    expect(p.textContent).toBe('Hi there!');
  });
});


```