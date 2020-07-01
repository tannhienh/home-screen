import QtQuick 2.13
import QtQuick.Controls 2.13
import Qt.labs.settings 1.1

Item {
    id: settingsId

    // Font Cantarell
    FontLoader {
        id: cantarell
        source: "qrc:/Fonts/Cantarell-Regular.ttf"
    }

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

    // Setting detail
    StackView {
        id: settingDetailStackView
        width: parent.width - settingsMenu.width - 80
        initialItem: GeneralSettings{}
        anchors {
            top: parent.top
            right: parent.right
            bottom: parent.bottom
            margins: 40
        }

        // Background Settings detail
        Rectangle {
            id: settingsDetail
            opacity: 0.5
            anchors.fill: parent
            gradient: Gradient {
                GradientStop { position: 0; color: "#2B2E30" }
                GradientStop { position: 0.5; color: "#121213" }
                GradientStop { position: 1; color: "#2B2E30" }
            }
        }

        pushEnter: Transition {
            PropertyAnimation {
                property: "x"
                from: -20
                to: 0
                duration: 300
                easing.type: Easing.OutQuad
            }
            PropertyAnimation {
                property: "opacity"
                from: 0
                to: 1
                duration: 300
                easing.type: Easing.OutQuad
            }
        }

        pushExit: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 1
                to: 0
                duration: 0
            }
        }

        popExit: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 1
                to: 0
                duration: 0
            }
        }
    }

    Connections {
        target: statusBar
        onBackButtonClicked: {
            settingsMenu.close()
        }
    }

//    Connections {
//        target: comboBoxDate

//        onDisplayTextChanged: {
//            console.log("Text changed: " + displayText)
//            mainSettings.currentDate = calendar.selectedDate
//        }
//    }
}
