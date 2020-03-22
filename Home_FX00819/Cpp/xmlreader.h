#ifndef XMLREADER_H
#define XMLREADER_H

#include <QFile>
#include <QDomDocument>
#include "applicationsmodel.h"

class XmlReader : public QObject
{
    Q_OBJECT

public:

    // Constructor XmlReader function
    XmlReader(QString filePath, ApplicationsModel *appsModel);

public slots:

    // Reload apps from xml file to model
    void reloadModel();

private:

    //The QDomDocument class represents an XML document
    QDomDocument xmlDocument;

    // Load apps from xml file to model
    void loadModel();

    /**
      * Check xml file and set content for xmlDocument
      * Return true if read xml file successfull
      * Return false if read xml file failed
      */
    bool readXmlFile(QString filePath);

    // Parse xml file
    void parseXmlFile(ApplicationsModel *appsModel);

    // Path of xml xml
    QString m_filePath;

    // Apps Model
    ApplicationsModel *m_appsModel = nullptr;
};

#endif // XMLREADER_H
