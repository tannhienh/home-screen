#ifndef APPLICATIONITEM_H
#define APPLICATIONITEM_H

#include <QString>  // Using QString for variables info application

class ApplicationItem
{
public:

    // Create new application item
    ApplicationItem(QString title, QString url, QString iconPath);

    // Get title application
    QString title() const;

    // Get url application
    QString url() const;

    // Get icon path application
    QString iconPath() const;

private:
    QString m_title;        // title application
    QString m_url;          // url application
    QString m_iconPath;     // icon path application
};

#endif // APPLICATIONITEM_H
