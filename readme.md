# ManoDienynas API
An API that scrapes Manodienynas and gives result in JSON.
## 1st step
Type `npm i` to install all modules.
## Running
Type `npm run start` to run the API.
## Compiling to JS
You may want to view the code in JS. Type `npm run compile` to compile CoffeeScript.
## API tutorial
*TODO FULL*

### Getting holiday dates
To get holiday dates, make **POST** request to `/api/holidays` endpoint.

JSON body for the request:

```json
{
    "username": "",
    "password": ""
}
```