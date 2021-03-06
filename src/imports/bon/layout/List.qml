import QtQuick
import QtQuick.Templates as T
import QtQuick.Layouts
import bon as B

ListView {
    id: root

    property bool compact: false
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

    property bool fixedWidth: true

    onCurrentIndexChanged: {
        if (itemAtIndex(currentIndex)) {
            itemAtIndex(currentIndex).focus = true
        }
    }

    property int _firstVisibleIndex: {
        for (var i = 0; i < model.length; i++) {
            if (root.filter(model[i]) && (model[i]?.enabled ?? true)) {
                return i;
            }
        }
        return -1;
    }

    signal itemActivated(int index, var item)

    contentWidth: fixedWidth ? width - leftMargin - rightMargin : contentItem.childrenRect.width
    contentHeight: contentItem.childrenRect.height
    boundsBehavior: Flickable.DragOverBounds
    flickableDirection: Flickable.AutoFlickIfNeeded
    clip: true
    keyNavigationEnabled: false

    B.ScrollBar.vertical: B.ScrollBar { }
    B.ScrollBar.horizontal: B.ScrollBar { }

    leftMargin: 10
    topMargin: 10
    rightMargin: 10
    bottomMargin: 10

    maximumFlickVelocity: 4000

    width: 200
    height: 200

    function filter(item) {
        return true;
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
            } while ((tmpIndex < 0 || !(root.filter(model[tmpIndex]) && (model[tmpIndex]?.enabled ?? true))) && tmpStopCounter < model.length);
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
            } while ((tmpIndex < 0 || !(root.filter(model[tmpIndex]) && (model[tmpIndex]?.enabled ?? true))) && tmpStopCounter < model.length);
            selectionModel.currentIndex = tmpIndex;
            root.positionViewAtIndex(tmpIndex, ListView.Contain);
        }
    }

    B.SelectionModel {
        id: selectionModel
    }

    signal _updateSelectionBackgroundColors

    delegate: T.ItemDelegate {
        id: listItem
        width: root.fixedWidth ? root.width - root.leftMargin - root.rightMargin : Math.max(implicitWidth, root.width - root.leftMargin - root.rightMargin)
        height: itemContent.height
        property string name: model[index].name ?? ""
        property string caption: model[index].caption ?? ""
        property string overline: model[index].overline ?? "";
        property var leading: model[index].leading ?? undefined;
        property var trailing: model[index].trailing ?? undefined;
        property bool showDivider: model[index].showDivider ?? false;
        property string sectionName: model[index].sectionName ?? "";
        property var onActivated: model[index].onActivated;
        enabled: model[index].enabled ?? true;
        required property int index
        visible: root.filter(model[index])
        property alias container: container

        property real _itemImplicitWidth: itemRow.implicitWidth + itemRow.Layout.leftMargin + itemRow.Layout.rightMargin

        layer.enabled: !enabled
        opacity: enabled ? 1 : B.Theme.disabled_opacity
        hoverEnabled: enabled

        Keys.enabled: true
        Keys.onPressed: function (event) {
            if (event.key === Qt.Key_Return) {
                onReleased()
            }
        }

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

        onReleased: {
            if (root.selectionMode === List.SelectionMode.Multiple) {
                if (!root.ctrlDown && !root.shiftDown) {
                    selectionModel.select(index)
                } else if (!root.ctrlDown && root.shiftDown) {
                    selectionModel.select(index, B.SelectionModel.SelectionType.Range)
                } else if (root.ctrlDown && !root.shiftDown) {
                    selectionModel.select(index, B.SelectionModel.SelectionType.Toggle)
                } else if (root.ctrlDown && root.shiftDown) {
                    selectionModel.select(index, B.SelectionModel.SelectionType.AddRange)
                }
            } else if (root.selectionMode === List.SelectionMode.Single) {
                selectionModel.select(index)
            }
            root.focus = true
            root._updateSelectionBackgroundColors()
            if (listItem.onActivated instanceof Function) {
                listItem.onActivated();
            }

            root.itemActivated(listItem.index, listItem)
        }

        background: Item {

            Rectangle {
                width: parent.width
                y: container.y
                height: container.height
                radius: 4
                color: getColor()
                function getColor() {
                    return listItem.pressed || selectionModel.isSelected(listItem.index) ? B.Theme.palette.background_2 : (
                               root.hoveredIndex === listItem.index ? B.Theme.palette.background_1 : Qt.alpha(B.Theme.palette.background, 0)
                           )
                }

                Component.onCompleted: {
                    root._updateSelectionBackgroundColors.connect(function(){
                        if (listItem?.background?.color) {
                            listItem.background.color = Qt.binding(function () {return getColor()})
                        }
                    })
                }

                border.width: root.hoveredIndex !== listItem.index && root.highlightedIndex === listItem.index ? 2 : 0
                border.color: B.Theme.palette.background_1
                opacity: 0.3

                Behavior on color {
                    ColorAnimation {
                        duration: B.Theme.animations.basic.duration
                        easing.type: B.Theme.animations.basic.type
                    }
                }
            }
        }

        contentItem: ColumnLayout {
            id: itemContent
            width: root.fixedWidth ? parent.width : implicitWidth
            height: implicitHeight
            visible: parent.visible

            B.Divider {
                visible: listItem.showDivider
                name: listItem.sectionName
                Layout.fillWidth: true
                Layout.topMargin: 5
                textInset: itemRow.Layout.leftMargin
            }

            RowLayout {
                id: container
                width: root.fixedWidth ? parent.width : implicitWidth
                height: implicitHeight
                visible: parent.visible

                RowLayout {
                    id: itemRow
                    spacing: root.compact ? 5 : 10
                    visible: parent.visible

                    Layout.fillHeight: true
                    Layout.fillWidth: true

                    Layout.leftMargin: root.compact ? 10 : 10
                    Layout.rightMargin: root.compact ? 10 : 10
                    Layout.topMargin: root.compact ? 0 : 10
                    Layout.bottomMargin: root.compact ? 0 : 10

                    Loader {
                        active: listItem.leading !== undefined
                        sourceComponent: {
                            switch (listItem.leading?.type) {
                            case B.ListLeading.Type.Icon:
                                return leadingIcon
                            case B.ListLeading.Type.Avatar:
                                return leadingAvatar
                            case B.ListLeading.Type.Thumbnail:
                                return leadingThumbnail
                            default:
                                return undefined
                            }
                        }

                        Component {
                            id: leadingIcon

                            B.Icon {
                                name: listItem.leading?.name ?? "";
                                size: root.compact ? 20 : 24
                            }
                        }

                        Component {
                            id: leadingAvatar

                            B.Avatar {
                                source: listItem.leading?.source ?? "";
                            }
                        }

                        Component {
                            id: leadingThumbnail

                            B.Thumbnail {
                                source: listItem.leading?.source ?? "";
                            }
                        }
                    }

                    ColumnLayout {
                        Layout.fillHeight: true
                        Layout.fillWidth: true

                        B.OverlineText {
                            visible: parent.visible && listItem.overline
                            text: listItem.overline
                            verticalAlignment: Text.AlignVCenter
                            Layout.fillWidth: true
                            lines: 1
                        }

                        B.BodyText {
                            visible: parent.visible
                            text: listItem.name
                            verticalAlignment: Text.AlignVCenter
                            Layout.fillWidth: true
                            lines: 1
                        }

                        B.CaptionText {
                            visible: parent.visible && listItem.caption
                            text: listItem.caption
                            verticalAlignment: Text.AlignVCenter
                            Layout.fillWidth: true
                            lines: 2
                        }
                    }

                    Component.onCompleted: {
                        if (listItem.trailing !== undefined && listItem.trailing?.type === B.ListTrailing.Type.Item) {
                            if (listItem.trailing?.component.status === Component.Ready) {
                                listItem.trailing?.component.createObject(itemRow);
                            }
                        }
                    }

                    Loader {
                        active: listItem.trailing !== undefined
                        sourceComponent: {
                            switch (listItem.trailing?.type) {
                            case B.ListTrailing.Type.Caption:
                                return trailingCaption
                            case B.ListTrailing.Type.Icon:
                                return trailingIcon
                            case B.ListTrailing.Type.Item:
                                //return listItem.trailing?.component
                                return undefined
                            default:
                                return undefined
                            }
                        }

                        Component {
                            id: trailingCaption

                            B.CaptionText {
                                text: listItem.trailing?.text ?? "";
                            }
                        }

                        Component {
                            id: trailingIcon

                            B.Icon {
                                name: listItem.trailing?.name ?? "";
                                size: root.compact ? 20 : 24
                            }
                        }
                    }
                }
            }
        }
    }
}
