#ifndef APPLICATIONITEM_H
#define APPLICATIONITEM_H

#include <QString>  // Using QString for info application variables

class ApplicationItem
{
public:

    // Create new application item
    ApplicationItem(QString id, QString title, QString url, QString iconPath);

    // Get Id applicaiton
    QString id() const;

    // Get title application
    QString title() const;

    // Get url application
    QString url() const;

    // Get icon path application
    QString iconPath() const;

private:

    QString m_id;           // id for application
    QString m_title;        // title application
    QString m_url;          // url application
    QString m_iconPath;     // icon path application
};

#endif // APPLICATIONITEM_H
