import QtQuick
import QtQuick.Layouts
import bon as B

B.Chip {
    id: root

    checkable: true

    icon.name: checked ? "check" : ""

    Behavior on implicitWidth {
        NumberAnimation {
            duration: B.Theme.animations.basic.duration
            easing.type: B.Theme.animations.basic.type
        }
    }

    contentItem: RowLayout {
        anchors.centerIn: root
        spacing: 5
        height: root.height
        width: Layout.minimumWidth
        clip: true

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
    }
}
