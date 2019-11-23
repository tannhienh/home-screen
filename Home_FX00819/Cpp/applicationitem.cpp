#include "applicationitem.h"

// Create new application item
ApplicationItem::ApplicationItem(QString title, QString url, QString iconPath)
{
    m_title = title;
    m_url = url;
    m_iconPath = iconPath;
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
