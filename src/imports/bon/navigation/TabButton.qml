import QtQuick
import QtQuick.Layouts
import QtQuick.Templates as T
import bon as B

T.AbstractButton {
    id: root
    width: 60
    height: 60

    property string label: ""
    property int notifications: -1
    property bool active: false

    property real _textOpacity: root.down || root.hovered || !root.enabled ? B.Theme.highlight_hover_opacity : 1
    property real _maxNotificationCount: 5000

    Behavior on _textOpacity {
        NumberAnimation {
            duration: B.Theme.animations.basic.duration
            easing.type: B.Theme.animations.basic.type
        }
    }

    ColumnLayout {
        spacing: 4
        anchors.centerIn: parent

        Rectangle {
            width: 50
            height: root.label ? 32 : 50
            color: root.pressed || root.active ? B.Theme.palette.accent_1 : B.Theme.palette.accent
            radius: width
            Layout.alignment: Qt.AlignHCenter

            Behavior on color {
                ColorAnimation {
                    duration: B.Theme.animations.basic.duration
                    easing.type: B.Theme.animations.basic.type
                }
            }

            B.Icon {
                id: tabIcon
                dark: true
                name: root.icon.name
                anchors.centerIn: parent
                opacity: root._textOpacity
            }

            Rectangle {
                visible: root.notifications >= 0
                color: B.Theme.palette.notify
                anchors.horizontalCenter: tabIcon.right
                anchors.verticalCenter: tabIcon.top
                radius: height
                width: root.notifications >= 1 ? Math.max(16, badgeNumber.width+8) : 8
                height: root.notifications >= 1 ? 16 : 8

                B.CaptionText {
                    id: badgeNumber
                    anchors.centerIn: parent
                    anchors.baseline: parent.baseline
                    height: 16
                    visible: root.notifications >= 1
                    dark: true
                    text: root.notifications > _maxNotificationCount ? _maxNotificationCount + "+" : root.notifications
                }
            }
        }

        B.CaptionText {
            visible: root.label
            dark: true
            text: root.label
            lines: 1
            //opacity: root._textOpacity
            Layout.alignment: Qt.AlignHCenter
        }
    }
}
