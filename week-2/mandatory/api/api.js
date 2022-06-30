const database = require('./database');

//QUERIES
const getCustomers = (req, res) => {
  database.pool.query('SELECT * FROM customers', (error, result) => {
    res.json(result.rows);
  });
};

const getSuppliers = (req, res) => {
  database.pool.query('SELECT * FROM suppliers', (error, result) => {
    res.json(result.rows);
  });
};

const getProducts = (req, res) => {
  database.pool.query('SELECT product_name, supplier_name FROM products AS p INNER JOIN suppliers AS s ON s.id=supplier_id', (error, result) => {
    res.json(result.rows);
  });
};

module.exports = { getCustomers, getSuppliers, getProducts };
