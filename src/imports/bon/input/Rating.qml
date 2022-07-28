import QtQuick
import QtQuick.Templates as T
import Qt5Compat.GraphicalEffects
import bon as B

Item {
    id: root

    property int highlightedIndex: {
        var index = -1;
        for (var i = 0; i < group.buttons.length; i++) {
            var button = group.buttons[i];
            if (index < 0 && button.hovered) {
                index = group.buttons[i]._index;
            }
            if (button.pressed) {
                index = group.buttons[i]._index;
            }
        }
        return index;
    }
    property bool pressed: {
        for (var i = 0; i < group.buttons.length; i++) {
            var button = group.buttons[i];
            if (button.pressed) {
                return true;
            }
        }
        return false;
    }
    property bool hovered: {
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
    property bool _showRatingDisplay: !(root.pressed || root.hovered || enteredValue >= 0)

    opacity: !root.enabled ? B.Theme.disabled_opacity : 1
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
                width: 24
                height: 24
                enabled: root.editable
                hoverEnabled: root.editable && root.enabled

                indicator: Item {
                    anchors.fill: parent

                    B.Icon {
                        anchors.fill: parent
                        color: B.Theme.palette.background_1
                        name: "star_border"
                    }

                    B.Icon {
                        anchors.fill: parent
                        color: root.highlightedIndex >= 0 && (root.pressed || root.hovered) ? (
                                   _index > root.highlightedIndex ?
                                       Qt.alpha(B.Theme.palette.background_1, 0) :
                                       root.pressed ?
                                           B.Theme.palette.background_2 :
                                           B.Theme.palette.background_1
                               ) : (
                                   root.enteredValue >= 0 && _index <= root.enteredValue ?
                                       B.Theme.palette.accent :
                                       Qt.alpha(B.Theme.palette.background_1, 0)
                               )
                        name: "star"

                        Behavior on color {
                            ColorAnimation {
                                duration: B.Theme.animations.basic.duration
                                easing.type: B.Theme.animations.basic.type
                            }
                        }
                    }
                }
            }
        }
    }

    Row {
        id: starMask
        visible: root._showRatingDisplay

        Repeater {
            model: 5
            B.Icon {
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
        visible: root._showRatingDisplay

        Rectangle {
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            width: parent.width*(root.displayValue/5)
            color: B.Theme.palette.accent_1
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
        visible: root._showRatingDisplay
    }
}
