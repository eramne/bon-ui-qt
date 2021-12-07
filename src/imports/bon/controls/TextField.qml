import QtQuick
import QtQuick.Layouts
import bon

TextInputBase {
    id: root
    property string buttonIcon: ""

    Timer {
        interval: 1
        running: true
        repeat: false
        onTriggered: {
            var tmpTxt = field.text
            field.clear()
            field.insert(0,tmpTxt)
        }
    }

    _trailingIcons: Component {
        Row {
            visible: root.enabled
            spacing: 10
            Layout.alignment: Qt.AlignVCenter
            rightPadding: 0

            Icon {
                name: root.field.acceptableInput ? "done" : "close"
                color: root.field.acceptableInput ? Theme.palette.success : Theme.palette.error
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
