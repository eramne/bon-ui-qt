//TODO: add tooltip that shows value when the slider is pressed

import QtQuick
import QtQuick.Templates as T
import QtQuick.Layouts
import bon

T.Slider {
    id: root

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
    property color _backgroundOffColor: root.pressed ? Theme.palette.background_2 : Theme.palette.background_1
    property color _backgroundOnColor: root.enabled ? (
                                           root.pressed ? Theme.palette.accent_1 : Theme.palette.accent
                                       ) : Theme.palette.background_2
    property color _handleColor: _backgroundOnColor
    property real _snapIndicatorWidth: 4
    property real _snapIndicatorHeight: 4
    property real _minSnapIndicatorDistance: 8
    property bool _willSnap: snapMode !== Slider.NoSnap && (stepSize*(horizontal ? stepIndicators.width : stepIndicators.height))/(to - from) > 1
    property real _snapIndicatorSpacing: (stepSize*(horizontal ? stepIndicators.width : stepIndicators.height))/(to - from) - (horizontal ? _snapIndicatorWidth : _snapIndicatorHeight)
    property bool _shouldDisplaySnapIndicators: snapMode !== Slider.NoSnap && _snapIndicatorSpacing > _minSnapIndicatorDistance

    padding: 0

    opacity: !root.enabled ? Theme.disabled_opacity : 1
    layer.enabled: !root.enabled

    width: horizontal ? 100 : Math.max(_backgroundWidth,_handleLength)
    height: horizontal ? Math.max(_backgroundHeight,_handleLength) : 100

    Grid {
        id: stepIndicators
        visible: _shouldDisplaySnapIndicators
        x: root.horizontal ? _handleWidth/2 - _snapIndicatorWidth/2 : 0
        y: root.horizontal ? root.height - height : height+(_handleHeight/2 + _snapIndicatorHeight/2)
        z: -1
        width: root.horizontal ? _backgroundWidth -_handleWidthSnap : _snapIndicatorWidth
        height: root.horizontal ? _snapIndicatorHeight : _backgroundHeight -_handleWidthSnap
        spacing: _snapIndicatorSpacing
        property int count: _shouldDisplaySnapIndicators ? 1+Math.round((to-from)/stepSize) : 0
        rows: root.horizontal ? 0 : count
        columns: root.horizontal ? count : 0
        scale: root.horizontal ? 1 : -1
        transformOrigin: Item.Top

        Repeater {
            id: stepIndicatorRepeater
            model: parent.count

            Rectangle {
                width: _snapIndicatorWidth
                height: _snapIndicatorHeight
                radius: Math.max(width, height)/2
                color: Theme.palette.background_1
                visible: root.horizontal ? x < stepIndicators.width + _snapIndicatorWidth : y < stepIndicators.height + _snapIndicatorHeight
            }
        }
    }

    Elevation {
        anchors.fill: handle
        radius: handle.radius
        elevation: root.pressed ? 1 : 2
        z: -1
    }

    handle: Rectangle {
        x: root.leftPadding + (root.horizontal ? root.visualPosition * (root.availableWidth - width) : (root.availableWidth - width) / 2)
        y: root.topPadding + (root.horizontal ? (root.availableHeight - height) / 2 : root.visualPosition * (root.availableHeight - height))
        implicitWidth: _handleWidth
        implicitHeight: _handleHeight
        radius: width / 2
        color: _handleColor

        Behavior on color {
            ColorAnimation {
                duration: Theme.animations.basic.duration
                easing.type: Theme.animations.basic.type
            }
        }

        Behavior on x {
            animation: NumberAnimation {
                duration: Theme.animations.basic.duration
                easing.type: Theme.animations.basic.type
            }
        }

        Behavior on y {
            animation: NumberAnimation {
                duration: Theme.animations.basic.duration
                easing.type: Theme.animations.basic.type
            }
        }

        Rectangle {
            id: highlight
            x: parent.width/2 - width/2
            y: parent.height/2 - height/2
            width: _highlightWidth
            height: _highlightHeight
            radius: width / 2
            color: root.pressed || root.hovered || !root.enabled ? Theme.palette.highlight_1 : Theme.palette.highlight

            Behavior on color {
                ColorAnimation {
                    duration: Theme.animations.basic.duration
                    easing.type: Theme.animations.basic.type
                }
            }
        }
    }

    background: Rectangle {
        x: root.leftPadding + (root.horizontal ? 0 : (root.availableWidth - width) / 2)
        y: root.topPadding + (root.horizontal ? (root.availableHeight - height) / 2 : 0)
        implicitWidth: _backgroundWidth
        implicitHeight: _backgroundHeight
        width: root.horizontal ? root.availableWidth : implicitWidth
        height: root.horizontal ? implicitHeight : root.availableHeight
        radius: _backgroundRadius
        color: _backgroundOffColor
        scale: root.horizontal && root.mirrored ? -1 : 1

        Behavior on color {
            ColorAnimation {
                duration: Theme.animations.basic.duration
                easing.type: Theme.animations.basic.type
            }
        }

        Elevation {
            anchors.fill: indicator
            radius: indicator.radius
            elevation: 1
            z: -1
        }

        Rectangle {
            id: indicator
            y: root.horizontal ? 0 : root.handle.y + root.handle.height/2
            width: root.horizontal ? root.handle.x + root.handle.width/2 : parent.width
            height: root.horizontal ? parent.height : root.height - y

            radius: _backgroundRadius
            color: _backgroundOnColor
        }
    }
}
