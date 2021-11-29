import QtQuick
import QtQuick.Templates as T
import QtQuick.Shapes
import bon

T.CheckBox {
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
    property real _radius: 4
    property color _backgroundColor: control.effectiveState === 0 ? (
                                         __app__.style.palette.background
                                     ) : control.effectiveState === 1  ? (
                                         control.down ? __app__.style.palette.controls.accent_1 : __app__.style.palette.controls.accent
                                     ) : (
                                         control.down ? __app__.style.palette.controls.accent : __app__.style.palette.controls.accent_1
                                     )
    property real _opacity: !control.enabled ? __app__.style.misc_values.disabled_opacity : 1
    property color _borderColor: control.effectiveState == 0 ? (
                                     control.down ? __app__.style.palette.controls.background_1 : __app__.style.palette.controls.background
                                 ) : "#00000000"
    property real _borderWidth: control.effectiveState == 0 ? 2 : 0
    property real _iconWidth: control.effectiveState == 1  ? 3
                                  : (control.effectiveState == -1 && (control.hovered || control.down) ? 3
                                  : (control.effectiveState == -1 ? 4
                                  : (control.effectiveState == 0 && !control.hovered && !control.down) ? 0 : 2)
                              );
    property color _iconColor: (control.effectiveState == 1 || control.effectiveState == -1) && (!control.hovered && !control.down) ? (
                                    __app__.style.palette.controls.highlight
                                ) : (control.effectiveState == 1 || control.effectiveState == -1) ? (
                                    __app__.style.palette.controls.highlight_1
                                ) : (!control.hovered && !control.down) ? __app__.style.palette.background : (
                                    control.down ? __app__.style.palette.controls.background_1 : __app__.style.palette.controls.background
                                );
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
    property bool _useMixedIcon: control.mixed && !control.down && !control.hovered

    padding: _padding

    opacity: _opacity
    layer.enabled: !control.enabled

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

        Behavior on border.width {
            animation: NumberAnimation {
                duration: _duration;
                easing.type: _easing;
            }
        }

        Behavior on border.color {
            ColorAnimation {
                duration: _duration;
                easing.type: _easing
            }
        }

        Shape {
            anchors.centerIn: parent
            width: 20
            height: 20
            layer.enabled: true
            layer.samples: 8
            opacity: _iconColor.a
            ShapePath {
                id: icon
                strokeColor: Qt.rgba(_iconColor.r,_iconColor.g,_iconColor.b,1)
                strokeWidth: _iconWidth
                fillColor: "transparent"
                joinStyle: ShapePath.RoundJoin
                capStyle: ShapePath.RoundCap

                Behavior on strokeColor {
                    animation: ColorAnimation {
                        duration: _duration;
                        easing.type: _easing;
                    }
                }

                Behavior on strokeWidth {
                    animation: NumberAnimation {
                        duration: _duration;
                        easing.type: _easing;
                    }
                }

                startX: (!_useMixedIcon ? 0 : 2)+4;
                startY: 4+6

                Behavior on startX {
                    animation: NumberAnimation {
                        duration: _duration;
                        easing.type: _easing;
                    }
                }

                PathLine {
                    x: (!_useMixedIcon ? 4 : 6)+4;
                    y: (!_useMixedIcon ? 8 : 4) + 6
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
                }
                PathLine {
                    x: (!_useMixedIcon ? 12 : 10)+4;
                    y: (!_useMixedIcon ? 0 : 4) + 6
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
                }
            }
        }
    }
}
