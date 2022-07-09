const express = require('express');
const cors = require('cors');
const app = express();
const api = require('./api');
const bodyParser = require('body-parser');

const myLogger = (req, res, next) => {
  const log = {
    date: new Date(),
    url: req.url
  };
  console.log(JSON.stringify(log, null, 2));
  next();
};

app.use(bodyParser.json());
app.use(myLogger);

app.get('/customers', api.getCustomers);
app.get('/customers/:customerId', api.getCustomersById);
app.get('/customers/:customerId/orders', api.getCustomersOrders);
app.get('/suppliers', api.getSuppliers);
app.get('/products', api.getProducts);
app.put('/customers/:customerId', api.putCustomers);
app.post('/customers', api.postCustomers);
app.post('/products', api.postProducts);
app.post('/customers/:customerId/orders', api.postOrder);
app.delete('/orders/:orderId', api.deleteOrders);
app.delete('/customers/:customerId', api.deleteCustomers);

const PORT = 3000;
const url = `http://localhost:${PORT}`;
app.listen(PORT, () => console.log(`Listening on port ${url}`));
