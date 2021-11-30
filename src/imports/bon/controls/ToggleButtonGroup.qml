import QtQuick 2.0
import Qt5Compat.GraphicalEffects

Item {
    id: root
    width: buttonRow.width
    height: buttonRow.height
    default property alias buttons: buttonRow.children

    property real _radius: 8

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
        radius: _radius
        color: "black"
    }
}
