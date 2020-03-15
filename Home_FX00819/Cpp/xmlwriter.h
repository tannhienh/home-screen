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

    XmlWriter(QString filePath, ApplicationsModel *appsModel);

    void readModel(QDomDocument &doc, ApplicationsModel *appsModel);

public slots:
    void writeToFile();

private:
    QString m_filePath;
    ApplicationsModel *m_appsModel = nullptr;
};

#endif // XMLWRITER_H
