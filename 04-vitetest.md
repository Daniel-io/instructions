1. Install vite
<!-- ======================================================================================================= -->




npm install -D vitest



2. Add script in package.json
<!-- ======================================================================================================= -->


```json
{
  "scripts": {
    "test": "vitest"
  }
}
```



2. Create test file
<!-- ======================================================================================================= -->



tests/
└── sanity.test.js


```js
import { describe, it, expect } from "vitest";

describe("sanity check", () => {
    expect(1 + 1).toBe(2);
  it("should pass", () => {
  });
});
```





4. Create dom config file in root
<!-- ======================================================================================================= -->


Install 
npm install -D jsdom

```js
// vitest.config.js
import { defineConfig } from "vitest/config";

export default defineConfig({
  test: {
    environment: "jsdom",
  },
});
```