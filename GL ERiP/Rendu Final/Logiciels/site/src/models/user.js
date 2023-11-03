const bcrypt = require('bcryptjs');

module.exports = function(sequelize, DataTypes)
{
    var User = sequelize.define("Utilisateurs",
    {
        idUtilisateur:
        {
            type: DataTypes.INTEGER,
            allowNull: false,
            primaryKey: true,
            autoIncrement: true
        },
        nom:
        {
            type: DataTypes.STRING,
            allowNull: false
        },
        prenom:
        {
            type: DataTypes.STRING,
            allowNull: false
        },
        courriel:
        {
            type: DataTypes.STRING,
            allowNull: false,
            unique: true,
            validate:
            {
                isEmail: true
            }
        },
        motDePasse_hash:
        {
            type: DataTypes.STRING,
            allowNull: false
        },
        motDePasse_salt:
        {
            type: DataTypes.STRING,
            allowNull: true
        }
    },
    {
        timestamps: false
    });

    User.prototype.validPassword = function(password)
    {
        return bcrypt.compareSync(password, this.motDePasse_hash);
    };

    User.beforeCreate(function(user)
    {
        user.motDePasse_hash = bcrypt.hashSync(user.motDePasse_hash, bcrypt.genSaltSync(10), null);
    });
    

    return User;
}
