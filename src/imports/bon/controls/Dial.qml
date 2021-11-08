import QtQuick 2.0
import QtQuick.Templates as T

T.Dial {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    property real _width: 40
    property real _height: 40
    property real _radius: Math.max(_width, _height)
    property color _backgroundColor: control.pressed ? __app__.style.palette.controls.accent_1 : __app__.style.palette.controls.accent
    property real _opacity: !control.enabled ? __app__.style.misc_values.disabled_opacity : 1
    property real _handleWidth: 8
    property real _handleHeight: 8
    property color _handleColor: control.enabled ? (
                                           control.pressed || control.hovered ? __app__.style.palette.controls.highlight_1 : __app__.style.palette.controls.highlight
                                    ) : __app__.style.palette.controls.highlight_1

    width: _width
    height: _height
    layer.enabled: true
    opacity: _opacity

    inputMode: Dial.Vertical

    background: Rectangle {
        implicitWidth: parent.width
        implicitHeight: parent.height
        radius: _radius
        color: _backgroundColor
        opacity: control.enabled ? 1 : 0.3
    }

    handle: Rectangle {
        x: control.background.x + control.background.width / 2 - width / 2
        y: control.background.y + control.background.height / 2 - height / 2
        width: _handleWidth
        height: _handleHeight
        color: _handleColor
        radius: Math.max(width,height)/2
        transform: [
            Translate {
                y: -8
            },
            Rotation {
                angle: control.angle
                origin.x: control.handle.width / 2
                origin.y: control.handle.height / 2
            }
        ]
    }
}
