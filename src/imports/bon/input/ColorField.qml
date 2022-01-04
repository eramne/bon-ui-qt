import QtQuick
import bon as B

B.ColorSwatch {
    checkable: false
    onClicked: {
        colorPopup.open();
    }

    color: colorPopup.editColor
    property alias currentColor: colorPopup.color
    property alias editColor: colorPopup.editColor

    B.ColorPicker {
        id: colorPopup
    }
}
