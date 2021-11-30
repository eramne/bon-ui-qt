import QtQuick 2.0
import QtQuick.Layouts
import bon as Bon

Chip {
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

        SmallIconButton {
            offIcon: "cancel"
            Component.onCompleted: {
                onClicked.connect(root.closed)
            }
        }
    }
}
