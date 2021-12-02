import QtQuick
import QtQuick.Layouts
import bon

Chip {
    id: root

    checkable: false

    icon.name: ""

    contentItem: RowLayout {
        anchors.centerIn: root
        spacing: 5
        height: root.height
        width: Layout.minimumWidth

        Icon {
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
            color: Theme.palette.text.label
            font: Theme.text.label
            opacity: _textOpacity
        }
    }
}
