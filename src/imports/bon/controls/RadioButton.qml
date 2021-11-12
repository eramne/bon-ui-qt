import QtQuick
import QtQuick.Templates as T
import bon

T.RadioButton {
    id: control

    implicitWidth: indicator.width + leftPadding + rightPadding
    implicitHeight: indicator.height + topPadding + bottomPadding

    property bool mixed: false
    hoverEnabled: enabled
    property int effectiveState: mixed ? -1 : control.checked //0 = off, 1 = on, -1 = mixed

    onClicked: function () {
        mixed = false;
    }

    property real _width: 20
    property real _height: 20
    property real _radius: Math.max(_width, _height)
    property color _backgroundColor: control.effectiveState === 0 ? (
                                         control.down ? __app__.style.palette.controls.background_1 : __app__.style.palette.controls.background
                                     ) : control.effectiveState === 1  ? (
                                         control.down ? __app__.style.palette.controls.accent_1 : __app__.style.palette.controls.accent
                                     ) : (
                                         control.down ? __app__.style.palette.controls.accent : __app__.style.palette.controls.accent_1
                                     )
    property real _opacity: !control.enabled ? __app__.style.misc_values.disabled_opacity : 1
    property color _borderColor: "#000000"
    property real _borderWidth: 0
    property real _iconWidth: control.effectiveState == 1 && !control.hovered && !control.down ? 8
                                  : (control.effectiveState == -1 && (control.hovered || control.down) ? 8
                                  : (control.effectiveState == -1 ? 12
                                  : (control.effectiveState == 0 && !control.hovered && !control.down) ? 16 : 12)
                              );
    property real _iconHeight: control.effectiveState == 1 && !control.hovered && !control.down ? 8
                                   : (control.effectiveState == -1 && (control.hovered || control.down) ? 8
                                   : (control.effectiveState == -1 ? 4
                                   : (control.effectiveState == 0 && !control.hovered && !control.down) ? 16 : 12)
                               );
    property color _iconColor: (control.effectiveState == 1 || control.effectiveState == -1) && (!control.hovered && !control.down) ? (
                                    __app__.style.palette.controls.highlight
                                ) : control.effectiveState == -1 || (control.effectiveState == 1 && (!control.hovered && !control.down)) ? (
                                    __app__.style.palette.controls.highlight_1
                                ) : __app__.style.palette.background;
    property real _iconRadius: 8
    property real _padding: 0
    property real _elevation: control.enabled ? (
                                  control.effectiveState == 0 ? (
                                      !control.down ? 1 : 0
                                  ) : (
                                      !control.down ? 2 : 1
                                  )
                              ) : 0;
    property real _easing: __app__.style.animations.basic.type
    property real _duration: __app__.style.animations.basic.duration

    opacity: _opacity
    layer.enabled: !control.enabled

    padding: _padding

    Elevation {
        anchors.fill: indicator
        radius: indicator.radius
        elevation: _elevation
        z: -1
    }

    indicator: Rectangle {
        width: control._width;
        height: control._height;

        x: control.text ? (control.mirrored ? control.width - width - control.rightPadding : control.leftPadding) : control.leftPadding + (control.availableWidth - width) / 2
        y: control.topPadding + (control.availableHeight - height) / 2

        radius: _radius
        color: _backgroundColor

        border.width: _borderWidth
        border.color: _borderColor

        Behavior on color {
            ColorAnimation {
                duration: _duration;
                easing.type: _easing
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
                    duration: _duration;
                    easing.type: _easing
                }
            }
            Behavior on width {
                animation: NumberAnimation {
                    duration: _duration;
                    easing.type: _easing;
                }
            }
            Behavior on height {
                animation: NumberAnimation {
                    duration: _duration;
                    easing.type: _easing;
                }
            }
        }
    }
}
