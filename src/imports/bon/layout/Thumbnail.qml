import QtQuick
import Qt5Compat.GraphicalEffects
import bon as B

Rectangle {
    id: root

    property url source
    property bool _isInCard: parent?.parent?.parent?.parent?.parent?.parent instanceof B.Card;
    property var _card: _isInCard ? parent?.parent?.parent?.parent?.parent?.parent : undefined
    property bool asynchronous: true
    width: _isInCard ? _card.width : 100
    height: _isInCard ? width*(image.sourceSize.height/image.sourceSize.width) : 56
    implicitHeight: image.height
    radius: 4
    color: "transparent"

    Image {
        anchors.fill: parent
        id: image
        source: root.source
        visible: false
        mipmap: true
        asynchronous: root.asynchronous
        fillMode: Image.PreserveAspectCrop
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
