#ifndef XMLWRITER_H
#define XMLWRITER_H

#include <QFile>
#include <QDomDocument>
#include <QTextStream>

#include "applicationsmodel.h"

class XmlWriter : public QObject
{
    Q_OBJECT

public:

    // Constructor
    XmlWriter(QString filePath, ApplicationsModel *appsModel);

    // Read model function
    void readModel(QDomDocument &doc, ApplicationsModel *appsModel);

public slots:

    // Write model to xml file
    void writeToFile();

private:

    // path xml file
    QString m_filePath;

    // Apps model
    ApplicationsModel *m_appsModel = nullptr;
};

#endif // XMLWRITER_H
