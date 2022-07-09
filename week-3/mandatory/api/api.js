const database = require('./database');

//QUERIES
const getCustomers = (req, res) => {
  const customerNameQuery = req.query.name;
  let query = `SELECT * FROM customers ORDER BY name`;
  if (customerNameQuery) {
    query = `SELECT * FROM customers WHERE name LIKE '%${customerNameQuery}%' ORDER BY name`;
  }

  database.pool
    .query(query)
    .then((result) => res.json(result.rows))
    .catch((e) => console.error(e));
};

const getSuppliers = (req, res) => {
  database.pool.query('SELECT * FROM suppliers', (error, result) => {
    res.json(result.rows);
  });
};

//1.1 Already DONE, add a new GET endpoint /products to load all the product names along with their supplier names.
const getProducts = (req, res) => {
  const productNameQuery = req.query.name;
  let query = `
  SELECT product_name, supplier_name 
  FROM products AS p 
  INNER JOIN suppliers AS s ON s.id=supplier_id`;

  //1.2 Update the previous GET endpoint /products to filter the list of products by name using a query parameter, for example /products?name=Cup. This endpoint should still work even if you don't use the name query parameter!
  if (productNameQuery) {
    query = `SELECT * FROM products WHERE product_name LIKE '%${productNameQuery}%' ORDER BY product_name`;
  }

  database.pool
    .query(query)
    .then((result) => res.json(result.rows))
    .catch((e) => console.error(e));
};

//1.3 Add a new GET endpoint /customers/:customerId to load a single customer by ID.
const getCustomersById = (req, res) => {
  const customerId = req.params.customerId;

  database.pool
    .query('SELECT * FROM customers WHERE id=$1', [customerId])
    .then((result) => res.json(result.rows))
    .catch((e) => console.error(e));
};

//1.4 Add a new POST endpoint /customers to create a new customer.
const postCustomers = (req, res) => {
  const newCustomerName = req.body.name;
  const newCustomerAddress = req.body.address;
  const newCustomerCity = req.body.city;
  const newCustomerCountry = req.body.country;

  database.pool.query('SELECT * FROM customers WHERE address=$1 AND name=$2', [newCustomerAddress, newCustomerName]).then((result) => {
    if (result.rows.length > 0) {
      return res.status(400).send('An user with the same address already exists!');
    } else {
      const query = 'INSERT INTO customers (name, address, city, country) VALUES ($1, $2, $3, $4) RETURNING id';
      database.pool
        .query(query, [newCustomerName, newCustomerAddress, newCustomerCity, newCustomerCountry])
        .then((result) => res.status(201).json({ customerId: result.rows[0].id }))
        .catch((e) => console.error(e));
    }
  });
};

//1.5 Add a new POST endpoint /products to create a new product
//(with a product name, a price and a supplier id).
//Check that the price is a positive integer and that the supplier ID exists in the database,
//otherwise return an error.
const postProducts = (req, res) => {
  const newProductName = req.body.product_name;
  const newProductPrice = req.body.unit_price;
  const newProductSupplierId = req.body.supplier_id;
  const querySupplier = `SELECT * FROM suppliers AS s WHERE s.id=$1`;

  if (!Number.isInteger(newProductPrice) || newProductPrice <= 0) {
    return res.status(400).send('The price should be a positive integer.');
  }

  database.pool.query(querySupplier, [newProductSupplierId]).then((result) => {
    if (result.rows.length === 0) {
      return res.status(400).send('Suppliers doesn´t exists!');
    } else {
      const query = 'INSERT INTO products (product_name, unit_price, supplier_id) VALUES ($1, $2, $3) RETURNING id';
      database.pool
        .query(query, [newProductName, newProductPrice, newProductSupplierId])
        .then((result) => res.status(201).json({ productId: result.rows[0].id }))
        .catch((e) => console.error(e));
    }
  });
};

//1.6 Add a new POST endpoint /customers/:customerId/orders to create a new order
//(including an order date, and an order reference) for a customer.
//Check that the customerId corresponds to an existing customer or return an error.
const postOrder = (req, res) => {
  const newOrderDate = req.body.order_date;
  const newOrderReference = req.body.order_reference;
  const newOrderCustomerId = req.params.customerId;
  const queryCustomer = `SELECT * FROM customers AS c WHERE c.id=$1`;

  database.pool.query(queryCustomer, [newOrderCustomerId]).then((result) => {
    if (result.rows.length === 0) {
      return res.status(400).send('Customer doesn´t exists!');
    } else {
      const query = 'INSERT INTO orders (order_date, order_reference, customer_id) VALUES ($1, $2, $3) RETURNING id';
      database.pool
        .query(query, [newOrderDate, newOrderReference, newOrderCustomerId])
        .then((result) => res.status(201).json({ orderId: result.rows[0].id }))
        .catch((e) => console.error(e));
    }
  });
};

//1.7 Add a new PUT endpoint /customers/:customerId to update an existing customer (name, address, city and country).
const putCustomers = (req, res) => {
  const modifiedCustomerName = req.body.name;
  const modifiedCustomerAddress = req.body.address;
  const modifiedCustomerCity = req.body.city;
  const modifiedCustomerCountry = req.body.country;
  const modifiedCustomerId = req.params.customerId;
  const query = `UPDATE customers SET name=$1, address=$2, city=$3, country=$4 WHERE id=$5 RETURNING id`;

  database.pool
    .query(query, [modifiedCustomerName, modifiedCustomerAddress, modifiedCustomerCity, modifiedCustomerCountry, modifiedCustomerId])
    .then((result) => res.status(201).json({ customerId: result.rows[0].id }))
    .catch((e) => console.error(e));
};

//1.8 Add a new DELETE endpoint /orders/:orderId to delete an existing order along all the associated order items.
const deleteOrders = (req, res) => {
  const OrderId = req.params.orderId;
  const query = `SELECT * FROM orders AS o WHERE o.id=$1`;

  database.pool.query(query, [OrderId]).then((result) => {
    if (result.rows.length === 0) {
      return res.status(400).send('This order doesn´t exist!');
    } else {
      database.pool
        .query('DELETE FROM orders WHERE id=$1', [OrderId])
        .then(() => res.send(`Order ${OrderId} deleted!`))
        .catch((e) => console.error(e));
    }
  });
};

//1.9 Add a new DELETE endpoint /customers/:customerId to delete an existing customer only if this customer doesn't have orders.
const deleteCustomers = (req, res) => {
  const customerId = req.params.customerId;
  const query = `SELECT * FROM orders AS o WHERE o.customer_id=$1`;

  database.pool.query(query, [customerId]).then((result) => {
    if (result.rows.length > 0) {
      return res.status(400).send('This customer has orders!');
    } else {
      database.pool
        .query('DELETE FROM customers WHERE id=$1', [customerId])
        .then(() => res.send(`Customer ${customerId} deleted!`))
        .catch((e) => console.error(e));
    }
  });
};

//1.10 Add a new GET endpoint /customers/:customerId/orders to load all the orders along the items
//in the orders of a specific customer.
//Especially, the following information should be returned:
//order references, order dates, product names, unit prices, suppliers and quantities.
const getCustomersOrders = (req, res) => {
  const customerId = req.params.customerId;

  database.pool
    .query(
      `
    SELECT order_reference, order_date, product_name, unit_price, supplier_name, quantity
    FROM customers AS c
    INNER JOIN orders AS o ON c.id=o.customer_id
    INNER JOIN order_items AS i ON o.id=i.order_id
    INNER JOIN products AS p ON p.id=i.product_id
    INNER JOIN suppliers AS s ON s.id=p.supplier_id
    WHERE c.id=$1`,
      [customerId]
    )
    .then((result) => res.json(result.rows))
    .catch((e) => console.error(e));
};

module.exports = {
  getCustomers,
  getCustomersById,
  getCustomersOrders,
  getSuppliers,
  getProducts,
  putCustomers,
  postCustomers,
  postProducts,
  postOrder,
  deleteOrders,
  deleteCustomers
};
