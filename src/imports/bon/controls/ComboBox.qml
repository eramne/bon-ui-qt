import QtQuick
import QtQuick.Layouts
import QtQuick.Templates as T
import QtQml.Models
import bon

TextInputBase {
    id: root

    property real maxPopupHeight: 300

    property string value: list.model[selectedIndex].name
    property int selectedIndex: 1

    property bool editable: true
    field.readOnly: !editable

    property bool _shouldOpenPopup: true

    Timer {
        interval: 1
        running: true
        repeat: false
        onTriggered: {
            root._shouldOpenPopup = false;
            field.clear();
            field.insert(0,root.value);
            root._shouldOpenPopup = true;
        }
    }

    suffixText: popup.opened && list.highlightedIndex >= 0 ? model[list.highlightedIndex].name : ""

    field.onFocusChanged: {
        if (field.focus && root._shouldOpenPopup) {
            popup.open();
        }
        _updateValue()
    }

    onSelectedIndexChanged: {
        list.currentIndex = selectedIndex
        list.selectedIndices = [selectedIndex]
        _updateValue()
        popup.close()
        focus = false
        field.focus = false
    }

    function _updateValue() {
        selectedIndex = list.currentIndex
        value = list.model[selectedIndex].name
        field.text = value
    }

    field.onEditingFinished: {
        _updateValue()
    }

    field.onTextEdited: {
        if (!popup.opened && root._shouldOpenPopup) {
            popup.open();
        }
    }

    Keys.onPressed: function (event) {
        if (event.key === Qt.Key_Up) {
            if (!popup.visible) {
                if (list.currentIndex - 1 < 0) {
                    list.currentIndex = list.model.length - 1
                    _updateValue()
                } else {
                    list.currentIndex--
                    _updateValue()
                }
                event.accepted = true
            }
        }
        if (event.key === Qt.Key_Down) {
            if (!popup.visible) {
                if (currentIndex + 1 >= model.length) {
                    list.currentIndex = 0
                    _updateValue()
                } else {
                    list.currentIndex++
                    _updateValue()
                }
                event.accepted = true
            }
        }
    }

    Keys.forwardTo: list

    _trailingIcons: Component {
        Row {
            visible: root.enabled
            spacing: 10
            Layout.alignment: Qt.AlignVCenter
            rightPadding: 0

            SmallIconButton {
                id: iconButton
                offIcon: "expand_more"

                onReleased: {
                    if (root.popup.opened) {
                        root.popup.close();
                    } else {
                        if (root._shouldOpenPopup) {
                            root.popup.open();
                            root.field.focus = true;
                        }
                    }
                }
            }
        }
    }

    property var model: []

    property Dropdown popup: Dropdown {
        targetWidth: root.width
        targetHeight: Math.min(root.maxPopupHeight, list.contentHeight + list.topMargin + list.bottomMargin)

        onFocusChanged: {
            if (focus) {
                root.focus = true
            }
        }

        List {
            id: list
            model: root.model
            anchors.fill: parent
            currentIndex: 0
            compact: true
            selectionMode: List.SelectionMode.Single

            function filter(name) {
                if (root.field.displayText.trim().toLowerCase() === root.value.trim().toLowerCase() || !root.popup.opened) {
                    return true;
                } else {
                    return name.trim().toLowerCase().startsWith(root.field.displayText.trim().toLowerCase());
                }
            }

            onHeightChanged: {
                parent.height = height + parent.topPadding + parent.bottomPadding;
            }

            onFocusChanged: {
                if (focus) {
                    root.focus = true
                }
            }

            onSelectedIndicesChanged: {
                root.selectedIndex = selectedIndices[0] ?? 0;
            }
        }
    }
}
