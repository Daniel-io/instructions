1. Create jsconfig.json so jsdocs signals errors 
<!-- =================================================================================-->


```json
{
  "compilerOptions": {
    "checkJs": true
  },
  "include": ["./src/**/*", "src/server.js"]
}
```



2. Types
<!-- =================================================================================-->

```js
/** @type {{ ERROR: 'error', WARN: 'warn', INFO: 'info', LOG: 'log', TRACE: 'trace', DEBUG: 'debug' }} */
export const LOG_LEVELS = {
  ERROR: 'error',
  WARN: 'warn',
  INFO: 'info',
  LOG: 'log',
  TRACE: 'trace',
  DEBUG: 'debug',
};

```
— is not saying the values are just strings.
It’s saying that each property can only be a specific literal string.


3. TYPEDEF 
<!-- =================================================================================-->

```js
/** 
 * @typedef {Object} Logger
 * @property {(...args: any[]) => void} error - Log an message, Internally uses 'LOG_LEVEL.ERROR'
 * @property {(...args: any[]) => void} warn  - Log warn message, Internally uses 'LOG_LEVEL.WARN'
 * @property {(...args: any[]) => void} info  - Log warn message, Internally uses 'LOG_LEVEL.INFO'
 * @property {(...args: any[]) => void} log   - Log warn message, Internally uses 'LOG_LEVEL.LOG'
 * @property {(...args: any[]) => void} trace - Log warn message, Internally uses 'LOG_LEVEL.TRACE'
 * @property {(...args: any[]) => void} debug - Log warn message, Internally uses 'LOG_LEVEL.DEBUG'
 * 
 */


export const loggerType = /** @type {Logger} */ ({});
```

@property {<TYPE>} <NAME> - <DESCRIPTION>


| Type                               | Meaning                             |
| ---------------------------------- | ----------------------------------- |
| `() => void`                       | No arguments, returns nothing       |
| `(message: string) => void`        | One string argument                 |
| `(...args: any[]) => void`         | Any number of arguments of any type |
| `(a: number, b: number) => number` | Two numbers, returns a number       |


| Example Type                           | Meaning                                                     |
| -------------------------------------- | ----------------------------------------------------------- |
| `{() => string}`                       | Function that returns a string                              |
| `{(a: number, b: number) => number}`   | Function that returns a number                              |
| `{(...args: any[]) => boolean}`        | Function that returns a boolean                             |
| `{(message: string) => Promise<void>}` | Async function returning a Promise that resolves to nothing |






3. Functions
<!-- =================================================================================-->


```js
/**
 * This is a function.
 *
 * @param {string} n - A string param
 * @param {string} [o] - A optional string param
 * @param {string} [d=DefaultValue] - A optional string param
 * @return {string} A good string
 *
 * @example
 *
 *     foo('hello')
 */

function foo(n, o, d) {
  return n
}
```