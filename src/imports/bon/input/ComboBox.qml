import QtQuick
import QtQuick.Layouts
import QtQuick.Templates as T
import bon as B

B.TextInputBase {
    id: root

    property real maxPopupHeight: 300

    property string value: list.model[selectedIndex].name
    property int selectedIndex: 0

    property bool editable: true
    field.readOnly: !editable

    suffixText: popup.opened && list.highlightedIndex >= 0 ? model[list.highlightedIndex].name : ""

    field.onFocusChanged: {
        if (field.focus) {
            popup.open();
        }
        _updateFieldValue();
    }

    onSelectedIndexChanged: {
        _updateListValue();
    }

    Component.onCompleted: {
        _updateListValue();
    }

    function _updateListValue() {
        list.currentIndex = selectedIndex
        list.selectedIndices = [selectedIndex]
        _updateFieldValue()
        popup.close()
        focus = false
        field.focus = false
    }

    function _updateFieldValue() {
        selectedIndex = list.currentIndex
        value = list.model[selectedIndex].name
        field.text = value;
    }

    field.onEditingFinished: {
        _updateFieldValue()
    }

    field.onTextEdited: {
        popup.open();
    }

    Keys.onPressed: function (event) {
        if (event.key === Qt.Key_Up) {
            if (!popup.visible) {
                if (list.currentIndex - 1 < 0) {
                    list.currentIndex = list.model.length - 1
                    _updateFieldValue()
                } else {
                    list.currentIndex--
                    _updateFieldValue()
                }
                event.accepted = true
            }
        }
        if (event.key === Qt.Key_Down) {
            if (!popup.visible) {
                if (currentIndex + 1 >= model.length) {
                    list.currentIndex = 0
                    _updateFieldValue()
                } else {
                    list.currentIndex++
                    _updateFieldValue()
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

            B.SmallIconButton {
                id: iconButton
                icon.name: "expand_more"

                onReleased: {
                    if (root.popup.opened) {
                        root.popup.close();
                    } else {
                        root.popup.open();
                        root.field.focus = true;
                    }
                }
            }
        }
    }

    property var model: []

    property B.Dropdown popup: B.Dropdown {
        targetWidth: root.width
        targetHeight: Math.min(root.maxPopupHeight, list.contentHeight + list.topMargin + list.bottomMargin)

        onFocusChanged: {
            if (focus) {
                root.focus = true
            }
        }

        B.List {
            id: list
            model: root.model
            anchors.fill: parent
            currentIndex: 0
            compact: true
            selectionMode: B.List.SelectionMode.Single

            function filter(item) {
                if (root.field.displayText.trim().toLowerCase() === root.value.trim().toLowerCase() || !root.popup.opened) {
                    return true;
                } else {
                    return item.name.trim().toLowerCase().startsWith(root.field.displayText.trim().toLowerCase());
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
