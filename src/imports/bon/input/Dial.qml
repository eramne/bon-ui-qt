import QtQuick
import QtQuick.Templates as T
import QtQuick.Shapes
import bon as B

T.Dial {
    id: root

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    property real _indicatorDisplacement: 6
    property real _indicatorThickness: 4
    property color _foregroundColor: root.pressed ? B.Theme.palette.accent_1 : B.Theme.palette.accent
    property color _backgroundColor: root.pressed ? B.Theme.palette.background_2 : B.Theme.palette.background_1
    property bool _willSnap: snapMode !== Slider.NoSnap
    property real _snapIndicatorSpacing: (stepSize*280)/(to - from) //spacing between dots in degrees. 280 is qt's dials' angle range: control.position 0 would be angle -140, control.position 1 would be 140
    property real _minSnapIndicatorDistance: 8 // in px
    property bool _shouldDisplaySnapIndicators: snapMode !== Slider.NoSnap && 2*Math.PI*(Math.max(width,height)+_indicatorDisplacement*2)*(_snapIndicatorSpacing/360) > _minSnapIndicatorDistance //converts the dot spacing to px using the circles circumference, tests whether that spacing is too short or not

    property bool showValue: false

    width: 40
    height: 40
    opacity: !root.enabled ? B.Theme.disabled_opacity : 1

    inputMode: Dial.Vertical

    Item {
        id: continuousIndicator
        visible: root.showValue && !_shouldDisplaySnapIndicators
        anchors.centerIn: parent
        width: parent.width + root._indicatorDisplacement*2
        height: parent.height + root._indicatorDisplacement*2

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
                strokeColor: root._backgroundColor
                strokeWidth: _indicatorThickness
                capStyle: ShapePath.RoundCap

                Behavior on strokeColor {
                    ColorAnimation {
                        duration: B.Theme.animations.basic.duration
                        easing.type: B.Theme.animations.basic.type
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
            property real end: (root.angle+180)/360

            ShapePath {
                startX: -Math.sin(continuousIndicatorForeground.start*2*Math.PI)*((continuousIndicatorForeground.width/2)-(_indicatorThickness/2)) + continuousIndicatorForeground.width/2;
                startY: Math.cos(continuousIndicatorForeground.start*2*Math.PI)*((continuousIndicatorForeground.height/2)-(_indicatorThickness/2)) + continuousIndicatorForeground.height/2;
                fillColor: "transparent"
                strokeColor: root._foregroundColor
                strokeWidth: _indicatorThickness
                capStyle: ShapePath.RoundCap

                Behavior on strokeColor {
                    ColorAnimation {
                        duration: B.Theme.animations.basic.duration
                        easing.type: B.Theme.animations.basic.type
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
        visible: root.showValue && _shouldDisplaySnapIndicators
        anchors.centerIn: parent
        width: parent.width + root._indicatorDisplacement*2
        height: parent.height + root._indicatorDisplacement*2

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

                color: angle <= (root.angle+180) ? root._foregroundColor : root._backgroundColor
                radius: Math.max(width, height)/2

                Behavior on color {
                    ColorAnimation {
                        duration: B.Theme.animations.basic.duration
                        easing.type: B.Theme.animations.basic.type
                    }
                }
            }
        }
    }

    B.Elevation {
        anchors.fill: background
        radius: background.radius
        elevation: 2
        z: -1
    }

    background: Rectangle {
        implicitWidth: parent.width
        implicitHeight: parent.height
        radius: Math.max(width, height)
        color: root._foregroundColor
        opacity: root.enabled ? 1 : 0.3

        Behavior on color {
            ColorAnimation {
                duration: B.Theme.animations.basic.duration
                easing.type: B.Theme.animations.basic.type
            }
        }
    }

    handle: Rectangle {
        x: root.background.x + root.background.width / 2 - width / 2
        y: root.background.y + root.background.height / 2 - height / 2
        width: 8
        height: 8
        color: root.enabled ? (
                   root.pressed || root.hovered ? B.Theme.palette.highlight_1 : B.Theme.palette.highlight
               ) : B.Theme.palette.highlight_1
        radius: Math.max(width,height)/2

        Behavior on color {
            ColorAnimation {
                duration: B.Theme.animations.basic.duration
                easing.type: B.Theme.animations.basic.type
            }
        }

        transform: [
            Translate {
                y: -8
            },
            Rotation {
                angle: root.angle
                origin.x: root.handle.width / 2
                origin.y: root.handle.height / 2

                Behavior on angle {
                    enabled: _willSnap
                    animation: NumberAnimation {
                        duration: B.Theme.animations.basic.duration
                        easing.type: B.Theme.animations.basic.type
                    }
                }
            }
        ]
    }
}
