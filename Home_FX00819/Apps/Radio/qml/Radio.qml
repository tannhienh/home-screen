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
           orientation: Gradient.Horizontal
           GradientStop { position: 0; color: "#2B2E30" }
           GradientStop { position: 1; color: "#4A4A4A" }
       }
    }

   Rectangle {
       id: line
       width: 3
       color: "#5D6164"
       anchors {
           top: parent.top
           left: menuSettings.right
           bottom: parent.bottom
       }
   }
}
