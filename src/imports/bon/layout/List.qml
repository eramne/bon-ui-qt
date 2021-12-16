import QtQuick
import QtQuick.Templates as T
import bon

ListView {
    id: root

    property int _hoveredIndex: -1
    property int highlightedIndex: root._hoveredIndex >= 0 ? root._hoveredIndex : currentIndex

    contentWidth: contentItem.childrenRect.width
    contentHeight: contentItem.childrenRect.height
    boundsBehavior: Flickable.DragOverBounds
    flickableDirection: Flickable.AutoFlickIfNeeded
    clip: true

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
            root.decrementCurrentIndex();
        }
        if (event.key === Qt.Key_Down) {
            root.incrementCurrentIndex();
        }
    }

    function incrementCurrentIndex() {
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
        root.positionViewAtIndex(tmpIndex, ListView.Contain);
    }

    function decrementCurrentIndex() {
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
        root.positionViewAtIndex(tmpIndex, ListView.Contain);
    }

    delegate: T.ItemDelegate {
        id: item
        width: Math.max(implicitWidth, root.width - root.leftMargin - root.rightMargin)
        height: contentItem.height
        required property string name
        required property int index
        visible: root.filter(name)

        onHoveredChanged: {
            root._hoveredIndex = -1
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
                root._hoveredIndex = item.index
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
}
