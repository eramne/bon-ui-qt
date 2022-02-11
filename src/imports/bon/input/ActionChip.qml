import QtQuick
import QtQuick.Layouts
import bon as B

B.Chip {
    id: root

    checkable: false

    icon.name: ""

    contentItem: RowLayout {
        anchors.centerIn: root
        spacing: 5
        height: root.height
        width: Layout.minimumWidth

        B.Icon {
            id: icon
            Layout.alignment: Qt.AlignCenter
            dark: root.checked
            visible: isValid
            name: root.icon.name
            opacity: root._textOpacity
        }

        B.LabelText {
            text: root.text
            dark: root.checked
            Layout.alignment: Qt.AlignVCenter
            opacity: root._textOpacity
        }
    }
}
