import QtQuick 2.13
import QtQuick.Controls 2.13
import Qt.labs.settings 1.1

ApplicationWindow {
    id: root

    // Screen Full HD 1920x1080 pixel
    visible: true
    visibility: "FullScreen"

    // Display demension for debug
//            width: 1920
//            height: 779

    title: qsTr("Home Screen")

    property bool shuffleGlobal: false
    property int loopGlobal: 0

    //------------------------------------------------------------------------//
    // Load Fonts from attached resource fonts.qrc

    // Font Cantarell
    FontLoader {
        id: cantarell
        source: "qrc:/Fonts/Cantarell-Regular.ttf"
    }

    // Font FiraSans
    FontLoader {
        id: firaSans
        source: "qrc:/Fonts/FiraSans-Regular.ttf"
    }

    // Font Helvetica
    FontLoader {
        id: helvetica
        source: "qrc:/Fonts/Helvetica-Neue-Regular.ttf"
    }

    // Font Ubuntu
    FontLoader {
        id: ubuntu
        source: "qrc:/Fonts/Ubuntu-Regular.ttf"
    }
    //------------------------------------------------------------------------//

    Settings {
        id: mainSettings
        property string tempUnit: "F"
        property int outsideTemp
    }

    // Background Image
    // 1920x1080
    Image {
        id: bgImage
        source: "qrc:/Images/Home/home_bg.png"
        anchors.fill: parent

        // Hide virtual Keyboard
        MouseArea {
            anchors.fill: parent
            onClicked: {
                focus = true
            }
        }
    }

    FocusScope {

        anchors.fill: parent

        // Status bar
        // width: 1920
        // height: 85
        StatusBar {
            id: statusBar

            height: 85
            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
            }

            // Click Back button to go Home screen when opening an application
            onBackButtonClicked: mainAreaStackView.pop()

            // Show back button when open an application on status bar
            isShowBackButton: mainAreaStackView.depth == 1 ? false : true

            KeyNavigation.down: mainAreaStackView
        }

        /**
        * Stack view Main Area
        * Main area: include Widgets area and Menu area
        * also Application area
        *
        * When open an application, corresponding application
        * was push into main area
        *
        * with: 1920
        * height: 995
        */
        StackView {
            id: mainAreaStackView
            initialItem: MainArea {}
            anchors {
                top: statusBar.bottom
                left: parent.left
                right: parent.right
                bottom: parent.bottom
            }

            onFocusChanged: {
                console.log("mainAreaStackView.focus changed: " + mainAreaStackView.focus)
            }

            KeyNavigation.up: statusBar

            onCurrentItemChanged: {
                currentItem.forceActiveFocus()
            }

            pushExit: Transition {
                PropertyAnimation {
                    property: "x"
                    from: 0
                    to: -1920
                    duration: 500
                    easing.type: Easing.OutQuad
                }
            }

            pushEnter: Transition {
                PropertyAnimation {
                    property: "x"
                    from: 1920
                    to: 0
                    duration: 500
                    easing.type: Easing.OutQuad
                }
            }

            popExit: Transition {
                PropertyAnimation {
                    property: "x"
                    from: 0
                    to: 1920
                    duration: 500
                    easing.type: Easing.OutQuad
                }
            }

            popEnter: Transition {
                PropertyAnimation {
                    property: "x"
                    from: -1920
                    to: 0
                    duration: 500
                    easing.type: Easing.OutQuad
                }
            }
        }
    }
}
