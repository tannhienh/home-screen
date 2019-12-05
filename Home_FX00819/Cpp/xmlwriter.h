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

    XmlWriter(QString filePath, ApplicationsModel &appsModel);

    void XmlReadModel(ApplicationsModel *appsModel);

public slots:
    void writeToFile();

private:
    QDomDocument doc;
    QString m_filePath;
    ApplicationsModel *m_appsModel;
};

#endif // XMLWRITER_H
