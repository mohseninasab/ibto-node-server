const express = require('express');
const router = express.Router();
const mysql = require('mysql');
const config = require('../config/config');


// #############################################################################
// create connection to the MySQL database
// #############################################################################

const MySQLConnection = mysql.createConnection({
  host: config.dbAddress,
  user: config.dbUser,
  password: config.dbPassword,
  database: config.dbName
});

// #############################################################################
// insert Data
// #############################################################################

router.put("", (req, res) => {
  MySQLConnection.query(req.body.query, function (err, result) {
    console.error(err)
    if(req.body.secondQuery)
      MySQLConnection.query(req.body.secondQuery, function (err, result) { 
        console.error(err)
        return res.json(result); 
      });
    else
      return res.json(result);
  });
});

// #############################################################################
// insert Data
// #############################################################################

router.post("", (req, res) => {
  MySQLConnection.query(req.body.query, function (err, result) {
    return res.json(result);
  });
});

// #############################################################################
// the export of the mudule
// #############################################################################

router.delete("", (req, res) => {
  MySQLConnection.query(req.body.query, function (err, result) {
    return res.json({success: result.affectedRows > 0});
  });
});

// #############################################################################
// the export of the mudule
// #############################################################################

module.exports = router;