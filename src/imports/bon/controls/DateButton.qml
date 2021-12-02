import QtQuick
import QtQuick.Layouts
import QtQuick.Templates as T
import bon

T.AbstractButton {
    id: root

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                                implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)


    hoverEnabled: enabled
    checkable: true
    text: "1"

    property color _textColor: checked || rangeSelected ? (
                                   Theme.palette.text.label_dark
                               ) : (
                                   Theme.palette.text.label
                               )
    property real _textOpacity: root.down || root.hovered || !root.enabled ? Theme.highlight_hover_opacity : 1
    property color _backgroundColor: rangeSelected ? (
                                         root.down ? Theme.palette.accent : Theme.palette.accent_1
                                     ) : (
                                         checked ? (
                                             root.down ? Theme.palette.accent_1 : Theme.palette.accent
                                         ) : (
                                             root.down ? Theme.palette.background_2 : (
                                                 root.hovered ? Theme.palette.background_1 : Theme.palette.background
                                             )
                                         )
                                     )
    property color _borderColor: Theme.palette.background_1
    property real _borderWidth: today && !root.down && !root.hovered && !root.checked ? 2 : 0
    property real _radius: Math.max(width,height)/2
    property real _elevation: root.checked ? (
                                  root.down ? 1 : 2
                              ) : 0

    property bool today: false
    property bool rangeSelected: false

    width: 40
    height: 40
    opacity: !root.enabled ? Theme.disabled_opacity : 1
    layer.enabled: !root.enabled


    Behavior on _backgroundColor {
        ColorAnimation {
            duration: Theme.animations.basic.duration
            easing.type: Theme.animations.basic.type
        }
    }

    Behavior on _textOpacity {
        NumberAnimation {
            duration: Theme.animations.basic.duration
            easing.type: Theme.animations.basic.type
        }
    }

    Behavior on _borderWidth {
        NumberAnimation {
            duration: Theme.animations.basic.duration
            easing.type: Theme.animations.basic.type
        }
    }

    Elevation {
        anchors.fill: background
        radius: background.radius
        elevation: _elevation
        z: -1
    }

    contentItem: Item {
        anchors.fill: parent

        Text {
            id: text
            text: root.text
            anchors.fill: parent
            color: _textColor
            font: Theme.text.button
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            opacity: _textOpacity
        }
    }

    background: Rectangle {
        anchors.fill: root
        color: _backgroundColor
        radius: _radius
        border.color: _borderColor
        border.width: _borderWidth
    }
}
