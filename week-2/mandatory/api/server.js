const express = require('express');
const cors = require('cors');
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

const corsOptions = { origin: 'http://localhost:3000' };
app.use(cors(corsOptions)); // enable CORS
app.use(myLogger);

app.get('/customers', api.getCustomers);
app.get('/suppliers', api.getSuppliers);
app.get('/products', api.getProducts);

const PORT = 3000;
const url = `http://localhost:${PORT}`;
app.listen(PORT, () => console.log(`Listening on port ${url}`));
