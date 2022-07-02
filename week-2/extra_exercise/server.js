const express = require('express');
const app = express();
const api = require('./api');

const myLogger = (req, res, next) => {
  const log = {
    date: new Date(),
    url: req.url
  };
  console.log(JSON.stringify(log, null, 2));
  next();
};

app.use(myLogger);

app.get('/customers', api.getCustomers);
app.get('/restaurants', api.getRestaurants);
app.get('/nearest/', api.getNearest);

const PORT = 3000;
const url = `http://localhost:${PORT}`;
app.listen(PORT, () => console.log(`Listening on port ${url}`));
