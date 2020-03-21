import QtQuick 2.13
import QtQuick.Controls 2.13
import QtQml.Models 2.13

// Button.qml
import "Common"

// Javascript common function
import "../Js/Common.js" as Common

FocusScope {
    id: appsMenuScope

    //------------------------------------------------------------------------//
    // Begin Component Delegate
    //------------------------------------------------------------------------//
    Component {
        id: appsDelegate

        Loader {
            id: buttonLoader

            property int visualIndex: DelegateModel.itemsIndex

            source: {
                if (statusBar.editting)
                    return "qrc:/Qml/Common/ButtonEditMode.qml"
                else
                    return "qrc:/Qml/Common/ButtonNormalMode.qml"
            }
        }
    }
    //------------------------------------------------------------------------//
    // End Component Delegate
    //------------------------------------------------------------------------//


    // Delegate Model for apps menu
    DelegateModel {
        id: visualModel
        model: appsModel
        delegate: appsDelegate
    }

    //------------------------------------------------------------------------//
    // Begin Listview for apps menu
    //------------------------------------------------------------------------//
    ListView {
        id: appsMenu

        spacing: 22
        model: visualModel
        orientation: ListView.Horizontal
        snapMode: ListView.SnapToItem
        anchors.fill: parent
        focus: true

        // Key navigation for apps menu
        KeyNavigation.up: statusBar.editting ? appsMenu : widgetsArea

        anchors {
            fill: parent
            topMargin: 10
            bottomMargin: 20
            leftMargin: 20
            rightMargin: 20
        }

        displaced: Transition {
            NumberAnimation {
                properties: "x"
                easing.type: Easing.InOutQuad
            }
        }

        // Scrollbar
        ScrollBar.horizontal: scrollBar
    }
    //------------------------------------------------------------------------//
    // End Listview for apps menu
    //------------------------------------------------------------------------//

    //------------------------------------------------------------------------//
    // Begin Scroll bar
    //------------------------------------------------------------------------//
    ScrollBar {
        id: scrollBar

        property var stepValue: (1 - scrollBar.visualSize) /
                                (appsModel.rowCount() - 6)

        parent: appsMenu.parent
        height: 10
        orientation: Qt.Horizontal
        policy: ScrollBar.AlwaysOn
        stepSize: 1.0 / (appsModel.rowCount() - 6)
        snapMode: ScrollBar.SnapOnRelease
        interactive: false

        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }

        background: Rectangle {
            id: bgScrollBar
            color: "#808080"
        }

        contentItem: Rectangle {
            id: contentItem
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            color: "#7deef8"
        }

        // Animation for increase position of scroll bar when change order apps
        // in menu
        PropertyAnimation {
            id: increasePosition
            target: scrollBar
            property: "position"
            from: scrollBar.visualPosition
            to: scrollBar.visualPosition + scrollBar.stepValue
            duration: 300
            easing.type: Easing.Linear
        }

        // Animation for decrease position of scroll bar when change order apps
        // in menu
        PropertyAnimation {
            id: decreasePosition
            target: scrollBar
            property: "position"
            from: scrollBar.visualPosition
            to: scrollBar.visualPosition - scrollBar.stepValue
            duration: 300
            easing.type: Easing.Linear
        }
    }
    //------------------------------------------------------------------------//
    // End Scroll bar
    //------------------------------------------------------------------------//

    // Timer for scroll bar when change order apps in menu
    Timer {
        id: scrollTimer
        interval: 600
        repeat: true
        running: false
        onTriggered: Common.determineAnimation()
    }
}
