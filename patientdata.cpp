#include "patientdata.h"

#include <QSqlRecord>
#include <QDebug>

PatientData::PatientData(QObject *parent, QSqlDatabase database)
    : QSqlTableModel(parent, database)
{
    setTable(QStringLiteral("patients"));
    setEditStrategy(QSqlTableModel::OnManualSubmit);
    select();
}

QHash<int, QByteArray> PatientData::roleNames() const
{
    QHash<int, QByteArray> roles;
    for(int i = 0; i < columnCount(); i++)
        roles[Qt::UserRole + 1 + i] = headerData(i, Qt::Horizontal).toByteArray();
    return roles;
}

QVariant PatientData::data(const QModelIndex &index, int role) const
{
    if(index.row() < 0 || index.row() > rowCount() || role < 0 || role > (columnCount() + Qt::UserRole + 1))
        return QVariant();
    if( role < Qt::UserRole)
        return (QSqlTableModel::data(index, role));
    else
        return QSqlTableModel::data(QSqlTableModel::index(index.row(), role - Qt::UserRole - 1), Qt::DisplayRole);
}

QVariant PatientData::roleFromRow(int row, QString roleName)
{
    QSqlRecord record = QSqlTableModel::record(row);
    return record.value(roleName);
}

void PatientData::removeRow(int row)
{
    removeRows(row, 1, QModelIndex());
    submitAll();
}

void PatientData::addRow(int row, QString newData)
{
    QStringList data = newData.split(";", Qt::KeepEmptyParts);
    QSqlRecord newRecord = record();

    if (row == -1)
        newRecord.setGenerated(QStringLiteral("id"), true);
    else
        newRecord = record(row);

    newRecord.setValue(QStringLiteral("firstName"), data.at(0));
    newRecord.setValue(QStringLiteral("lastName"), data.at(1));
    newRecord.setValue(QStringLiteral("dob"), data.at(2));
    newRecord.setValue(QStringLiteral("address"), data.at(3));
    newRecord.setValue(QStringLiteral("city"), data.at(4));
    newRecord.setValue(QStringLiteral("state"), data.at(5));
    newRecord.setValue(QStringLiteral("zipCode"), data.at(6));
    newRecord.setValue(QStringLiteral("comments"), data.at(7));
    newRecord.setValue(QStringLiteral("weightData"), data.at(8));

    if (row == -1)
        insertRecord(row, newRecord);
    else
        setRecord(row, newRecord);

    submitAll();
}
