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

    icon.color: _textColor

    hoverEnabled: enabled
    visible: icon.isValid
    //checkable: false

    property color _textColor: dark ? (
                                   Theme.palette.text.label_dark
                               ) : (
                                   Theme.palette.text.label
                               )
    property real _textOpacity: root.down || root.hovered || !root.enabled ? Theme.highlight_hover_opacity : 1
    property color _backgroundColor: dark ? (
                                         root.down ? Theme.palette.accent_1 : Theme.palette.accent
                                     ) : (
                                         root.down ? Theme.palette.background_2 : Theme.palette.background_1
                                     )
    property real _backgroundOpacity: root.dark ? (root.pressed ? 1 : 0) : (root.pressed || root.hovered ? 1 : 0)
    property real _radius: Math.max(width,height)/2
    property real _width: 24
    property real _height: 24

    property bool dark: false
    property string offIcon: ""
    property string onIcon: offIcon

    width: _width
    height: _height
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

    Behavior on _backgroundOpacity {
        NumberAnimation {
            duration: Theme.animations.basic.duration
            easing.type: Theme.animations.basic.type
        }
    }

    contentItem: Item {
        anchors.fill: parent
        Icon {
            id: icon
            anchors.centerIn: parent
            visible: isValid
            name: root.checked ? root.onIcon : root.offIcon
            color: root.icon.color
            opacity: _textOpacity
        }
    }

    background: Rectangle {
        anchors.fill: root
        color: _backgroundColor
        radius: _radius
        opacity: _backgroundOpacity
    }
}
