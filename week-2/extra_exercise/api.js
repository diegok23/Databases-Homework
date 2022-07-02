const database = require('./database');

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

module.exports = { getCustomers, getRestaurants, getNearest };

/* OK FUNCIONA 
   SELECT r.name, r.foodtype, r.address, ABS(r.coordX-${coordX}) + ABS(r.coordY-${coordY}) AS distance 
   FROM restaurants AS r
   WHERE r.foodtype='${type}'
   ORDER BY distance`;
*/

