import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQuick.VirtualKeyboard 2.13

Item {
    id: phoneApp

    // Font Ubuntu
    FontLoader {
        id: ubuntu
        source: "qrc:/Fonts/Ubuntu-Regular.ttf"
    }

    // 4 = width vertical line right side phone contacts area
    PhoneContacts {
        id: phoneContacts
        width: (parent.width / 3) + 4
        topMargin: 85
        visible: true
        height: parent.height - 85
    }

    PhoneInputArea {
        width: parent.width - phoneContacts.width - 80
        anchors {
            top: parent.top
            right: parent.right
            bottom: parent.bottom
            margins: 40
        }
    }

    Connections {
        target: statusBar
        onBackButtonClicked: {
            phoneContacts.close()
        }
    }
}
