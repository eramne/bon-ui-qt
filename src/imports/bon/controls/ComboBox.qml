import QtQuick
import QtQuick.Layouts
import QtQuick.Templates as T
import QtQml.Models
import bon as Bon

TextInputBase {
    id: control

    property real _easing: __app__.style.animations.basic.type
    property real _duration: __app__.style.animations.basic.duration

    property real maxContentHeight: 300

    property int _hoveredIndex: -1
    property int firstVisibleIndex: {
        for (var i = 0; i < model.count; i++) {
            if (control.filter(model.get(i).name)) {
                return i;
            }
        }
        return -1;
    }
    property int highlightedIndex: _hoveredIndex >= 0 ? _hoveredIndex : firstVisibleIndex

    property string value: model.get(currentIndex).name;
    property int currentIndex: 0

    property bool editable: true
    field.readOnly: !editable

    Timer {
        interval: 1
        running: true
        repeat: false
        onTriggered: {
            _shouldOpenPopup = false;
            field.clear();
            field.insert(0,control.value);
            _shouldOpenPopup = true;
        }
    }

    property bool _shouldOpenPopup: true

    suffixText: popup.opened && highlightedIndex >= 0 ? model.get(highlightedIndex).name : ""

    field.onFocusChanged: {
        if (field.focus && _shouldOpenPopup) {
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
        if (!popup.opened && _shouldOpenPopup) {
            popup.open();
        }
        _hoveredIndex = -1;
    }

    Keys.onPressed: function (event) {
        if (event.key === Qt.Key_Up) {
            control.decrementCurrentIndex();
        }
        if (event.key === Qt.Key_Down) {
            control.incrementCurrentIndex();
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
                } while ((tmpIndex < 0 || !control.filter(model.get(tmpIndex).name)) && tmpStopCounter < model.count);
                _hoveredIndex = tmpIndex;
                listView.positionViewAtIndex(tmpIndex, ListView.Contain);
            }
        } else {
            if (currentIndex + 1 >= model.count) {
                control.setIndex(0)
            } else {
                control.setIndex(currentIndex + 1)
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
                } while ((tmpIndex < 0 || !control.filter(model.get(tmpIndex).name)) && tmpStopCounter < model.count);
                _hoveredIndex = tmpIndex;
                listView.positionViewAtIndex(tmpIndex, ListView.Contain);
            }
        } else {
            if (currentIndex - 1 < 0) {
                control.setIndex(model.count - 1)
            } else {
                control.setIndex(currentIndex - 1)
            }
        }
    }

    _trailingIcons: Component {
        Row {
            visible: control.enabled
            spacing: 10
            Layout.alignment: Qt.AlignVCenter
            rightPadding: 0

            Bon.SmallIconButton {
                id: iconButton
                offIcon: "expand_more"

                onClicked: {
                    if (control.popup.opened) {
                        control.popup.close();
                    } else {
                        if (_shouldOpenPopup) {
                            control.popup.open();
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
        width: ListView.view.width
        height: contentItem.height
        required property string name
        required property int index
        visible: control.filter(name)
        property bool isFirstItem: control.firstVisibleIndex === index

        onHoveredChanged: {
            if (hovered) {
                control._hoveredIndex = index
            }
        }

        onClicked: {
            control.setIndex(index);
        }

        background: Rectangle {
            anchors.fill: parent
            radius: 4
            color: item.pressed ? __app__.style.palette.controls.background_1 : (
                       highlightedIndex === item.index ? __app__.style.palette.controls.background : Qt.alpha(__app__.style.palette.background, 0)
                   )

            Behavior on color {
                ColorAnimation {
                    duration: _duration;
                    easing.type: _easing
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
                font: __app__.style.text.body
                color: __app__.style.palette.text.body
            }
        }
    }

    property ListModel model: ListModel {

    }

    property Bon.Popup popup: Bon.Popup {
        y: outOfBounds(x, control.height + 10 + height) ? control.height + 10 : -height - 10;
        width: control.width
        height: Math.min(contentItem.height, control.Window.height - topMargin - bottomMargin)
        closePolicy: T.Popup.CloseOnPressOutsideParent

        function updatePopupPos() {
            y = outOfBounds(x, control.height + 10 + height) ? control.height + 10 : -height - 10;
            contentItem.height = Math.min(control.maxContentHeight, contentItem.contentHeight);
        }

        onAboutToShow: {
            updatePopupPos();
        }

        Behavior on y {
            enabled: popup.opened
            animation: NumberAnimation {
                duration: _duration;
                easing.type: _easing;
            }
        }

        Timer {
            repeat: true
            running: popup.opened
            triggeredOnStart: true
            interval: 100
            onTriggered: {
                popup.updatePopupPos();
            }
        }

        HoverHandler {
            onHoveredChanged: {
                if (!hovered) {
                    control._hoveredIndex = -1;
                }
            }
        }

        contentItem: Column {
            width: parent.width
            padding: 10

            ListView {
                id: listView
                height: Math.min(control.maxContentHeight, contentHeight)
                width: parent.width - parent.leftPadding - parent.rightPadding
                model: control.model
                delegate: control.delegate
                boundsBehavior: Flickable.DragOverBounds
                clip: true

                onHeightChanged: {
                    parent.height = height + parent.topPadding + parent.bottomPadding;
                }
            }
        }
    }
}
