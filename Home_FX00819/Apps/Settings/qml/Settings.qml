import QtQuick 2.13

Item {
    id: settingsId

   Rectangle {
       id: menuSettings
       width: parent.width / 3
       opacity: 0.8
       anchors {
           top: parent.top
           left: parent.left
           bottom: parent.bottom
       }

       gradient: Gradient {
           GradientStop { position: 0; color: "#121212" }
           GradientStop { position: 0.2; color: "#2B2E30" }
           GradientStop { position: 1; color: "#000000" }
       }
    }

   Rectangle {
       id: line
       width: 2
       color: "#5D6164"
       opacity: 0.8
       anchors {
           top: parent.top
           left: menuSettings.right
           bottom: parent.bottom
       }
   }
}
