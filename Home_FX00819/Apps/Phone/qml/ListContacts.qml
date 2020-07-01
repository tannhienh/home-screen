import QtQuick 2.13
import QtQuick.Controls 2.13

Item {
    id: listContacts

    ListModel {
        id: listContactsModel

        ListElement {
            ContactName: "Daniel Nguyen"
            ContactNumber: "+84345657312"
        }

        ListElement {
            ContactName: "Paul Dao"
            ContactNumber: "+84345657324"
        }

        ListElement {
            ContactName: "Jonh Wick"
            ContactNumber: "+84345657323"
        }

        ListElement {
            ContactName: "Michael Tran"
            ContactNumber: "+84345657329"
        }

        ListElement {
            ContactName: "Daniel Nguyen"
            ContactNumber: "+84345657328"
        }

        ListElement {
            ContactName: "Paul Dao"
            ContactNumber: "+84345657324"
        }

        ListElement {
            ContactName: "Jonh Wick"
            ContactNumber: "+84345657323"
        }

        ListElement {
            ContactName: "Michael Tran"
            ContactNumber: "+84345657329"
        }
    }

    Component {
        id: listContactsDelegate

        Item {
            width: parent.width
            height: 130

            Text {
                id: contactName
                text: ContactName
                color: "#FFFFFF"
                font.pixelSize: 36
                font.family: cantarell.name
                anchors {
                    top: parent.top
                    topMargin: 20
                    left: parent.left
                    leftMargin: 40
                }
            }

            Text {
                id: contactNumber
                text: ContactNumber
                color: "#bebebe"
                font.pixelSize: 30
                font.family: ubuntu.name
                anchors {
                    left: contactName.left
                    top: contactName.bottom
                    topMargin: 10
                }
            }

            Image {
                id: callIcon
                source: "qrc:/Apps/Phone/images/call_icon.png"
                anchors {
                    right: parent.right
                    rightMargin: 20
                    verticalCenter: parent.verticalCenter
                }
            }

            Rectangle {
                id: lineBottomItem
                width: parent.width
                height: 3
                anchors.bottom: parent.bottom
                gradient: Gradient {
                    orientation: Gradient.Horizontal
                    GradientStop { position: 0.0; color: "#00474747" }
                    GradientStop { position: 0.5; color: "#a4a4a4" }
                    GradientStop { position: 1.0; color: "#00474747" }
                }
            }
        }
    }

    // List view phone contacts
    ListView {
        id: listViewContacts
        anchors.fill: parent
        model: listContactsModel
        delegate: listContactsDelegate
        clip: true
        snapMode: ListView.SnapToItem

        // Scrollbar for list contacts
        ScrollBar.vertical: ScrollBar {
            parent: listViewContacts.parent
            width: 10
            snapMode: ScrollBar.SnapOnRelease
            anchors {
                top: listViewContacts.top
                left: listViewContacts.right
                leftMargin: 4
                bottom: listViewContacts.bottom
            }
        }
    }
}
