import QtQuick 2.13
import QtQuick.Controls 2.13
import Qt.labs.settings 1.1

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

   Item {
       id: mainSettingItem
       anchors {
           top: parent.top
           left: line.right
           right: parent.right
           bottom: parent.bottom
       }

       Rectangle {
           opacity: 0.8
           anchors.fill: parent

           gradient: Gradient {
               GradientStop { position: 0; color: "#2B2E30" }
               GradientStop { position: 0.5; color: "#121213" }
               GradientStop { position: 1; color: "#2B2E30" }
           }
       }

       Text {
           text: "\xB0C"
           font.pixelSize: 20
           color: "#FFFFFF"
           anchors {
               verticalCenter: unitSwitch.verticalCenter
               right: unitSwitch.left
               rightMargin: 10
           }
       }

       Switch {
           id: unitSwitch
           anchors.centerIn: parent
           checked: mainSettings.tempUnit === "F" ? true : false
           onPositionChanged: {
               if (position) {
                   mainSettings.tempUnit = "F"
                   mainSettings.outsideTemp = (weather.temp - 273.15) * 1.8 + 32
                   climateModel.setTempUnit(true)
               }
               else {
                   mainSettings.tempUnit = "C"
                   mainSettings.outsideTemp = weather.temp - 273.15
                   climateModel.setTempUnit(false)
               }
           }
       }

       Text {
           text: "\xB0F"
           font.pixelSize: 20
           color: "#FFFFFF"
           anchors {
               verticalCenter: unitSwitch.verticalCenter
               left: unitSwitch.right
               leftMargin: 10
           }
       }
   }

   Connections {
       target: root
   }
}
