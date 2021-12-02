import QtQuick
import QtQuick.Templates as T
import bon

T.ScrollBar {
    id: root

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    padding: 4
    visible: root.policy !== T.ScrollBar.AlwaysOff && (root.policy === T.ScrollBar.AsNeeded ? root.size < 1 : true)
    minimumSize: orientation == Qt.Horizontal ? height / width : width / height

    property color _color: root.pressed ? Theme.palette.background_2 : Theme.palette.background_1
    property real _elevation: 2
    property real _width: 4
    property real _radius: _width/2

    opacity: root.active ? 1 : 0.0
    Behavior on opacity {
        animation: NumberAnimation {
            duration: Theme.animations.basic.duration
            easing.type: Theme.animations.basic.type
        }
    }
    layer.enabled: opacity < 1

    Elevation {
        anchors.fill: contentItem
        radius: contentItem.radius
        elevation: _elevation
        z: -1
    }

    contentItem: Rectangle {
        implicitWidth: _width
        implicitHeight: _width

        radius: _radius
        color: _color


        Behavior on color {
            ColorAnimation {
                duration: Theme.animations.basic.duration
                easing.type: Theme.animations.basic.type
            }
        }
    }
}
