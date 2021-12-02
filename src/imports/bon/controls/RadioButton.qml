import QtQuick
import QtQuick.Templates as T
import bon

T.RadioButton {
    id: root

    implicitWidth: indicator.width + leftPadding + rightPadding
    implicitHeight: indicator.height + topPadding + bottomPadding

    property bool mixed: false
    hoverEnabled: enabled
    property int effectiveState: mixed ? -1 : root.checked //0 = off, 1 = on, -1 = mixed

    onClicked: function () {
        mixed = false;
    }

    property real _width: 20
    property real _height: 20
    property real _radius: Math.max(_width, _height)
    property color _backgroundColor: root.effectiveState === 0 ? (
                                         root.down ? Theme.palette.background_2 : Theme.palette.background_1
                                     ) : root.effectiveState === 1  ? (
                                         root.down ? Theme.palette.accent_1 : Theme.palette.accent
                                     ) : (
                                         root.down ? Theme.palette.accent : Theme.palette.accent_1
                                     )
    property color _borderColor: "#000000"
    property real _borderWidth: 0
    property real _iconWidth: root.effectiveState == 1 && !root.hovered && !root.down ? 8
                                  : (root.effectiveState == -1 && (root.hovered || root.down) ? 8
                                  : (root.effectiveState == -1 ? 12
                                  : (root.effectiveState == 0 && !root.hovered && !root.down) ? 16 : 12)
                              );
    property real _iconHeight: root.effectiveState == 1 && !root.hovered && !root.down ? 8
                                   : (root.effectiveState == -1 && (root.hovered || root.down) ? 8
                                   : (root.effectiveState == -1 ? 4
                                   : (root.effectiveState == 0 && !root.hovered && !root.down) ? 16 : 12)
                               );
    property color _iconColor: (root.effectiveState == 1 || root.effectiveState == -1) && (!root.hovered && !root.down) ? (
                                    Theme.palette.highlight
                                ) : root.effectiveState == -1 || (root.effectiveState == 1 && (!root.hovered && !root.down)) ? (
                                    Theme.palette.highlight_1
                                ) : Theme.palette.background;
    property real _iconRadius: 8
    property real _elevation: root.enabled ? (
                                  root.effectiveState == 0 ? (
                                      !root.down ? 1 : 0
                                  ) : (
                                      !root.down ? 2 : 1
                                  )
                              ) : 0;

    opacity: !root.enabled ? Theme.disabled_opacity : 1
    layer.enabled: !root.enabled

    padding: 0

    Elevation {
        anchors.fill: indicator
        radius: indicator.radius
        elevation: _elevation
        z: -1
    }

    indicator: Rectangle {
        width: root._width;
        height: root._height;

        x: root.text ? (root.mirrored ? root.width - width - root.rightPadding : root.leftPadding) : root.leftPadding + (root.availableWidth - width) / 2
        y: root.topPadding + (root.availableHeight - height) / 2

        radius: _radius
        color: _backgroundColor

        border.width: _borderWidth
        border.color: _borderColor

        Behavior on color {
            ColorAnimation {
                duration: Theme.animations.basic.duration
                easing.type: Theme.animations.basic.type
            }
        }

        Rectangle {
            id: icon
            x: (parent.width - width) / 2
            y: (parent.height - height) / 2
            width: _iconWidth
            height: _iconHeight
            radius: _iconRadius
            color: _iconColor;

            Behavior on color {
                ColorAnimation {
                    duration: Theme.animations.basic.duration
                    easing.type: Theme.animations.basic.type
                }
            }
            Behavior on width {
                animation: NumberAnimation {
                    duration: Theme.animations.basic.duration
                    easing.type: Theme.animations.basic.type
                }
            }
            Behavior on height {
                animation: NumberAnimation {
                    duration: Theme.animations.basic.duration
                    easing.type: Theme.animations.basic.type
                }
            }
        }
    }
}
