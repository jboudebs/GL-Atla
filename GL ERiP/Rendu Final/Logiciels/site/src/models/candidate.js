module.exports = function(sequelize, DataTypes)
{
    var Candidate = sequelize.define("Candidats",
    {
        fk_idCandidat:
        {
            type:DataTypes.INTEGER,
            primaryKey: true,
            allowNull: false,
            autoIncrement: true
        },
        CV:
        {
            type: DataTypes.TINYINT,
            allowNull: false,
            defaultValue: 0
        },
        LM:
        {
            type: DataTypes.TINYINT,
            allowNull: false,
            defaultValue: 0
        },
        CNI:
        {
            type: DataTypes.TINYINT,
            allowNull: false,
            defaultValue: 0
        },
        releve1:
        {
            type: DataTypes.TINYINT,
            allowNull: false,
            defaultValue: 0
        },
        releve2:
        {
            type: DataTypes.TINYINT,
            allowNull: false,
            defaultValue: 0
        }
    },
    {
        timestamps: false
    });

    return Candidate;
}