import QtQuick
import QtQuick.Layouts
import QtQuick.Templates as T
import bon as B

T.AbstractButton {
    id: root;
    required property string name
    property bool enabled: true
    property bool exclusive: parent.exclusive ?? false
    property T.AbstractButton button: buttonLoader.item

    implicitWidth: parent.width
    height: layout.implicitHeight

    onCheckedChanged: {
        if (buttonLoader.status === Loader.Ready) {
            button.checked = checked;
        } else {
            buttonLoader.loaded.connect(function () {
                button.checked = checked;
            });
        }
    }

    onClicked: {
        if (enabled) { toggle() }
    }

    onDoubleClicked: {
        if (enabled) { toggle() }
    }

    contentItem: RowLayout {
        id: layout

        Text {
            id: label
            text: root.name
            font: B.Theme.text.label
            color: B.Theme.palette.text.label
            Layout.alignment: Qt.AlignLeft
            opacity: root.enabled ? 1 : B.Theme.disabled_opacity
        }

        Loader {
            id: buttonLoader
            sourceComponent: root.exclusive ? radio : check
            Layout.alignment: Qt.AlignRight
        }
    }

    Component {
        id: check

        B.CheckBox {
            id: button
            enabled: root.enabled

            onCheckedChanged: {
                root.checked = checked;
            }
        }
    }

    Component {
        id: radio

        B.RadioButton {
            id: button
            enabled: root.enabled

            onCheckedChanged: {
                root.checked = checked;
            }
        }
    }
}
