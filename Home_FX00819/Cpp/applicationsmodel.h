#ifndef APPLICATIONSMODEL_H
#define APPLICATIONSMODEL_H

#include <QAbstractListModel>
#include "applicationitem.h"

class ApplicationsModel : public QAbstractListModel
{
public:
    // Constructor function
    ApplicationsModel();

    // Count the number of applications in list model
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    // Get data a role of an application at index position
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) \
    const override;

    // Add an application item into list model
    void addApplication(ApplicationItem &item);

    // Roles info an application
    enum Roles {
        TitleRole = Qt::UserRole + 1,
        UrlRole,
        IconPathRole
    };

protected:
    // Create hash table for roles an application
    QHash<int, QByteArray> roleNames() const override;

private:
    // Store list applications
    QList<ApplicationItem> m_data;
};

#endif // APPLICATIONSMODEL_H
