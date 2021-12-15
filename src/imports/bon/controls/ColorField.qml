import QtQuick
import bon

ColorSwatch {
    checkable: false
    onClicked: {
        colorPopup.open();
    }

    color: colorPopup.editColor
    property alias currentColor: colorPopup.color
    property alias editColor: colorPopup.editColor

    ColorPicker {
        id: colorPopup
    }
}
