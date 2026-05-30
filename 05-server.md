1. Create server folder and server.js file
<!-- ================================================================================================ -->




<!-- Example -->

├── /src/                 ← all your frontend source code
│   ├── /js/
│   ├── /css/
│   ├── /img/
│   ├── index.html
│   └── main.js
│
└── /server/                  ← backend (Node / Express)
    ├── server.js         ← main server file (entry point)
    ├── /services/        ← reusable backend modules (API logic, DB, etc.)
    │   ├── gameService.js
    │   └── userService.js










2. Install express 
<!-- ================================================================================================ -->





npm install express



NOTE: Install npm install express dotenv if not installed yet
NOTE: When "type": "module" is set, Node treats all your .js files as ES modules (ESM) instead of CommonJS.
That means Node follows the official ECMAScript module spec, which requires explicit file extensions — Node will not automatically add .js, .json, or .mjs like it does in CommonJS.

EX: Must include extension .js
import { createLogger } from './js/utils/logger/index.js';






3. Create Port variable in .env and write server script in package.json
<!-- ================================================================================================ -->

<!-- .env  -->
ENV=development
API_URL=http://localhost:3000 
PORT=3000



<!-- pacakge.json -->
"start-server": "node server/server.js"






4. Create basic server file
<!-- ================================================================================================ -->



```js
import express from "express"
import dotenv from "dotenv"



// Activates dotenv makes .env variables available here
dotenv.config();




// Creates your Express app instance
const app = express();
// This line enables JSON body parsing for incoming requests.
app.use(express.json());



const PORT = process.env.PORT || 3000



// Sanity check
app.get("/", (req, res) => res.send("Server running!"));

app.listen(PORT, () => console.log(`Server running on port ${PORT}`));
```







4. FIXING CORS ERROR
<!-- ================================================================================================ -->


Reason for error: Your browser blocks requests between different origins by default

Browsers have a built-in security feature called CORS (Cross-Origin Resource Sharing).
It stops scripts from one site (your frontend) from talking to another site (your backend) unless the backend explicitly allows it.


When posting need to install cors package 


```js
npm install cors
import cors from "cors";

app.use(cors({ origin: "http://localhost:9000" }));
```
