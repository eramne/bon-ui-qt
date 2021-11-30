import QtQuick 2.0
import QtQuick.Layouts
import bon as Bon

Chip {
    id: root

    checkable: true

    icon.name: ""

    contentItem: RowLayout {
        anchors.centerIn: root
        spacing: 5
        height: root.height
        width: Layout.minimumWidth

        Bon.Icon {
            id: icon
            Layout.alignment: Qt.AlignCenter
            visible: isValid
            name: root.icon.name
            color: root.icon.color
            opacity: _textOpacity
        }

        Text {
            text: root.text
            Layout.alignment: Qt.AlignVCenter
            color: _textColor
            font: __app__.style.text.label
            opacity: _textOpacity
        }
    }
}
