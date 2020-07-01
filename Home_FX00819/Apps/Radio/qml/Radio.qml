import QtQuick 2.13
import QtQuick.Controls 2.13

Item {
    id: radioApp

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

    // 4 = width vertical line on right side phone contacts area
    WishlistChanel {
        id: wishlistChanel
        width: (parent.width / 3) + 4
        topMargin: 85
        visible: true
        height: parent.height - 85
    }

    // Radio player area
    RadioPlayer {
        width: parent.width - wishlistChanel.width - 80
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
            wishlistChanel.close()
        }
    }
}
