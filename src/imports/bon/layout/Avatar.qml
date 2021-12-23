import QtQuick
import Qt5Compat.GraphicalEffects

Rectangle {
    id: root

    property string source
    width: 40
    height: 40
    radius: Math.max(width, height)/2
    color: "transparent"

    Image {
        anchors.fill: parent
        id: image
        source: root.source
        visible: false
        mipmap: true
    }

    Rectangle {
        id: maskRect
        anchors.fill: parent
        color: "black"
        radius: parent.radius
    }

    ShaderEffectSource {
        id: maskRectSource
        anchors.fill: maskRect
        sourceItem: maskRect
        hideSource: true
        visible: false
    }

    OpacityMask {
        anchors.fill: image
        source: image
        maskSource: maskRectSource
    }
}
