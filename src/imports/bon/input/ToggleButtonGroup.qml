import QtQuick
import Qt5Compat.GraphicalEffects

Item {
    id: root
    width: buttonRow.width
    height: buttonRow.height
    default property alias buttons: buttonRow.children

    Row {
        id: buttonRow

        layer.enabled: true
        layer.effect: OpacityMask {
            maskSource: maskRectSource
        }
    }

    ShaderEffectSource {
        id: maskRectSource
        visible: false
        sourceItem: mask
        hideSource: true
        anchors.fill: mask
    }

    Rectangle {
        id: mask
        anchors.fill: parent
        radius: 8
        color: "black"
    }
}
