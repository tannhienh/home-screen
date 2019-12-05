#include "applicationitem.h"

// Create new application item
ApplicationItem::ApplicationItem(QString id, QString title, QString url,
                                 QString iconPath)
{
    m_id = id;
    m_title = title;
    m_url = url;
    m_iconPath = iconPath;
}

// Get Id application
QString ApplicationItem::id() const
{
    return m_id;
}

// Get title application
QString ApplicationItem::title() const
{
    return m_title;
}

// Get url application
QString ApplicationItem::url() const
{
    return m_url;
}

// Get icon path application
QString ApplicationItem::iconPath() const
{
    return m_iconPath;
}
