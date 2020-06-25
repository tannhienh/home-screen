import QtQuick 2.13
import QtQuick.Controls 2.13
import Qt.labs.settings 1.1

Item {
    id: settingsId

    // Font Ubuntu
    FontLoader {
        id: ubuntu
        source: "qrc:/Fonts/Ubuntu-Regular.ttf"
    }

    // 4 = width vertical line on right side Settings menu area
    SettingsMenu {
        id: settingsMenu
        width: (parent.width / 3) + 4
        topMargin: 85
        visible: true
        height: parent.height - 85
    }

    // Settings detail
    SettingsDetail {
        width: parent.width - settingsMenu.width - 80
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
            settingsMenu.close()
        }
    }
}
