import QtQuick
import QtQuick.Layouts
import bon

TextInputBase {
    id: root
    property string buttonIcon: ""

    _trailingIcons: Component {
        Row {
            visible: root.enabled
            spacing: 10
            Layout.alignment: Qt.AlignVCenter
            rightPadding: 0

            Icon {
                name: root.field.acceptableInput ? "done" : "close"
                color: root.field.acceptableInput ? __app__.style.palette.success : __app__.style.palette.error
                visible: !root.field.focus && root.showStatus ? true : false
            }

            SmallIconButton {
                id: iconButton
                offIcon: root.buttonIcon

                Component.onCompleted: {
                    onClicked.connect(root.iconClicked)
                }
            }
        }
    }
}
