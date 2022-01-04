import QtQuick
import QtQuick.Layouts
import QtQuick.Templates as T

T.Control {
    id: root
    default property alias options: list.children
    property bool exclusive: false
    property alias group: buttonGroup
    property T.AbstractButton checkedButton: buttonGroup.checkedButton
    height: list.implicitHeight
    padding: 10

    T.ButtonGroup {
        id: buttonGroup
        buttons: options
        exclusive: root.exclusive
    }

    ColumnLayout {
        id: list
        width: parent.width
        property bool exclusive: root.exclusive
        spacing: 10
    }
}
