import QtQuick
import QtQuick.Templates as T
import bon

T.ScrollBar {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    padding: 4
    visible: control.policy !== T.ScrollBar.AlwaysOff && (control.policy === T.ScrollBar.AsNeeded ? control.size < 1 : true)
    minimumSize: orientation == Qt.Horizontal ? height / width : width / height

    property color _color: control.pressed ? __app__.style.palette.controls.background_1 : __app__.style.palette.controls.background
    property real _easing: __app__.style.animations.basic.type
    property real _duration: __app__.style.animations.basic.duration
    property real _elevation: 2
    property real _width: 4
    property real _radius: _width/2

    opacity: control.active ? 1 : 0.0
    Behavior on opacity {
        animation: NumberAnimation {
            duration: _duration;
            easing.type: _easing;
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
                duration: _duration;
                easing.type: _easing
            }
        }
    }
}
