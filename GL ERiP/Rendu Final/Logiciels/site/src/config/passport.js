const passport = require("passport");
const LocalStrategy = require("passport-local").Strategy;

const db = require("../models");

passport.use(new LocalStrategy(
    {
        usernameField: "email"
    },
    function(email, password, done)
    {
        db.Utilisateurs.findOne(
            {
                where:
                {
                    courriel: email
                }
            }).then(function(dbUser)
            {
                /* If the mail doesn't exist */
                if(!dbUser)
                {
                    return done(null, false,
                        {
                            message: "Incorrect email."
                        });
                }
                /* If the password is wrong */
                else if(!dbUser.validPassword(password))
                {
                    return done(null, false,
                        {
                            message: "Incorrect password."
                        });
                }

                /* If everything is correct, return the user */
                return done(null, dbUser);
            })
    }
));



passport.serializeUser(function(user, cb)
{
    cb(null, user);
});

passport.deserializeUser(function(obj, cb)
{
    cb(null, obj);
});


module.exports = passport;