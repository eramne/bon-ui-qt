import QtQuick
import Qt5Compat.GraphicalEffects

Rectangle {
    id: root

    property string source
    width: 100
    height: 56
    radius: 4
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
