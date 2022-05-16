import QtQuick
import QtQuick.Templates as T
import QtQuick.Shapes
import bon as B

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
    property color _iconColor: (root.effectiveState === 1 || root.effectiveState === -1) && (!root.hovered && !root.down) ? (
                                    B.Theme.palette.highlight
                                ) : (root.effectiveState === 1 || root.effectiveState === -1) ? (
                                    B.Theme.palette.highlight_1
                                ) : (!root.hovered && !root.down) ? B.Theme.palette.background : (
                                    root.down ? B.Theme.palette.background_2 : B.Theme.palette.background_1
                                )
    property bool _useMixedIcon: root.mixed && !root.down && !root.hovered

    padding: 0

    opacity: !root.enabled ? B.Theme.disabled_opacity : 1
    layer.enabled: !root.enabled

    B.Elevation {
        anchors.fill: indicator
        radius: indicator.radius
        elevation: root.enabled ? (
                       root.effectiveState === 0 ? (
                           !root.down ? 1 : 0
                       ) : (
                           !root.down ? 2 : 1
                       )
                   ) : 0
        z: -1
    }

    indicator: Rectangle {
        width: 20;
        height: 20;

        x: root.text ? (root.mirrored ? root.width - width - root.rightPadding : root.leftPadding) : root.leftPadding + (root.availableWidth - width) / 2
        y: root.topPadding + (root.availableHeight - height) / 2

        radius: 4
        color: root.effectiveState === 0 ? (
                   B.Theme.palette.background
               ) : root.effectiveState === 1  ? (
                   root.down ? B.Theme.palette.accent_1 : B.Theme.palette.accent
               ) : (
                   root.down ? B.Theme.palette.accent : B.Theme.palette.accent_1
               )

        border.width: root.effectiveState === 0 ? 2 : 0
        border.color: root.effectiveState === 0 ? (
                          root.down ? B.Theme.palette.background_2 : B.Theme.palette.background_1
                      ) : "#00000000"

        Behavior on color {
            ColorAnimation {
                duration: B.Theme.animations.basic.duration
                easing.type: B.Theme.animations.basic.type
            }
        }

        Behavior on border.width {
            animation: NumberAnimation {
                duration: B.Theme.animations.basic.duration
                easing.type: B.Theme.animations.basic.type
            }
        }

        Behavior on border.color {
            ColorAnimation {
                duration: B.Theme.animations.basic.duration
                easing.type: B.Theme.animations.basic.type
            }
        }

        Shape {
            anchors.centerIn: parent
            width: 20
            height: 20
            layer.enabled: true
            layer.samples: 8
            opacity: root._iconColor.a
            ShapePath {
                id: icon
                strokeColor: Qt.alpha(root._iconColor,1)
                strokeWidth: root.effectiveState == 1  ? 3
                                 : (root.effectiveState === -1 && (root.hovered || root.down) ? 3
                                 : (root.effectiveState === -1 ? 4
                                 : (root.effectiveState === 0 && !root.hovered && !root.down) ? 0 : 2)
                             )
                fillColor: "transparent"
                joinStyle: ShapePath.RoundJoin
                capStyle: ShapePath.RoundCap

                Behavior on strokeColor {
                    animation: ColorAnimation {
                        duration: B.Theme.animations.basic.duration
                        easing.type: B.Theme.animations.basic.type
                    }
                }

                Behavior on strokeWidth {
                    animation: NumberAnimation {
                        duration: B.Theme.animations.basic.duration
                        easing.type: B.Theme.animations.basic.type
                    }
                }

                startX: (!root._useMixedIcon ? 0 : 2)+4;
                startY: 4+6

                Behavior on startX {
                    animation: NumberAnimation {
                        duration: B.Theme.animations.basic.duration
                        easing.type: B.Theme.animations.basic.type
                    }
                }

                PathLine {
                    x: (!root._useMixedIcon ? 4 : 6)+4
                    y: (!root._useMixedIcon ? 8 : 4) + 6
                    Behavior on x {
                        animation: NumberAnimation {
                            duration: B.Theme.animations.basic.duration
                            easing.type: B.Theme.animations.basic.type
                        }
                    }
                    Behavior on y {
                        animation: NumberAnimation {
                            duration: B.Theme.animations.basic.duration
                            easing.type: B.Theme.animations.basic.type
                        }
                    }
                }
                PathLine {
                    x: (!root._useMixedIcon ? 12 : 10)+4
                    y: (!root._useMixedIcon ? 0 : 4) + 6
                    Behavior on x {
                        animation: NumberAnimation {
                            duration: B.Theme.animations.basic.duration
                            easing.type: B.Theme.animations.basic.type
                        }
                    }
                    Behavior on y {
                        animation: NumberAnimation {
                            duration: B.Theme.animations.basic.duration
                            easing.type: B.Theme.animations.basic.type
                        }
                    }
                }
            }
        }
    }
}
