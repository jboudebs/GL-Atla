module.exports = function(sequelize, DataTypes)
{
    var Status = sequelize.define("Hist_Statuts",
    {
        idHistorique:
        {
            type: DataTypes.INTEGER,
            primaryKey: true,
            allowNull: false,
            autoIncrement: true
        },
        fk_idCandidat:
        {
            type: DataTypes.INTEGER,
            allowNull: false
        },
        fk_idUtilisateur_update:
        {
            type: DataTypes.INTEGER,
            allowNull: false
        },
        statut:
        {
            type: DataTypes.STRING,
            allowNull: false
        },
        date:
        {
            type: DataTypes.DATE,
            allowNull: false
        }
    },
    {
        timestamps: false
    });

    return Status;
}