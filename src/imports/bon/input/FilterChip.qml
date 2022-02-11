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
