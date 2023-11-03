const PORT = 8080;

const express = require('express');
const bodyParser = require('body-parser');
const session = require('express-session');

const passport = require('../config/passport');

const db = require("../models");

/* Creating express app and configuring middlewares for the authentication */
const app = express();
app.use(bodyParser.urlencoded({ extended: false}));
app.use(bodyParser.json());
app.use(express.static('public'));

/* Sessions is used to keep informations of user's login status */
app.use(session({ secret:"keyboard cat", resave: true, saveUninitialized: true}));
app.use(passport.initialize());
app.use(passport.session());

/* Requiring routes */
require('../routes/html-routes.js')(app);
require('../routes/api-routes')(app);

/* Syncing database and listening on PORT */
db.sequelize.sync().then(function()
{
  app.listen(PORT, function()
  {
    console.log('Server listening on port ' + PORT);
  })
});