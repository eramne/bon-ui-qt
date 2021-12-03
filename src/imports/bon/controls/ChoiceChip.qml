import QtQuick
import QtQuick.Layouts
import bon

Chip {
    id: root

    checkable: true

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
            opacity: root._textOpacity
        }

        Text {
            text: root.text
            Layout.alignment: Qt.AlignVCenter
            color: root._textColor
            font: Theme.text.label
            opacity: root._textOpacity
        }
    }
}
