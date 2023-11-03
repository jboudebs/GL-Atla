const db = require('../models');
const passport = require('../config/passport');
const multer = require('multer');
const fs = require('fs');
const path = require('path');

const storage = multer.diskStorage(
{
    destination: function (req, file, callback)
    {
        callback(null, './uploads');
    },
    filename: function (req, file, callback)
    {
        callback(null, file.fieldname);
    }

    //TODO: Add a fileFilter function to accept only .pdf / .png ... 
    
});

const upload = multer({ storage: storage }).single('uploadedFile');

const wildcard = require('node-wildcard');



module.exports = function (app)
{
    /* Route to logging in */
    app.post('/api/login', passport.authenticate("local"), function (req, res)
    {
        res.json('/dashboard');
    });


    /* Route to signin up a new user */
    app.post('/api/signup', function (req, res)
    {
        db.Utilisateurs.create(
        {
            courriel: req.body.email,
            motDePasse_hash: req.body.password,
            nom: req.body.lastName,
            prenom: req.body.firstName
        })
        .then(function (dbUser)
        {
            db.Candidats.create(
            {
                fk_idCandidat: dbUser.idUtilisateur
            });
            res.redirect(307, '/api/login');
        })
        .catch(function (err)
        {
            console.log('>>>' + err);
            res.json({error: "Courriel déjà utilisé"});
            
            //TODO: errors handling
        });
    });


    /* Route to logging out */
    app.get('/logout', function (req, res)
    {
        req.logout();
        res.redirect('/');
    });


    /* Route to get data about user */
    app.get('/api/user_data', function (req, res)
    {
        /* If the user is not logged in, empty data */
        if (!req.user)
        {
            res.json({});
        }
        /* Otherwise send datas */
        else
        {
            res.json(
            {
                email: req.user.courriel,
                id: req.user.idUtilisateur,
                firstName: req.user.prenom,
                lastName: req.user.nom
            });
        }
    });

    /* Route to get the status of a user */
    app.get('/api/user_status', function(req, res)
    {
        /* If the user is not logged in, empty data */
        if (!req.user)
        {
            res.json({});
        }
        /* Otherwise send datas */
        else
        {
            /* Query the database to get the current status of the user */
            db.sequelize.query('SELECT * FROM Hist_Statuts WHERE fk_idCandidat = :id AND date = (SELECT MAX(date) FROM Hist_Statuts)',
            {
                model: db.Hist_Statuts,
                mapToModel: true,
                replacements: {id: req.user.idUtilisateur}
            }).then(function(dbStatus)
            {
                if(typeof dbStatus[0] === "undefined")
                {
                    res.json(
                    {
                        status: 'undefined'
                    })
                }
                else
                {
                    res.json(
                    {
                        status: dbStatus[0].statut
                    });
                }
            });
        }
    });

    /* Route to show files that the user already updated */
    app.get('/api/user_files',function(req,res)
    {
        /* If the user is not logged in, empty data */
        if (!req.user)
        {
            res.json({});
        }
        else
        {
            db.sequelize.query('SELECT fk_idCandidat, CV, LM, CNI, releve1, releve2 FROM Candidats WHERE fk_idCandidat = :id',
                {
                    model: db.Candidats,
                    mapToModel: true,
                    replacements: {id: req.user.idUtilisateur}
                }).then(function(dbCandidats)
                {
                    res.json(
                    {
                        CV: dbCandidats[0].CV,
                        LM: dbCandidats[0].LM,
                        ID: dbCandidats[0].CNI,
                        SR: dbCandidats[0].releve1
                    }
                    )
                });
        }

    });

    /* Route to get meetings of the current user */
    app.get('/api/user_meetings', function (req, res)
    {
        /* If the user is not logged in, empty data */
        if (!req.user)
        {
            res.json({});
        }
        else
        {
            /* Query the database to get the meetings of the user */
            db.sequelize.query('SELECT * FROM Entretiens WHERE Candidats_idCandidat = :id AND dateDebut > (SELECT NOW())',
            {
                model: db.Entretiens,
                mapToModel: true,
                replacements: {id: req.user.idUtilisateur}
            }).then(function(dbEntretien)
            {
                /* If the user has no upcoming meetings */
                if(typeof dbEntretien[0] === "undefined")
                {
                    res.json(
                    {
                        dateDebut: 'undefined'
                    })
                }
                /* Else sending back the meetings */
                else
                {
                    res.json(dbEntretien);
                }
            });
        }
        
    });

    /* Route to upload motivationLetter */
    app.post('/api/uploadMotivationLetter', function (req, res)
    {
        /* Upload on the server the user's file */
        uploadAsync(req, res).then(function ()
        {
            if(req.file)
            {
                fs.stat('./uploads/user' + req.user.idUtilisateur, function (err, stats)
                {
                    /* Create a directory for the current user if it doesn't exist */
                    if (!stats)
                    {
                        mkdir('./uploads/user' + req.user.idUtilisateur);
                        rename('./uploads/uploadedFile', './uploads/user' + req.user.idUtilisateur + '/motivationLetter' + path.extname(req.file.originalname)); // Move the file in the user's directory and rename it
                        res.end();
                    }
                    else
                    {
                        var files = fs.readdirSync('./uploads/user' + req.user.idUtilisateur);
        
                        files.forEach(function(file)
                        {
                            if( wildcard(file, 'motivationLetter.*') )
                            {
                                fs.unlinkSync('./uploads/user' + req.user.idUtilisateur + '/' + file);
                            }
                        });
                        rename('./uploads/uploadedFile', './uploads/user' + req.user.idUtilisateur + '/motivationLetter' + path.extname(req.file.originalname)); // Move the file in the user's directory and rename it
                        res.end();
                    }
                                
                    /* Set in the database the motivationLetter to True */
                            
                    db.Candidats.update(
                        {LM: true},
                        {where: {fk_idCandidat: req.user.idUtilisateur}}
                        ); 
                    });            
            }
            else
            { 
                console.log('No file'); 
                res.end();
            }
        });
    });

    
    /* Route to upload CV */
    app.post('/api/uploadCV', function (req, res)
    {
        /* Upload on the server the user's file */
        uploadAsync(req, res).then(function ()
        {
            if(req.file)
            {
                fs.stat('./uploads/user' + req.user.idUtilisateur, function (err, stats)
                {
                    /* Create a directory for the current user if it doesn't exist */
                    if (!stats)
                    {
                        mkdir('./uploads/user' + req.user.idUtilisateur);
                        rename('./uploads/uploadedFile', './uploads/user' + req.user.idUtilisateur + '/CV' + path.extname(req.file.originalname)); // Move the file in the user's directory and rename it
                        res.end();
                    }
                    else
                    {
                        var files = fs.readdirSync('./uploads/user' + req.user.idUtilisateur);
        
                        files.forEach(function(file)
                        {
                            if( wildcard(file, 'CV.*') )
                            {
                                fs.unlinkSync('./uploads/user' + req.user.idUtilisateur + '/' + file);
                            }
                        });
                        rename('./uploads/uploadedFile', './uploads/user' + req.user.idUtilisateur + '/CV' + path.extname(req.file.originalname)); // Move the file in the user's directory and rename it
                        res.end();
                    }
                    
                    /* Set in the table Candidate the CV attribute to True */
                    db.Candidats.update(
                    
                        {CV: true},
                        {where: {fk_idCandidat: req.user.idUtilisateur}}

                    ); 
                });
            }
            else
            {
                console.log('No file');
                res.end();
            }
        });
    });

    /* Route to upload ID */
    app.post('/api/uploadID', function (req, res)
    {
        /* Upload on the server the user's file */
        uploadAsync(req, res).then(function ()
        {
            if(req.file)
            {
                fs.stat('./uploads/user' + req.user.idUtilisateur, function (err, stats)
                {
                    /* Create a directory for the current user if it doesn't exist */
                    if (!stats)
                    {
                        mkdir('./uploads/user' + req.user.idUtilisateur);
                        rename('./uploads/uploadedFile', './uploads/user' + req.user.idUtilisateur + '/ID' + path.extname(req.file.originalname)); // Move the file in the user's directory and rename it
                        res.end();
                    }
                    else
                    {
                        var files = fs.readdirSync('./uploads/user' + req.user.idUtilisateur);
                        files.forEach(function(file)
                        {
                            if( wildcard(file, 'ID.*') )
                            {
                                fs.unlinkSync('./uploads/user' + req.user.idUtilisateur + '/' + file);
                            }
                        });
                        rename('./uploads/uploadedFile', './uploads/user' + req.user.idUtilisateur + '/ID' + path.extname(req.file.originalname)); // Move the file in the user's directory and rename it
                        res.end();
                    }
                    
                    /* Set in the table Candidate the ID attribute to True */
                    db.Candidats.update(
                    
                        {CNI: true},
                        {where: {fk_idCandidat: req.user.idUtilisateur}}

                    )
                });
            }
            else
            { 
                console.log('No file'); 
                res.end();
            }
        });
    });

    /* Route to upload CV */
    app.post('/api/uploadSchoolReport', function (req, res)
    {
        /* Upload on the server the user's file */
        uploadAsync(req, res).then(function ()
        {
            if(req.file)
            {
                fs.stat('./uploads/user' + req.user.idUtilisateur, function (err, stats)
                {
                    /* Create a directory for the current user if it doesn't exist */
                    if (!stats)
                    {
                        mkdir('./uploads/user' + req.user.idUtilisateur);
                        rename('./uploads/uploadedFile', './uploads/user' + req.user.idUtilisateur + '/releve' + path.extname(req.file.originalname)); // Move the file in the user's directory and rename it
                        res.end();
                    }
                    else
                    {
                        var files = fs.readdirSync('./uploads/user' + req.user.idUtilisateur);
        
                        files.forEach(function(file)
                        {
                            if( wildcard(file, 'releve.*') )
                            {
                                fs.unlinkSync('./uploads/user' + req.user.idUtilisateur + '/' + file);
                            }
                        });
                        rename('./uploads/uploadedFile', './uploads/user' + req.user.idUtilisateur + '/releve' + path.extname(req.file.originalname)); // Move the file in the user's directory and rename it
                        res.end();
                    }
                    
                    /* Set in the table Candidate the CV attribute to True */
                    db.Candidats.update(
                    
                        {releve1: true},
                        {where: {fk_idCandidat: req.user.idUtilisateur}}

                    ); 
                });
            }
            else
            {
                console.log('No file');
                res.end();
            }
        });
    });

    /* Function to create a new directory */
    function mkdir(name)
    {
        fs.mkdir(name, function (err)
        {
            console.log('Folder created');
            if (err) throw err;
        });
    }

    /* Move and rename function */
    function rename(oldPath, newPath)
    {
        fs.rename(oldPath, newPath, function (err)
        {
            if (err) throw err;
            console.log('File moved and renamed.');
        });
    }


    function uploadAsync(req, res)
    {
        return new Promise(function (resolve, reject)
        {
            upload(req, res, function (err)
            {
                if (err !== undefined) return reject(err);
                //res.sendFile(path.join(__dirname, '../public/html/filesDeposit.html')); /* Affiché 'fichier reçu ou non sur la page */
                resolve();
            });
        });
    }


    /* Route to download CV depending on the user's id */
    app.get('/api/downloadCV/:id', function(req, res)
    {
        var id = req.params.id;
        var files = fs.readdirSync('./uploads/user' + id);
        var isFilePresent = false;

    
        files.forEach(function(file)
        {
            if( wildcard(file, 'CV.*') )
            {
                res.download('./uploads/user' + id + '/' + file);
                isFilePresent = true;
            }
        });
        
        if(!isFilePresent){ res.send('No file'); }
    });

    /* Route to download ID depending on the user's id */
    app.get('/api/downloadID/:id', function(req, res)
    {
        var id = req.params.id;
        var files = fs.readdirSync('./uploads/user' + id);
        var isFilePresent = false;

    
        files.forEach(function(file)
        {
            if( wildcard(file, 'ID.*') )
            {
                res.download('./uploads/user' + id + '/' + file);
                isFilePresent = true;
            }
        });
        
        if(!isFilePresent){ res.send('No file'); }
    });

     /* Route to download motivationLetter depending on the user's id */
     app.get('/api/downloadMotivationLetter/:id', function(req, res)
     {
         var id = req.params.id;
         var files = fs.readdirSync('./uploads/user' + id);
         var isFilePresent = false;
 
     
         files.forEach(function(file)
         {
             if( wildcard(file, 'motivationLetter.*') )
             {
                 res.download('./uploads/user' + id + '/' + file);
                 isFilePresent = true;
             }
         });
         
         if(!isFilePresent){ res.send('No file'); }
     });

     /* Route to download motivationLetter depending on the user's id */
     app.get('/api/downloadSchoolReport/:id', function(req, res)
     {
         var id = req.params.id;
         var files = fs.readdirSync('./uploads/user' + id);
         var isFilePresent = false;
 
     
         files.forEach(function(file)
         {
             if( wildcard(file, 'releve.*') )
             {
                 res.download('./uploads/user' + id + '/' + file);
                 isFilePresent = true;
             }
         });
         
         if(!isFilePresent){ res.send('No file'); }
     });

}