const createError = require('http-errors');
const express = require('express');
const path = require('path');
const cookieParser = require('cookie-parser');
const logger = require('morgan');
const bodyParser = require('body-parser');

// our requirements
const indexRouter = require('./routes/index');
const api = require('./routes/api');
const app = express();

// #############################################################################
// 
// #############################################################################

app.use(function (req, res, next) {
  var allowedOrigins = process.env.CROSS || ['http://localhost:5005', 'http://localhost:3000']
  let origin = req.headers.origin;
  if (allowedOrigins.indexOf(origin) > -1) {
    res.setHeader('Access-Control-Allow-Origin', origin);
  }
  res.header("Access-Control-Allow-Credentials", "true")
  res.header('Access-Control-Allow-Methods', 'GET, POST, PUT, PATCH, DELETE, HEAD, OPTIONS');
  res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept, Content-Length, Authorization, Cookie, authorization");
  // res.header("Access-Control-Expose-Headers", "Set-Cookie")
  //TODO: handel option request problem.
   if ('OPTIONS' === req.method) {
     //respond with 200
     res.send(200);
   } else {
     //move on
     next();
   }
  // next();
});

// #############################################################################
// 
// #############################################################################

app.disable('x-powered-by');

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));
app.use(bodyParser.urlencoded({'extended': 'true'})); // parse application/x-www-form-urlencoded
app.use(bodyParser.json()); // parse application/json
app.use(bodyParser.json({type: 'application/vnd.api+json'})); // parse application/vnd.api+json as json


app.use('/', indexRouter);
app.use('/api', api);

// catch 404 and forward to error handler
app.use(function(req, res, next) {
  next(createError(404));
});

// error handler
app.use(function(err, req, res, next) {
  console.log(err)
  // set locals, only providing error in development
  //TODO: res.locals...
  // res.locals.message = err.message;
  // res.locals.error = req.app.get('env') === 'development' ? err : {};

  err.status ? res.status(err.status).json(err) : res.status(500).json(err);
  // // render the error page
  // res.status(err.status || 500);
  // res.render('error');
});

module.exports = app;
