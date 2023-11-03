module.exports = function(req, res, next)
{

    /* If the user is logged in, continue with the request to the restricted route */
    if(req.user)
    {
        return next();
    }

    /* If the user isn't logged in, he is redirected to the login page */
    return res.redirect("/");
}