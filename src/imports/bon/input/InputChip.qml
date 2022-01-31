import QtQuick
import QtQuick.Layouts
import bon as B

B.Chip {
    id: root

    checkable: false

    leftPadding: 10
    rightPadding: 5

    icon.name: ""

    signal closed()

    contentItem: RowLayout {
        anchors.verticalCenter: root.verticalCenter
        x: root.leftPadding
        spacing: 5
        height: root.height
        width: Layout.minimumWidth

        B.Icon {
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
            font: B.Theme.text.label
            opacity: root._textOpacity
        }

        B.SmallIconButton {
            offIcon: "cancel"
            Component.onCompleted: {
                onClicked.connect(root.closed)
            }
        }
    }
}