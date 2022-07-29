import QtQuick
import QtQuick.Layouts
import QtQuick.Templates as T
import bon as B

T.Control {
    id: root
    default property alias options: list.children
    property bool exclusive: false
    property alias group: buttonGroup
    height: list.implicitHeight
    padding: 10

    opacity: !root.enabled ? B.Theme.disabled_opacity : 1
    layer.enabled: !root.enabled
    hoverEnabled: root.enabled

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
