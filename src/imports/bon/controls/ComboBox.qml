import QtQuick
import QtQuick.Layouts
import QtQuick.Templates as T
import QtQml.Models
import bon

TextInputBase {
    id: root

    property real maxPopupHeight: 300

    property int _hoveredIndex: -1
    property int firstVisibleIndex: {
        for (var i = 0; i < model.count; i++) {
            if (root.filter(model.get(i).name)) {
                return i;
            }
        }
        return -1;
    }
    property int highlightedIndex: root._hoveredIndex >= 0 ? root._hoveredIndex : firstVisibleIndex

    property string value: model.get(currentIndex).name;
    property int currentIndex: 0

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

    suffixText: popup.opened && highlightedIndex >= 0 ? model.get(highlightedIndex).name : ""

    field.onFocusChanged: {
        if (field.focus && root._shouldOpenPopup) {
            popup.open();
        }
    }

    function setIndex(i) {
        if (i >= 0) {
            currentIndex = i;
        }
        field.text = value;
        popup.close();
        if (!editable) {
            focus = false;
            field.focus = false;
        }
    }

    field.onEditingFinished: {
        setIndex(highlightedIndex);
    }

    field.onTextEdited: {
        if (!popup.opened && root._shouldOpenPopup) {
            popup.open();
        }
        root._hoveredIndex = -1;
    }

    Keys.onPressed: function (event) {
        if (event.key === Qt.Key_Up) {
            root.decrementCurrentIndex();
        }
        if (event.key === Qt.Key_Down) {
            root.incrementCurrentIndex();
        }
    }

    function incrementCurrentIndex() {
        if (popup.opened) {
            if (firstVisibleIndex >= 0) {
                var tmpIndex = highlightedIndex;
                var tmpStopCounter = 0; //to prevent possible infinite loop if i made a mistake anywhere
                do {
                    if (tmpIndex + 1 >= model.count) {
                        tmpIndex = 0;
                    } else {
                        tmpIndex++;
                    }
                    tmpStopCounter++;
                } while ((tmpIndex < 0 || !root.filter(model.get(tmpIndex).name)) && tmpStopCounter < model.count);
                root._hoveredIndex = tmpIndex;
                listView.positionViewAtIndex(tmpIndex, ListView.Contain);
            }
        } else {
            if (currentIndex + 1 >= model.count) {
                root.setIndex(0)
            } else {
                root.setIndex(currentIndex + 1)
            }
        }
    }

    function decrementCurrentIndex() {
        if (popup.opened) {
            if (firstVisibleIndex >= 0) {
                var tmpIndex = highlightedIndex;
                var tmpStopCounter = 0; //to prevent possible infinite loop if i made a mistake anywhere
                do {
                    if (tmpIndex - 1 < 0) {
                        tmpIndex = model.count-1;
                    } else {
                        tmpIndex--;
                    }
                    tmpStopCounter++;
                } while ((tmpIndex < 0 || !root.filter(model.get(tmpIndex).name)) && tmpStopCounter < model.count);
                root._hoveredIndex = tmpIndex;
                listView.positionViewAtIndex(tmpIndex, ListView.Contain);
            }
        } else {
            if (currentIndex - 1 < 0) {
                root.setIndex(model.count - 1)
            } else {
                root.setIndex(currentIndex - 1)
            }
        }
    }

    _trailingIcons: Component {
        Row {
            visible: root.enabled
            spacing: 10
            Layout.alignment: Qt.AlignVCenter
            rightPadding: 0

            SmallIconButton {
                id: iconButton
                offIcon: "expand_more"

                onClicked: {
                    if (root.popup.opened) {
                        root.popup.close();
                    } else {
                        if (root._shouldOpenPopup) {
                            root.popup.open();
                        }
                    }
                }

                onDoubleClicked: {
                    onClicked();
                }
            }
        }
    }

    function filter(name) {
        if (field.displayText.trim().toLowerCase() === value.trim().toLowerCase()) {
            return true;
        } else {
            return name.trim().toLowerCase().startsWith(field.displayText.trim().toLowerCase());
        }
    }

    property Component delegate: T.ItemDelegate {
        id: item
        width: ListView.view.width - ListView.view.leftMargin - ListView.view.rightMargin
        height: contentItem.height
        required property string name
        required property int index
        visible: root.filter(name)
        property bool isFirstItem: root.firstVisibleIndex === index

        onHoveredChanged: {
            if (hovered) {
                root._hoveredIndex = index
            }
        }

        onClicked: {
            root.setIndex(index);
        }

        background: Rectangle {
            anchors.fill: parent
            radius: 4
            color: item.pressed ? Theme.palette.background_2 : (
                       highlightedIndex === item.index ? Theme.palette.background_1 : Qt.alpha(Theme.palette.background, 0)
                   )

            Behavior on color {
                ColorAnimation {
                    duration: Theme.animations.basic.duration
                    easing.type: Theme.animations.basic.type
                }
            }
        }

        contentItem: Row {
            id: itemRow
            leftPadding: 10
            rightPadding: 10
            height: implicitHeight
            visible: parent.visible

            Text {
                visible: parent.visible
                text: item.name
                height: 28
                verticalAlignment: Text.AlignVCenter
                font: Theme.text.body
                color: Theme.palette.text.body
            }
        }
    }

    property ListModel model: ListModel {

    }

    property Dropdown popup: Dropdown {
        targetWidth: root.width

        HoverHandler {
            onHoveredChanged: {
                if (!hovered) {
                    root._hoveredIndex = -1;
                }
            }
        }

        contentItem: Column {
            width: parent.width
            //padding: 10

            ListView {
                id: listView
                height: Math.min(root.maxPopupHeight-parent.topPadding-parent.bottomPadding, contentHeight)
                width: parent.width - parent.leftPadding - parent.rightPadding
                model: root.model
                delegate: root.delegate
                clip: true

                boundsBehavior: Flickable.DragOverBounds

                ScrollBar.vertical: ScrollBar { }
                ScrollBar.horizontal: ScrollBar { }

                property real margins: 10

                leftMargin: margins
                topMargin: margins
                rightMargin: margins
                bottomMargin: margins

                maximumFlickVelocity: 4000

                onHeightChanged: {
                    parent.height = height + parent.topPadding + parent.bottomPadding;
                }
            }
        }
    }
}
