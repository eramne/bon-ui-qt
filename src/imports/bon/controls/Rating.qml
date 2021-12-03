import QtQuick
import QtQuick.Templates as T
import Qt5Compat.GraphicalEffects
import bon

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

    Behavior on visiblePosition {
        animation: NumberAnimation {
            duration: Theme.animations.basic.duration
            easing.type: Theme.animations.basic.type
        }
    }

    opacity: !root.enabled ? Theme.disabled_opacity : 1
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

                indicator: Icon {
                    color: Theme.palette.background_1
                    name: "star_border"
                }
            }
        }
    }

    Row {
        id: starMask
        Repeater {
            model: 5
            Icon {
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
            color: root.pressed ? Theme.palette.background_2 : (
                       root.hovered ? Theme.palette.background_1 : (
                           enteredValue >= 0 ? Theme.palette.accent : Theme.palette.accent_1
                       )
                   )

            Behavior on color {
                ColorAnimation {
                    duration: Theme.animations.basic.duration
                    easing.type: Theme.animations.basic.type
                }
            }
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
