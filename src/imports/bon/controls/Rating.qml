import QtQuick 2.0
import QtQuick.Templates as T
import Qt5Compat.GraphicalEffects
import bon as Bon

Item {
    id: root

    property int highlightedIndex: {
        var index = -1;
        for (var i = 0; i < group.buttons.length; i++) {
            var button = group.buttons[i];
            if (index < 0 && button.hovered) {
                index = i;
            }
            if (button.pressed) {
                index = i;
            }
        }
        return index;
    }
    property int pressed: {
        for (var i = 0; i < group.buttons.length; i++) {
            var button = group.buttons[i];
            if (button.pressed) {
                return true;
            }
        }
        return false;
    }
    property int hovered: {
        for (var i = 0; i < group.buttons.length; i++) {
            var button = group.buttons[i];
            if (button.hovered) {
                return true;
            }
        }
        return false;
    }

    property int enteredValue: group.checkedButton?._index ?? -1;
    property real displayValue: 0

    property bool editable: true

    property real visiblePosition: highlightedIndex > -1 ? highlightedIndex + 1 : (enteredValue >= 0 ? enteredValue + 1 : displayValue)

    property real _easing: __app__.style.animations.basic.type
    property real _duration: __app__.style.animations.basic.duration

    property color _backgroundColor: __app__.style.palette.controls.background
    property color _foregroundColor: root.pressed ? __app__.style.palette.controls.background_1 : (
                                         root.hovered ? __app__.style.palette.controls.background : (
                                             enteredValue >= 0 ? __app__.style.palette.controls.accent : __app__.style.palette.controls.accent_1
                                         )
                                     )

    Behavior on _foregroundColor {
        ColorAnimation {
            duration: _duration;
            easing.type: _easing
        }
    }

    Behavior on visiblePosition {
        animation: NumberAnimation {
            duration: _duration;
            easing.type: _easing;
        }
    }

    opacity: !root.enabled ? __app__.style.misc_values.disabled_opacity : 1
    layer.enabled: !root.enabled

    T.ButtonGroup { id: group }

    width: row.width
    height: row.height

    Row {
        id: row

        Repeater {
            model: 5

            T.RadioButton {
                T.ButtonGroup.group: group
                property int _index: index
                width: indicator.width
                height: indicator.height
                enabled: root.editable
                hoverEnabled: root.editable && root.enabled

                indicator: Bon.Icon {
                    color: _backgroundColor
                    name: "star_border"
                }
            }
        }
    }

    Row {
        id: starMask
        Repeater {
            model: 5
            Bon.Icon {
                color: "black"
                name: "star"
            }
        }
    }
    ShaderEffectSource {
        id: starMaskSource
        sourceItem: starMask
        anchors.fill: starMask
        visible: false
        hideSource: true
    }

    Item {
        id: ratingIndicator
        anchors.fill: starMask
        Rectangle {
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            width: parent.width*(root.visiblePosition/5)
            color: _foregroundColor
        }
    }
    ShaderEffectSource {
        id: ratingIndicatorSource
        sourceItem: ratingIndicator
        anchors.fill: ratingIndicator
        visible: false
        hideSource: true
    }

    OpacityMask {
        anchors.fill: ratingIndicatorSource
        source: ratingIndicatorSource
        maskSource: starMaskSource
    }
}
