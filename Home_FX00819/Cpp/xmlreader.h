#ifndef XMLREADER_H
#define XMLREADER_H

#include <QtXml>
#include <QFile>
#include "applicationsmodel.h"

class XmlReader
{
public:
    // Constructor XmlReader function
    XmlReader(QString filePath, ApplicationsModel &appsModel);

private:
    //The QDomDocument class represents an XML document
    QDomDocument xmlDocument;

    // Check xml file and set content for xmlDocument
    // Return true if read xml file successfull
    // Return false if read xml file failed
    bool ReadXmlFile(QString filePath);

    // Parse xml file
    void ParseXmlFile(ApplicationsModel &appsModel);
};

#endif // XMLREADER_H
