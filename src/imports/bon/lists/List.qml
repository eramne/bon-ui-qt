import QtQuick
import QtQuick.Templates as T
import QtQuick.Layouts
import bon

ListView {
    id: root

    property bool compact: false
    //property bool selectMultiple: false
    property int selectionMode: List.SelectionMode.None

    enum SelectionMode {
        None,
        Single,
        Multiple
    }

    property int hoveredIndex: -1
    property int highlightedIndex: root.hoveredIndex >= 0 ? root.hoveredIndex : selectionModel.currentIndex

    property alias currentIndex: selectionModel.currentIndex
    property alias selectedIndices: selectionModel.selectedIndices

    property int _firstVisibleIndex: {
        for (var i = 0; i < model.length; i++) {
            if (root.filter(model[i].name)) {
                return i;
            }
        }
        return -1;
    }

    contentWidth: contentItem.childrenRect.width
    contentHeight: contentItem.childrenRect.height
    boundsBehavior: Flickable.DragOverBounds
    flickableDirection: Flickable.AutoFlickIfNeeded
    clip: true
    keyNavigationEnabled: false

    ScrollBar.vertical: ScrollBar { }
    ScrollBar.horizontal: ScrollBar { }

    property real margins: 10

    leftMargin: margins
    topMargin: margins
    rightMargin: margins
    bottomMargin: margins

    maximumFlickVelocity: 4000

    width: 200
    height: 200

    function filter(name) {
        return true
    }

    property bool shiftDown: false
    property bool ctrlDown: false
    Keys.onPressed: (event) => {
                        if (event.key === Qt.Key_Up) {
                            root.decrementCurrentIndex()
                        }
                        if (event.key === Qt.Key_Down) {
                            root.incrementCurrentIndex()
                        }

                        if (event.key === Qt.Key_Shift) {
                            root.shiftDown = true
                        }
                        if (event.key === Qt.Key_Control) {
                            root.ctrlDown = true
                        }
                    }
    Keys.onReleased: (event) => {
                         if (event.key === Qt.Key_Shift) {
                             root.shiftDown = false
                         }
                         if (event.key === Qt.Key_Control) {
                             root.ctrlDown = false
                         }
                     }

    function incrementCurrentIndex() {
        if (_firstVisibleIndex >= 0) {
            var tmpIndex = highlightedIndex;
            var tmpStopCounter = 0; //to prevent possible infinite loop if i made a mistake anywhere
            do {
                if (tmpIndex + 1 >= model.length) {
                    tmpIndex = 0;
                } else {
                    tmpIndex++;
                }
                tmpStopCounter++;
            } while ((tmpIndex < 0 || !root.filter(model[tmpIndex].name)) && tmpStopCounter < model.length);
            selectionModel.currentIndex = tmpIndex;
            root.positionViewAtIndex(tmpIndex, ListView.Contain);
        }
    }

    function decrementCurrentIndex() {
        if (_firstVisibleIndex >= 0) {
            var tmpIndex = highlightedIndex;
            var tmpStopCounter = 0; //to prevent possible infinite loop if i made a mistake anywhere
            do {
                if (tmpIndex - 1 < 0) {
                    tmpIndex = model.length-1;
                } else {
                    tmpIndex--;
                }
                tmpStopCounter++;
            } while ((tmpIndex < 0 || !root.filter(model[tmpIndex].name)) && tmpStopCounter < model.length);
            selectionModel.currentIndex = tmpIndex;
            root.positionViewAtIndex(tmpIndex, ListView.Contain);
        }
    }

    SelectionModel {
        id: selectionModel
    }

    signal _updateSelectionBackgroundColors

    delegate: T.ItemDelegate {
        id: listItem
        width: Math.max(implicitWidth, root.width - root.leftMargin - root.rightMargin)
        height: itemContent.height
        property string name: model[index].name ?? ""
        property string caption: model[index].caption ?? ""
        property string overline: model[index].overline ?? "";
        property var leading: model[index].leading ?? undefined;
        property var trailing: model[index].trailing ?? undefined;
        required property int index
        visible: root.filter(name)

        onHoveredChanged: {
            root.hoveredIndex = -1
            if (hovered) {
                sethovertimer.start()
            }
        }

        Timer {
            id: sethovertimer //fixes a thing, its necessary i think
            interval: 0
            repeat: false
            running: false
            onTriggered: {
                root.hoveredIndex = listItem.index
            }
        }

        onClicked: {
            if (root.selectionMode === List.SelectionMode.Multiple) {
                if (!root.ctrlDown && !root.shiftDown) {
                    selectionModel.select(index)
                } else if (!root.ctrlDown && root.shiftDown) {
                    selectionModel.select(index, SelectionModel.SelectionType.Range)
                } else if (root.ctrlDown && !root.shiftDown) {
                    selectionModel.select(index, SelectionModel.SelectionType.Toggle)
                } else if (root.ctrlDown && root.shiftDown) {
                    selectionModel.select(index, SelectionModel.SelectionType.AddRange)
                }
            } else if (root.selectionMode === List.SelectionMode.Single) {
                selectionModel.select(index)
            }
            root.focus = true
            root._updateSelectionBackgroundColors()
        }

        background: Rectangle {
            anchors.fill: parent
            radius: 4
            color: getColor()
            function getColor() {
                return listItem.pressed || selectionModel.isSelected(listItem.index) ? Theme.palette.background_2 : (
                           root.hoveredIndex === listItem.index ? Theme.palette.background_1 : Qt.alpha(Theme.palette.background, 0)
                       )
            }

            Component.onCompleted: {
                root._updateSelectionBackgroundColors.connect(function(){
                    color = Qt.binding(function () {return getColor()})
                })
            }

            border.width: root.hoveredIndex !== listItem.index && root.highlightedIndex === listItem.index ? 2 : 0
            border.color: Theme.palette.background_1
            opacity: 0.3

            Behavior on color {
                ColorAnimation {
                    duration: Theme.animations.basic.duration
                    easing.type: Theme.animations.basic.type
                }
            }
        }

        contentItem: RowLayout {
            id: itemContent
            height: implicitHeight
            visible: parent.visible

            RowLayout {
                id: itemRow
                spacing: 10
                visible: parent.visible

                Layout.fillHeight: true
                Layout.fillWidth: true

                Layout.leftMargin: root.compact ? 10 : 20
                Layout.rightMargin: root.compact ? 10 : 20
                Layout.topMargin: root.compact ? 4 : 14
                Layout.bottomMargin: root.compact ? 4 : 14

                Loader {
                    active: listItem.leading !== undefined
                    sourceComponent: {
                        switch (listItem.leading?.type) {
                        case ListLeading.Type.Icon:
                            return leadingIcon
                        case ListLeading.Type.Avatar:
                            return leadingAvatar
                        case ListLeading.Type.Thumbnail:
                            return leadingThumbnail
                        default:
                            return undefined
                        }
                    }

                    Component {
                        id: leadingIcon

                        Icon {
                            name: listItem.leading?.name ?? "";
                            color: Theme.palette.text.label
                        }
                    }

                    Component {
                        id: leadingAvatar

                        Avatar {
                            source: listItem.leading?.source ?? "";
                        }
                    }

                    Component {
                        id: leadingThumbnail

                        Thumbnail {
                            source: listItem.leading?.source ?? "";
                        }
                    }
                }

                ColumnLayout {
                    spacing: root.compact ? 2 : 5
                    Layout.fillHeight: true
                    Layout.fillWidth: true

                    Text {
                        visible: parent.visible && listItem.overline
                        text: listItem.overline
                        verticalAlignment: Text.AlignVCenter
                        Layout.fillWidth: true
                        maximumLineCount: 1
                        elide: Text.ElideRight
                        font: Theme.text.overline
                        color: Theme.palette.text.overline
                    }

                    Text {
                        visible: parent.visible
                        text: listItem.name
                        verticalAlignment: Text.AlignVCenter
                        Layout.fillWidth: true
                        maximumLineCount: 1
                        elide: Text.ElideRight
                        font: Theme.text.body
                        color: Theme.palette.text.body
                    }

                    Text {
                        visible: parent.visible && listItem.caption
                        text: listItem.caption
                        verticalAlignment: Text.AlignVCenter
                        Layout.fillWidth: true
                        wrapMode: Text.Wrap
                        maximumLineCount: 2
                        elide: Text.ElideRight
                        font: Theme.text.caption
                        color: Theme.palette.text.label
                    }
                }

                Component.onCompleted: {
                    if (listItem.trailing !== undefined && listItem.trailing?.type === ListTrailing.Type.Item) {
                        if (listItem.trailing?.component.status === Component.Ready) {
                            listItem.trailing?.component.createObject(itemRow);
                        }
                    }
                }

                Loader {
                    active: listItem.trailing !== undefined
                    sourceComponent: {
                        switch (listItem.trailing?.type) {
                        case ListTrailing.Type.Caption:
                            return trailingCaption
                        case ListTrailing.Type.Icon:
                            return trailingIcon
                        case ListTrailing.Type.Item:
                            //return listItem.trailing?.component
                            return undefined
                        default:
                            return undefined
                        }
                    }

                    Component {
                        id: trailingCaption

                        Text {
                            text: listItem.trailing?.text ?? "";
                            font: Theme.text.caption
                            color: Theme.palette.text.label
                        }
                    }

                    Component {
                        id: trailingIcon

                        Icon {
                            name: listItem.trailing?.name ?? "";
                            color: Theme.palette.text.label
                        }
                    }
                }
            }
        }
    }
}
