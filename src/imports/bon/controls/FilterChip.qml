import QtQuick 2.0
import QtQuick.Layouts
import bon as Bon

Chip {
    id: control

    checkable: true

    icon.name: checked ? "check" : ""

    Behavior on implicitWidth {
        NumberAnimation {
            duration: _duration;
            easing.type: _easing
        }
    }

    contentItem: RowLayout {
        anchors.centerIn: control
        spacing: 5
        height: control.height
        width: Layout.minimumWidth
        clip: true

        Bon.Icon {
            id: icon
            Layout.alignment: Qt.AlignCenter
            visible: isValid
            name: control.icon.name
            color: control.icon.color
            opacity: _textOpacity
        }

        Text {
            text: control.text
            Layout.alignment: Qt.AlignVCenter
            color: _textColor
            font: __app__.style.text.label
            opacity: _textOpacity
        }
    }
}
