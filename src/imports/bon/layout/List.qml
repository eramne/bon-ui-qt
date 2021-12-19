import QtQuick
import QtQuick.Templates as T
import QtQuick.Layouts
import bon

ListView {
    id: root

    property bool compact: false

    property int hoveredIndex: -1
    property int highlightedIndex: root.hoveredIndex >= 0 ? root.hoveredIndex : currentIndex

    property int _firstVisibleIndex: {
        for (var i = 0; i < model.count; i++) {
            if (root.filter(model.get(i).name)) {
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

    Keys.onPressed: function (event) {
        if (event.key === Qt.Key_Up) {
            root.decrementCurrentIndex()
        }
        if (event.key === Qt.Key_Down) {
            root.incrementCurrentIndex()
        }
    }

    function incrementCurrentIndex() {
        if (_firstVisibleIndex >= 0) {
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
            root.hoveredIndex = tmpIndex;
            root.positionViewAtIndex(tmpIndex, ListView.Contain);
        }
    }

    function decrementCurrentIndex() {
        if (_firstVisibleIndex >= 0) {
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
            root.hoveredIndex = tmpIndex;
            root.positionViewAtIndex(tmpIndex, ListView.Contain);
        }
    }

    delegate: T.ItemDelegate {
        id: item
        width: Math.max(implicitWidth, root.width - root.leftMargin - root.rightMargin)
        height: itemRow.height
        required property string name
        property string caption: ListView.view.model.get(index).caption ?? "";
        property string overline: ListView.view.model.get(index).overline ?? "";
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
                root.hoveredIndex = item.index
            }
        }

        onClicked: {
            root.currentIndex = index
            root.focus = true
        }

        background: Rectangle {
            anchors.fill: parent
            radius: 4
            color: item.pressed || root.currentIndex === item.index ? Theme.palette.background_2 : (
                       root.highlightedIndex === item.index ? Theme.palette.background_1 : Qt.alpha(Theme.palette.background, 0)
                   )
            opacity: 0.3   //something to consider, not really sure if i should make it opaque or not, i feel like it might be a bit too much contrast with the text and the backround in hover & pressed states, maybe opaque in compact lists and slightly transparent in spacous lists? idk

            Behavior on color {
                ColorAnimation {
                    duration: Theme.animations.basic.duration
                    easing.type: Theme.animations.basic.type
                }
            }
        }

        contentItem: RowLayout {
            id: itemRow
            height: implicitHeight
            visible: parent.visible

            ColumnLayout {
                spacing: root.compact ? 2 : 5
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.leftMargin: root.compact ? 10 : 20
                Layout.rightMargin: root.compact ? 10 : 20
                Layout.topMargin: root.compact ? 4 : 14
                Layout.bottomMargin: root.compact ? 4 : 14

                Text {
                    visible: parent.visible && item.overline
                    text: item.overline
                    verticalAlignment: Text.AlignVCenter
                    Layout.fillWidth: true
                    maximumLineCount: 1
                    elide: Text.ElideRight
                    font: Theme.text.overline
                    color: Theme.palette.text.overline
                }

                Text {
                    visible: parent.visible
                    text: item.name
                    verticalAlignment: Text.AlignVCenter
                    Layout.fillWidth: true
                    maximumLineCount: 1
                    elide: Text.ElideRight
                    font: Theme.text.body
                    color: Theme.palette.text.body
                }

                Text {
                    visible: parent.visible && item.caption
                    text: item.caption
                    verticalAlignment: Text.AlignVCenter
                    Layout.fillWidth: true
                    wrapMode: Text.Wrap
                    maximumLineCount: 2
                    elide: Text.ElideRight
                    font: Theme.text.caption
                    color: Theme.palette.text.label
                }
            }
        }
    }
}
