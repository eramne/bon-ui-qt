import QtQuick
import QtQuick.Templates as T
import QtQuick.Shapes
import bon

T.CheckBox {
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
    property real _radius: 4
    property color _backgroundColor: root.effectiveState === 0 ? (
                                         Theme.palette.background
                                     ) : root.effectiveState === 1  ? (
                                         root.down ? Theme.palette.accent_1 : Theme.palette.accent
                                     ) : (
                                         root.down ? Theme.palette.accent : Theme.palette.accent_1
                                     )
    property real _opacity: !root.enabled ? Theme.disabled_opacity : 1
    property color _borderColor: root.effectiveState == 0 ? (
                                     root.down ? Theme.palette.background_2 : Theme.palette.background_1
                                 ) : "#00000000"
    property real _borderWidth: root.effectiveState == 0 ? 2 : 0
    property real _iconWidth: root.effectiveState == 1  ? 3
                                  : (root.effectiveState == -1 && (root.hovered || root.down) ? 3
                                  : (root.effectiveState == -1 ? 4
                                  : (root.effectiveState == 0 && !root.hovered && !root.down) ? 0 : 2)
                              );
    property color _iconColor: (root.effectiveState == 1 || root.effectiveState == -1) && (!root.hovered && !root.down) ? (
                                    Theme.palette.highlight
                                ) : (root.effectiveState == 1 || root.effectiveState == -1) ? (
                                    Theme.palette.highlight_1
                                ) : (!root.hovered && !root.down) ? Theme.palette.background : (
                                    root.down ? Theme.palette.background_2 : Theme.palette.background_1
                                );
    property real _iconRadius: 8
    property real _padding: 0
    property real _elevation: root.enabled ? (
                                  root.effectiveState == 0 ? (
                                      !root.down ? 1 : 0
                                  ) : (
                                      !root.down ? 2 : 1
                                  )
                              ) : 0;
    property bool _useMixedIcon: root.mixed && !root.down && !root.hovered

    padding: _padding

    opacity: _opacity
    layer.enabled: !root.enabled

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

        Behavior on border.width {
            animation: NumberAnimation {
                duration: Theme.animations.basic.duration
                easing.type: Theme.animations.basic.type
            }
        }

        Behavior on border.color {
            ColorAnimation {
                duration: Theme.animations.basic.duration
                easing.type: Theme.animations.basic.type
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
                        duration: Theme.animations.basic.duration
                        easing.type: Theme.animations.basic.type
                    }
                }

                Behavior on strokeWidth {
                    animation: NumberAnimation {
                        duration: Theme.animations.basic.duration
                        easing.type: Theme.animations.basic.type
                    }
                }

                startX: (!_useMixedIcon ? 0 : 2)+4;
                startY: 4+6

                Behavior on startX {
                    animation: NumberAnimation {
                        duration: Theme.animations.basic.duration
                        easing.type: Theme.animations.basic.type
                    }
                }

                PathLine {
                    x: (!_useMixedIcon ? 4 : 6)+4
                    y: (!_useMixedIcon ? 8 : 4) + 6
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
                }
                PathLine {
                    x: (!_useMixedIcon ? 12 : 10)+4
                    y: (!_useMixedIcon ? 0 : 4) + 6
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
                }
            }
        }
    }
}
