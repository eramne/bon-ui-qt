import QtQuick
import QtQuick.Layouts
import bon as B

B.TextInputBase {
    id: root
    property string buttonIcon: ""

    _trailingIcons: Component {
        Row {
            visible: root.enabled
            spacing: 10
            Layout.alignment: Qt.AlignVCenter
            rightPadding: 0

            B.Icon {
                name: root.field.acceptableInput ? "done" : "close"
                color: root.field.acceptableInput ? B.Theme.palette.success : B.Theme.palette.error
                visible: !root.field.focus && root.showStatus ? true : false
            }

            B.SmallIconButton {
                id: iconButton
                icon.name: root.buttonIcon

                Component.onCompleted: {
                    onClicked.connect(root.iconClicked)
                }
            }
        }
    }
}
