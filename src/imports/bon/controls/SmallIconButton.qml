import QtQuick 2.0
import QtQuick.Layouts
import QtQuick.Templates as T
import bon as Bon

T.AbstractButton {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                                implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    icon.color: _textColor

    hoverEnabled: enabled
    //checkable: false

    property color _textColor: dark ? (
                                   __app__.style.palette.text.label_dark
                               ) : (
                                   __app__.style.palette.text.label
                               )
    property real _textOpacity: control.down || control.hovered || !control.enabled ? __app__.style.palette.controls.highlight_1.a : 1
    property color _backgroundColor: dark ? (
                                         control.down ? __app__.style.palette.controls.accent_1 : __app__.style.palette.controls.accent
                                     ) : (
                                         control.down ? __app__.style.palette.controls.background_1 : __app__.style.palette.controls.background
                                     )
    property real _backgroundOpacity: control.dark ? (control.pressed ? 1 : 0) : (control.pressed || control.hovered ? 1 : 0)
    property real _radius: Math.max(width,height)/2
    property real _width: 24
    property real _height: 24
    property real _opacity: !control.enabled ? __app__.style.misc_values.disabled_opacity : 1
    property real _easing: __app__.style.animations.basic.type
    property real _duration: __app__.style.animations.basic.duration

    property bool dark: false
    property string offIcon: ""
    property string onIcon: offIcon

    width: _width
    height: _height
    opacity: _opacity
    layer.enabled: !control.enabled

    Behavior on _backgroundColor {
        ColorAnimation {
            duration: _duration;
            easing.type: _easing
        }
    }

    Behavior on _textOpacity {
        NumberAnimation {
            duration: _duration;
            easing.type: _easing
        }
    }

    Behavior on _backgroundOpacity {
        NumberAnimation {
            duration: _duration;
            easing.type: _easing
        }
    }

    contentItem: Item {
        anchors.fill: parent
        Bon.Icon {
            id: icon
            anchors.centerIn: parent
            visible: isValid
            name: control.checked ? control.onIcon : control.offIcon
            color: control.icon.color
            opacity: _textOpacity
        }
    }

    background: Rectangle {
        anchors.fill: control
        color: _backgroundColor
        radius: _radius
        opacity: _backgroundOpacity
    }
}
