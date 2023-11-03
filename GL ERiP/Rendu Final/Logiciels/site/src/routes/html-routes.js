const path = require('path');

const isAuthenticated = require('../config/middleware/isAuthenticated');

module.exports = function(app)
{
    app.get('/', function(req, res)
    {
        /* If the user has an account, redirect to the members page */
        if(req.user)
        {
            res.redirect('/dashboard');
        }
        res.sendFile(path.join(__dirname, "../public/html/login.html"))
    });

    app.get('/signup', function(req, res)
    {
         /* If the user has an account, redirect to the members page */   
        if(req.user)
        {
            res.redirect('/members');
        }
        res.sendFile(path.join(__dirname, '../public/html/signup.html'));
    });

    app.get("/dashboard", isAuthenticated, function(req, res)
    {
        res.sendFile(path.join(__dirname, '../public/html/dashboard.html'));
    });


    app.get("/filesDeposit", isAuthenticated, function(req, res)
    {
        res.sendFile(path.join(__dirname, '../public/html/filesDeposit.html'));
    });

    app.get("/applicationTracking", isAuthenticated, function(req, res)
    {
        res.sendFile(path.join(__dirname, '../public/html/applicationTracking.html'));
    });

    app.get("/meetingsTracking", isAuthenticated, function(req, res)
    {
        res.sendFile(path.join(__dirname, '../public/html/meetingsTracking.html'));
    });

}