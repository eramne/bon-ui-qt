import QtQuick
import QtQuick.Templates as T
import QtQuick.Shapes
import bon

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
    property real _elevation: 2
    property real _easing: __app__.style.animations.basic.type
    property real _duration: __app__.style.animations.basic.duration

    property real _indicatorDisplacement: 6
    property real _indicatorThickness: 4
    property color _indicatorColor: _backgroundColor
    property color _indicatorBackgroundColor: control.pressed ? __app__.style.palette.controls.background_1 : __app__.style.palette.controls.background
    property bool _willSnap: snapMode !== Slider.NoSnap
    property real _snapIndicatorSpacing: (stepSize*280)/(to - from) //spacing between dots in degrees. 280 is qt's dials' angle range: control.position 0 would be angle -140, control.position 1 would be 140
    property real _minSnapIndicatorDistance: 8 // in px
    property bool _shouldDisplaySnapIndicators: snapMode !== Slider.NoSnap && 2*Math.PI*(Math.max(width,height)+_indicatorDisplacement*2)*(_snapIndicatorSpacing/360) > _minSnapIndicatorDistance //converts the dot spacing to px using the circles circumference, tests whether that spacing is too short or not

    property bool showValue: false

    width: _width
    height: _height
    opacity: _opacity

    inputMode: Dial.Vertical

    Item {
        id: continuousIndicator
        visible: control.showValue && !_shouldDisplaySnapIndicators
        anchors.centerIn: parent
        width: parent.width + _indicatorDisplacement*2
        height: parent.height + _indicatorDisplacement*2

        layer.enabled: true
        layer.samples: 8

        Shape {
            id: continuousIndicatorBackground
            anchors.fill: parent

            property real start: 0.111
            property real end: 0.888

            ShapePath {
                startX: -Math.sin(continuousIndicatorBackground.start*2*Math.PI)*((continuousIndicatorBackground.width/2)-(_indicatorThickness/2)) + continuousIndicatorBackground.width/2;
                startY: Math.cos(continuousIndicatorBackground.start*2*Math.PI)*((continuousIndicatorBackground.height/2)-(_indicatorThickness/2)) + continuousIndicatorBackground.height/2;
                fillColor: "transparent"
                strokeColor: _indicatorBackgroundColor
                strokeWidth: _indicatorThickness
                capStyle: ShapePath.RoundCap

                Behavior on strokeColor {
                    ColorAnimation {
                        duration: _duration;
                        easing.type: _easing
                    }
                }

                PathArc {
                    x: -Math.sin(continuousIndicatorBackground.end*2*Math.PI)*((continuousIndicatorBackground.width/2)-(_indicatorThickness/2)) + continuousIndicatorBackground.width/2;
                    y: Math.cos(continuousIndicatorBackground.end*2*Math.PI)*((continuousIndicatorBackground.height/2)-(_indicatorThickness/2)) + continuousIndicatorBackground.height/2;
                    radiusX: continuousIndicatorBackground.width/2 - _indicatorThickness/2; radiusY: continuousIndicatorBackground.height/2 - _indicatorThickness/2
                    useLargeArc: true
                    direction: !useLargeArc ? PathArc.Counterclockwise : PathArc.Clockwise
                }
            }
        }

        Shape {
            id: continuousIndicatorForeground
            anchors.fill: parent

            property real start: 0.111
            property real end: (control.angle+180)/360

            ShapePath {
                startX: -Math.sin(continuousIndicatorForeground.start*2*Math.PI)*((continuousIndicatorForeground.width/2)-(_indicatorThickness/2)) + continuousIndicatorForeground.width/2;
                startY: Math.cos(continuousIndicatorForeground.start*2*Math.PI)*((continuousIndicatorForeground.height/2)-(_indicatorThickness/2)) + continuousIndicatorForeground.height/2;
                fillColor: "transparent"
                strokeColor: _indicatorColor
                strokeWidth: _indicatorThickness
                capStyle: ShapePath.RoundCap

                Behavior on strokeColor {
                    ColorAnimation {
                        duration: _duration;
                        easing.type: _easing
                    }
                }

                PathArc {
                    x: -Math.sin(continuousIndicatorForeground.end*2*Math.PI)*((continuousIndicatorForeground.width/2)-(_indicatorThickness/2)) + continuousIndicatorForeground.width/2;
                    y: Math.cos(continuousIndicatorForeground.end*2*Math.PI)*((continuousIndicatorForeground.height/2)-(_indicatorThickness/2)) + continuousIndicatorForeground.height/2;
                    radiusX: continuousIndicatorForeground.width/2 - _indicatorThickness/2; radiusY: continuousIndicatorForeground.height/2 - _indicatorThickness/2
                    useLargeArc: continuousIndicatorForeground.end - continuousIndicatorForeground.start > 0.5
                }
            }
        }
    }

    Item {
        id: snapIndicator
        visible: control.showValue && _shouldDisplaySnapIndicators
        anchors.centerIn: parent
        width: parent.width + _indicatorDisplacement*2
        height: parent.height + _indicatorDisplacement*2

        layer.enabled: true
        layer.samples: 8

        Repeater {
            model: _shouldDisplaySnapIndicators ? 1+Math.round((to-from)/stepSize) : 0
            Rectangle {
                id: dot
                width: _indicatorThickness
                height: _indicatorThickness
                x: snapIndicator.width/2 - width/2
                y: snapIndicator.height - height
                property real angle: 40 + index*_snapIndicatorSpacing
                visible: angle <= 360-40

                transform: Rotation {
                    origin.x: _indicatorThickness/2
                    origin.y: _indicatorThickness - snapIndicator.height/2
                    angle: dot.angle
                }

                color: angle <= (control.angle+180) ? _indicatorColor : _indicatorBackgroundColor
                radius: Math.max(width, height)/2

                Behavior on color {
                    ColorAnimation {
                        duration: _duration;
                        easing.type: _easing
                    }
                }
            }
        }
    }

    Elevation {
        anchors.fill: background
        radius: background.radius
        elevation: _elevation
        z: -1
    }

    background: Rectangle {
        implicitWidth: parent.width
        implicitHeight: parent.height
        radius: _radius
        color: _backgroundColor
        opacity: control.enabled ? 1 : 0.3

        Behavior on color {
            ColorAnimation {
                duration: _duration;
                easing.type: _easing
            }
        }
    }

    handle: Rectangle {
        x: control.background.x + control.background.width / 2 - width / 2
        y: control.background.y + control.background.height / 2 - height / 2
        width: _handleWidth
        height: _handleHeight
        color: _handleColor
        radius: Math.max(width,height)/2

        Behavior on color {
            ColorAnimation {
                duration: _duration;
                easing.type: _easing
            }
        }

        transform: [
            Translate {
                y: -8
            },
            Rotation {
                angle: control.angle
                origin.x: control.handle.width / 2
                origin.y: control.handle.height / 2

                Behavior on angle {
                    enabled: _willSnap
                    animation: NumberAnimation {
                        duration: _duration;
                        easing.type: _easing;
                    }
                }
            }
        ]
    }
}
