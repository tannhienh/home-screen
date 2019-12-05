#include "xmlwriter.h"
#include <QDebug>

XmlWriter::XmlWriter(QString filePath, ApplicationsModel &appsModel)
{
    m_filePath = filePath;
    m_appsModel = new ApplicationsModel;
    m_appsModel = &appsModel;
}

void XmlWriter::XmlReadModel(ApplicationsModel *appsModel)
{
    QDomElement root = doc.createElement("APPLICATIONS");
    doc.appendChild(root);

    if (appsModel->rowCount() > 0) {
        for (int i = 0; i < appsModel->rowCount(); i++) {
            QDomElement app = doc.createElement("APP");

            // Generation id
            QString id = "";
            if (i < 9)
                id = "00";
            else if (i < 99)
                id = "0";

            id += QString::number(i+1);

            // App Id
            app.setAttribute("ID", id);
            root.appendChild(app);

            // App Name
            QDomElement appName = doc.createElement("TITLE");
            QString title = appsModel->data(appsModel->index(i, 0), 258).toString();
            QDomText appText = doc.createTextNode(title);
            appName.appendChild(appText);
            app.appendChild(appName);

            // App Url
            QDomElement appUrl = doc.createElement("URL");
            QString url = appsModel->data(appsModel->index(i, 0), 259).toString();
            QDomText urlText = doc.createTextNode(url);
            appUrl.appendChild(urlText);
            app.appendChild(appUrl);

            // App Icon Path
            QDomElement iconPath = doc.createElement("ICON_PATH");
            QString path = appsModel->data(appsModel->index(i, 0), 260).toString();
            QDomText pathText = doc.createTextNode(path);
            iconPath.appendChild(pathText);
            app.appendChild(iconPath);
        }
    }
}

void XmlWriter::writeToFile()
{
    QFile file(m_filePath);

    if (file.open(QIODevice::WriteOnly)) {
        XmlReadModel(m_appsModel);
        QTextStream textStream(&file);
        textStream << doc.toString();
    } else
        qDebug() << "Write apps model to xml file failed!";

    file.close();
}
