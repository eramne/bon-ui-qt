import QtQuick
import QtQuick.Templates as T
import QtQuick.Layouts
import bon

T.Slider {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitHandleWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitHandleHeight + topPadding + bottomPadding)

    property real _backgroundWidth: horizontal ? width : 8
    property real _backgroundHeight: horizontal ? 8 : height
    property real _handleWidthCont: 20
    property real _handleWidthSnap: 16
    property real _handleLength: 20
    property real _handleWidth: horizontal ? (_willSnap ? _handleWidthSnap : _handleWidthCont) : _handleLength
    property real _handleHeight: horizontal ?  _handleLength : (_willSnap ? _handleWidthSnap : _handleWidthCont)
    property real _highlightWidth: horizontal ? (_willSnap ? 4 : 8) : 8
    property real _highlightHeight: horizontal ? 8 : (_willSnap ? 4 : 8)
    property real _backgroundRadius: 4
    property real _padding: 0
    property color _backgroundOffColor: control.pressed ? __app__.style.palette.controls.background_1 : __app__.style.palette.controls.background
    property color _backgroundOnColor: control.enabled ? (
                                           control.pressed ? __app__.style.palette.controls.accent_1 : __app__.style.palette.controls.accent
                                       ) : __app__.style.palette.controls.background_1
    property color _handleColor: _backgroundOnColor
    property color _highlightColor: control.pressed || control.hovered || !control.enabled ? __app__.style.palette.controls.highlight_1 : __app__.style.palette.controls.highlight
    property real _opacity: !control.enabled ? __app__.style.misc_values.disabled_opacity : 1
    property real _elevation: 1
    property real _handleElevation: control.pressed ? 1 : 2
    property real _easing: __app__.style.animations.basic.type
    property real _duration: __app__.style.animations.basic.duration
    property real _snapIndicatorWidth: 4
    property real _snapIndicatorHeight: 4
    property color _snapIndicatorColor: __app__.style.palette.controls.background
    property real _minSnapIndicatorDistance: 8
    property bool _willSnap: snapMode !== Slider.NoSnap && (stepSize*(horizontal ? stepIndicators.width : stepIndicators.height))/(to - from) > 1
    property real _snapIndicatorSpacing: (stepSize*(horizontal ? stepIndicators.width : stepIndicators.height))/(to - from) - (horizontal ? _snapIndicatorWidth : _snapIndicatorHeight)
    property bool _shouldDisplaySnapIndicators: snapMode !== Slider.NoSnap && _snapIndicatorSpacing > _minSnapIndicatorDistance

    padding: _padding

    opacity: _opacity
    layer.enabled: !control.enabled

    width: horizontal ? 100 : Math.max(_backgroundWidth,_handleLength)
    height: horizontal ? Math.max(_backgroundHeight,_handleLength) : 100

    Grid {
        id: stepIndicators
        visible: _shouldDisplaySnapIndicators
        x: control.horizontal ? _handleWidth/2 - _snapIndicatorWidth/2 : 0
        y: control.horizontal ? control.height - height : height+(_handleHeight/2 + _snapIndicatorHeight/2)
        z: -1
        width: control.horizontal ? _backgroundWidth -_handleWidthSnap : _snapIndicatorWidth
        height: control.horizontal ? _snapIndicatorHeight : _backgroundHeight -_handleWidthSnap
        spacing: _snapIndicatorSpacing
        property int count: _shouldDisplaySnapIndicators ? 1+Math.round((to-from)/stepSize) : 0
        rows: control.horizontal ? 0 : count
        columns: control.horizontal ? count : 0
        scale: control.horizontal ? 1 : -1
        transformOrigin: Item.Top

        Repeater {
            id: stepIndicatorRepeater
            model: parent.count

            Rectangle {
                width: _snapIndicatorWidth
                height: _snapIndicatorHeight
                radius: Math.max(width, height)/2
                color: _snapIndicatorColor
                visible: control.horizontal ? x < stepIndicators.width + _snapIndicatorWidth : y < stepIndicators.height + _snapIndicatorHeight
            }
        }
    }

    Elevation {
        anchors.fill: handle
        radius: handle.radius
        elevation: _handleElevation
        z: -1
    }

    handle: Rectangle {
        x: control.leftPadding + (control.horizontal ? control.visualPosition * (control.availableWidth - width) : (control.availableWidth - width) / 2)
        y: control.topPadding + (control.horizontal ? (control.availableHeight - height) / 2 : control.visualPosition * (control.availableHeight - height))
        implicitWidth: _handleWidth
        implicitHeight: _handleHeight
        radius: width / 2
        color: _handleColor

        Behavior on color {
            ColorAnimation {
                duration: _duration;
                easing.type: _easing
            }
        }

        Behavior on x {
            animation: NumberAnimation {
                duration: _duration;
                easing.type: _easing;
            }
        }

        Behavior on y {
            animation: NumberAnimation {
                duration: _duration;
                easing.type: _easing;
            }
        }

        Rectangle {
            id: highlight
            x: parent.width/2 - width/2
            y: parent.height/2 - height/2
            width: _highlightWidth
            height: _highlightHeight
            radius: width / 2
            color: _highlightColor

            Behavior on color {
                ColorAnimation {
                    duration: _duration;
                    easing.type: _easing
                }
            }
        }
    }

    background: Rectangle {
        x: control.leftPadding + (control.horizontal ? 0 : (control.availableWidth - width) / 2)
        y: control.topPadding + (control.horizontal ? (control.availableHeight - height) / 2 : 0)
        implicitWidth: _backgroundWidth
        implicitHeight: _backgroundHeight
        width: control.horizontal ? control.availableWidth : implicitWidth
        height: control.horizontal ? implicitHeight : control.availableHeight
        radius: _backgroundRadius
        color: _backgroundOffColor
        scale: control.horizontal && control.mirrored ? -1 : 1

        Behavior on color {
            ColorAnimation {
                duration: _duration;
                easing.type: _easing
            }
        }

        Elevation {
            anchors.fill: indicator
            radius: indicator.radius
            elevation: _elevation
            z: -1
        }

        Rectangle {
            id: indicator
            y: control.horizontal ? 0 : control.handle.y + control.handle.height/2
            width: control.horizontal ? control.handle.x + control.handle.width/2 : parent.width
            height: control.horizontal ? parent.height : control.height - y

            radius: _backgroundRadius
            color: _backgroundOnColor
        }
    }
}
