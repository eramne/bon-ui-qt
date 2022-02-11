import QtQuick
import QtQuick.Layouts
import bon as B

B.Chip {
    id: root

    checkable: true

    icon.name: ""

    contentItem: RowLayout {
        anchors.centerIn: root
        spacing: 5
        height: root.height
        width: Layout.minimumWidth

        B.Icon {
            id: icon
            Layout.alignment: Qt.AlignCenter
            visible: isValid
            name: root.icon.name
            dark: root.checked
            opacity: root._textOpacity
        }

        B.LabelText {
            text: root.text
            Layout.alignment: Qt.AlignVCenter
            dark: root.checked
            opacity: root._textOpacity
        }
    }
}
