import QtQuick 2.13
import QtQuick.Controls 2.13

ApplicationWindow {
    id: rootWindow
    visible: true
    width: 800
    height: 800
    title: qsTr("Simulator - Home Screen")

    color: "LightGray"

    Item {
        id: climateArea
        anchors {
            top: parent.top
            topMargin: 10
            left: parent.left
            leftMargin: 10
            right: parent.right
            rightMargin: 10
        }
        height: (rootWindow.height / 2) - 20

        Rectangle {
            color: "White"
            anchors.fill: parent
        }

        Column {
            spacing: 20
            anchors.centerIn: parent
            Row {
                id: tempDriverItem
                Text {
                    id: tempDriverText
                    text: "Temperature Driver: "
                    anchors.verticalCenter: tempDriverSpinBox.verticalCenter
                }

                SpinBox {
                    id: tempDriverSpinBox
                    anchors.leftMargin:
                }
            }

            Item {
                id: tempPassengerItem
            }
        }
    }

    Item {
        id: controlArea
        anchors {
            top: climateArea.bottom
            topMargin: 10
            left: parent.left
            leftMargin: 10
            right: parent.right
            rightMargin: 10
        }
        height: (rootWindow.height / 2) - 10

        Rectangle {
            color: "White"
            anchors.fill: parent
        }
    }
}
