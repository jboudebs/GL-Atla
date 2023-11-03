module.exports = function(sequelize, DataTypes)
{

    /*
    const moment = require('moment');
    moment.locale('fr');
    */
   
    var Meeting = sequelize.define("Entretiens",
    {
        Candidats_idCandidat:
        {
            type: DataTypes.INTEGER,
            allowNull: false
        },
        Jury_idJury:
        {
            type: DataTypes.INTEGER,
            allowNull: false
        },
        dateDebut:
        {
            type: DataTypes.DATE,
            primaryKey: true,
            allowNull: false
        },
        dateFin:
        {
            type: DataTypes.DATE,
            allowNull: false
        },
        fk_idSalle:
        {
            type: DataTypes.INTEGER,
            primaryKey: true,
            allowNull: false
        },
        note:
        {
            type: DataTypes.INTEGER,
            allowNull: true
        }
    },
    {
        timestamps: false
    });

    return Meeting;
}