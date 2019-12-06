import QtQuick 2.13

MouseArea {
    property string icon_default: ""    // Source icon when state is default
    property string icon_pressed: ""    // Source icon when state is pressed
    property string icon_released: ""   // Source icon when state is release
    property alias source_default: image.source // Source default alias of image
    property alias image: image
    property bool status        // Status of button
//    property variant m_width    // Width visual of button
//    property variant m_height   // Height visual of button

    // When event pressed emitted, change source image to icon_pressed
    onPressed: image.source = icon_pressed

    // When event released emitted, change source image to icon_released
    onReleased: image.source = icon_released

    implicitWidth: image.width      // Implicit with of mouse area
    implicitHeight: image.height    // Implicit height of mouse are

    // image icon of button
    Image {
        id: image
        source: icon_default
    }
}
