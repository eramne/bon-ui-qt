import QtQuick
import QtQuick.Layouts
import bon

TextInputBase {
    id: control
    property string buttonIcon: ""

    _trailingIcons: Component {
        Row {
            visible: control.enabled
            spacing: 10
            Layout.alignment: Qt.AlignVCenter
            rightPadding: 0

            Icon {
                name: control.field.acceptableInput ? "done" : "close"
                color: control.field.acceptableInput ? __app__.style.palette.success : __app__.style.palette.error
                visible: !control.field.focus && control.showStatus ? true : false
            }

            SmallIconButton {
                id: iconButton
                offIcon: control.buttonIcon

                Component.onCompleted: {
                    onClicked.connect(control.iconClicked)
                }
            }
        }
    }
}
