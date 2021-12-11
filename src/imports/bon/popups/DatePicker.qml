import QtQuick
import QtQuick.Layouts

import bon

Dropdown {
    id: root

    targetWidth: popupContentLayout.width + overflowArea.leftMargin + overflowArea.rightMargin
    targetHeight: popupContentLayout.height + overflowArea.topMargin + overflowArea.bottomMargin

    property var now: new Date()

    property int _visibleMonth: now.getMonth()
    property int _visibleYear: now.getFullYear()

    property date date: now
    property date endDate: date
    property date selectedDate: date
    property date selectedEndDate: endDate
    property date _lastClickedDate: date
    property bool oneDateSelected: selectedDate.getDate() == selectedEndDate.getDate() && selectedDate.getMonth() == selectedEndDate.getMonth() && selectedDate.getFullYear() == selectedEndDate.getFullYear()

    property bool selectRange: false

    signal finished
    signal canceled

    Component.onCompleted: {
        selectedDate = date
        selectedEndDate = endDate
        root.closed.connect(finished)
    }

    onFinished: {
        date = selectedDate
        endDate = selectedEndDate
    }
    onCanceled: {
        selectedDate = date
        selectedEndDate = endDate
        root.close()
    }

    property bool shiftDown: false

    contentItem: OverflowArea {
        id: overflowArea
        anchors.fill: parent
        contentWidth: popupContentLayout.width

        margins: 20


        Keys.onPressed: (event) => { if (event.key === Qt.Key_Shift) { root.shiftDown = true } }
        Keys.onReleased: (event) => { if (event.key === Qt.Key_Shift) { root.shiftDown = false } }


        ColumnLayout {
            id: popupContentLayout
            spacing: 10

            RowLayout {
                Layout.fillWidth: true
                Layout.leftMargin: 15
                spacing: 10

                Text {
                    Layout.fillWidth: true
                    text: root.selectRange ? "Pick a date range" : "Pick a date"
                    color: Theme.palette.text.heading
                    font: Theme.text.heading
                }

                Button {
                    Layout.preferredWidth: 40
                    Layout.preferredHeight: 40
                    order: 3
                    icon.name: "close"
                    onClicked: {
                        root.canceled()
                    }
                }

                Button {
                    Layout.preferredWidth: 40
                    Layout.preferredHeight: 40
                    order: 2
                    icon.name: "done"

                    onClicked: {
                        root.close()
                    }
                }
            }

            RowLayout {
                Layout.fillWidth: true
                Layout.leftMargin: 15
                spacing: 10

                Text {
                    Layout.fillWidth: true
                    text: new Date(root._visibleYear, root._visibleMonth).toLocaleString(Qt.locale(), "MMMM yyyy")
                    color: Theme.palette.text.heading
                    font: Theme.text.subheading
                }

                Button {
                    Layout.preferredWidth: 40
                    Layout.preferredHeight: 40
                    order: 3
                    icon.name: "navigate_before"

                    onReleased: {
                        root._visibleMonth -= 1
                        if (root._visibleMonth < 0) {
                            root._visibleMonth = 11
                            root._visibleYear -= 1
                        }
                    }
                }

                Button {
                    Layout.preferredWidth: 40
                    Layout.preferredHeight: 40
                    order: 3
                    icon.name: "navigate_next"

                    onReleased: {
                        root._visibleMonth += 1
                        if (root._visibleMonth > 11) {
                            root._visibleMonth = 0
                            root._visibleYear += 1
                        }
                    }
                }
            }

            RowLayout {
                spacing: 5
                height: 24

                Repeater {
                    model: 7

                    Item {
                        width: 40
                        height: 24

                        Text {
                            text: Qt.locale().dayName((index + Qt.locale().firstDayOfWeek)%7, Locale.ShortFormat)
                            anchors.centerIn: parent
                            font: Theme.text.caption
                            color: Theme.palette.text.label
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                }
            }

            GridLayout {
                id: buttonGrid
                columns: 7
                rows: 6
                columnSpacing: 5
                rowSpacing: 5

                Repeater {
                    model: parent.columns * parent.rows

                    DateButton {
                        property date date: {
                            var tmpDate = new Date(root._visibleYear, root._visibleMonth)
                            tmpDate.setDate((index + 1) - (7+tmpDate.getDay()-Qt.locale().firstDayOfWeek)%7)
                            return tmpDate
                        }
                        property bool isSelectedDate: root.selectedDate.getDate() == date.getDate() && root.selectedDate.getMonth() == date.getMonth() && root.selectedDate.getFullYear() == date.getFullYear()
                        property bool isSelectedEndDate: root.selectedEndDate.getDate() == date.getDate() && root.selectedEndDate.getMonth() == date.getMonth() && root.selectedEndDate.getFullYear() == date.getFullYear()
                        property bool isAtLeft: date.getDay() === Qt.locale().firstDayOfWeek
                        property bool isAtRight: date.getDay() === (Qt.locale().firstDayOfWeek + 6)%7

                        text: date.getDate()
                        today: root.now.getDate() == date.getDate() && root.now.getMonth() == date.getMonth() && root.now.getFullYear() == date.getFullYear()
                        enabled: date.getMonth() == root._visibleMonth && date.getFullYear() == root._visibleYear

                        checkable: false
                        checked: isSelectedDate || isSelectedEndDate
                        rangeSelected: root.selectRange && date.getTime() > root.selectedDate.getTime() && date.getTime() < root.selectedEndDate.getTime()

                        Rectangle {
                            anchors.fill: parent
                            color: Theme.palette.accent_1
                            visible: (parent.rangeSelected || (
                                         (parent.isSelectedDate || parent.isSelectedEndDate) && !root.oneDateSelected
                                     )) && parent.enabled
                            z: parent.parent.z-1
                            anchors.leftMargin: parent.isSelectedDate ? parent.width/2 : -buttonGrid.columnSpacing - (parent.isAtLeft ? overflowArea.leftMargin : 0)
                            anchors.rightMargin: parent.isSelectedEndDate ? parent.width/2 : -buttonGrid.columnSpacing  - (parent.isAtRight ? overflowArea.leftMargin : 0)
                        }

                        onReleased: {
                            if (!root.shiftDown || !root.selectRange) {
                                root.selectedDate = date
                                root.selectedEndDate = root.selectedDate
                                root._lastClickedDate = root.selectedDate
                            } else {
                                if (date.getTime() > root._lastClickedDate.getTime()) {
                                    root.selectedDate = root._lastClickedDate
                                    root.selectedEndDate = date
                                } else {
                                    root.selectedDate = date
                                    root.selectedEndDate = root._lastClickedDate
                                }
                            }
                        }

                        PointHandler {
                            property bool dragging: false
                            property point beginDragPosition: Qt.point(0,0)
                            property point position: point.position

                            enabled: root.selectRange

                            onActiveChanged: {
                                dragging = false
                            }

                            onPositionChanged: {
                                if (active) {
                                    if (Math.abs(position.x - beginDragPosition.x) > 10
                                            || Math.abs(position.y - beginDragPosition.y) > 10) {
                                        dragging = true
                                    }
                                }

                                if (dragging) {
                                    var hoverPoint = mapToItem(buttonGrid, position.x, position.y)
                                    var hoveredItem = buttonGrid.childAt(hoverPoint.x, hoverPoint.y)
                                    if (hoveredItem && hoveredItem.date) {
                                        var pressedDate = parent.date
                                        var hoveredDate = hoveredItem.date
                                        if (hoveredDate.getTime() > pressedDate.getTime()) {
                                            root.selectedDate = pressedDate
                                            root.selectedEndDate = hoveredDate
                                        } else {
                                            root.selectedDate = hoveredDate
                                            root.selectedEndDate = pressedDate
                                        }
                                        root._lastClickedDate = pressedDate
                                    }
                                }
                            }

                            onGrabChanged: function (transition, point) {
                                if (transition !== 1) {
                                    dragging = false
                                }

                                beginDragPosition = point.position
                            }
                        }
                    }
                }
            }
        }
    }
}
