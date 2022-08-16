const database = require('./database');

let todayDate = new Date().toISOString().slice(0, 10);
//QUERIES
const getCustomers = (req, res) => {
  const queryText = database.pool.query('SELECT * FROM customers', (error, result) => {
    res.json(result.rows);
  });
};

const getRestaurants = (req, res) => {
  database.pool.query(`
    SELECT r.name, r.foodtype, r.address
    FROM restaurants AS r
    `,
    (error, result) => {
      res.json(result.rows);
    }
  );
};

const getNearest = (req, res) => {
  const coordX = Number(req.query.userCoordX);
  const coordY = Number(req.query.userCoordY);
  const desiredDistance = Number(req.query.distance);
  const type = req.query.type;

  const distanceCalc = `ABS(r.coordX-${coordX}) + ABS(r.coordY-${coordY})`;
  const timeCalc = `(ABS(r.coordX-${coordX}) + ABS(r.coordY-${coordY}) + prepTime)/60`;

  const queryText = `
   SELECT r.name, r.foodtype, r.address, ${timeCalc} AS deliveryTime, ${distanceCalc} AS distance
   FROM restaurants AS r
   WHERE r.foodtype LIKE '%${type}%' AND ${distanceCalc} < ${desiredDistance}
   ORDER BY deliveryTime`;
  database.pool.query(queryText, (error, result) => {
    res.json(error || result.rows);
  });
};

const postOrder = (req, res) => {
  const coordX = Number(req.query.userCoordX);
  const coordY = Number(req.query.userCoordY);
  const userID = req.body.userId;
  const food_id = req.body.food_id;
  const quantity = req.body.quantity;
  const timeCalc = `(ABS(r.coordX-${coordX}) + ABS(r.coordY-${coordY}) + f.prepTime)/60`;

  const queryOrderNumber = `INSERT INTO orders (customer_id, order_date) VALUES ($1, $2) RETURNING id`;
  const queryOrderItems = `INSERT INTO order_items (order_id, food_id, quantity) VALUES ($1, $2, $3)`;
  const queryResponse = `SELECT MAX(f.prepTime) + (ABS(r.coordX-$1) + ABS(r.coordY-$2))/60 AS deliveryTime
  FROM food AS f
  INNER JOIN restaurants AS r ON r.id=f.restaurant_id
  WHERE r.id=$3 AND f.id IN 3
  GROUP BY r.coordX, r.coordY`;

  database.pool.query(queryOrderNumber, [userID, todayDate]).then((result) => {
    const orderId = result.rows[0].id;
    database.pool.query(queryOrderItems, [orderId, food_id, quantity]).then((result) => {
      database.pool.query(queryResponse, [coordX, coordY, orderId]).then((result) => {
        res.send(`Order completed, Your delivery time is ${result.rows[0].deliveryTime} `).catch((e) => console.error(e));
      });
    });
  });
};

module.exports = { getCustomers, getRestaurants, getNearest, postOrder };

/* OK FUNCIONA 
   SELECT r.name, r.foodtype, r.address, ABS(r.coordX-${coordX}) + ABS(r.coordY-${coordY}) AS distance 
   FROM restaurants AS r
   WHERE r.foodtype='${type}'
   ORDER BY distance`;
*/

