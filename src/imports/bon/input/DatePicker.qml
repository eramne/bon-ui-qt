import QtQuick
import QtQuick.Layouts
import bon as B

B.Dropdown {
    id: root

    targetWidth: popupContentLayout.width + overflowArea.leftMargin + overflowArea.rightMargin
    targetHeight: popupContentLayout.height + overflowArea.topMargin + overflowArea.bottomMargin

    property var now: new Date()

    property int _visibleMonth: now.getMonth()
    property int _visibleYear: now.getFullYear()

    property date currentDate: now
    property date currentEndDate: currentDate
    property date editDate: currentDate
    property date editEndDate: currentEndDate
    property date _lastClickedDate: currentDate
    property bool oneDateSelected: editDate.getDate() === editEndDate.getDate() && editDate.getMonth() === editEndDate.getMonth() && editDate.getFullYear() === editEndDate.getFullYear()

    property bool selectRange: false

    signal finished
    signal canceled

    Component.onCompleted: {
        editDate = currentDate
        editEndDate = currentEndDate
        root.closed.connect(finished)
    }

    onFinished: {
        currentDate = editDate
        currentEndDate = editEndDate
    }
    onCanceled: {
        editDate = currentDate
        editEndDate = currentEndDate
        root.close()
    }

    property bool shiftDown: false

    contentItem: B.OverflowArea {
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
                Layout.leftMargin: 10
                spacing: 10

                B.HeadingText {
                    Layout.fillWidth: true
                    text: root.selectRange ? "Pick a date range" : "Pick a date"
                }

                B.Button {
                    Layout.preferredWidth: 40
                    Layout.preferredHeight: 40
                    order: B.Button.Order.Tertiary
                    icon.name: "close"
                    onClicked: {
                        root.canceled()
                    }
                }

                B.Button {
                    Layout.preferredWidth: 40
                    Layout.preferredHeight: 40
                    order: B.Button.Order.Secondary
                    icon.name: "done"

                    onClicked: {
                        root.close()
                    }
                }
            }

            RowLayout {
                Layout.fillWidth: true
                Layout.leftMargin: 10
                spacing: 10

                B.ComboBox {
                    Layout.fillWidth: true
                    width: 100
                    model: [
                        {name: Qt.locale().monthName(0, Locale.ShortFormat)},
                        {name: Qt.locale().monthName(1, Locale.ShortFormat)},
                        {name: Qt.locale().monthName(2, Locale.ShortFormat)},
                        {name: Qt.locale().monthName(3, Locale.ShortFormat)},
                        {name: Qt.locale().monthName(4, Locale.ShortFormat)},
                        {name: Qt.locale().monthName(5, Locale.ShortFormat)},
                        {name: Qt.locale().monthName(6, Locale.ShortFormat)},
                        {name: Qt.locale().monthName(7, Locale.ShortFormat)},
                        {name: Qt.locale().monthName(8, Locale.ShortFormat)},
                        {name: Qt.locale().monthName(9, Locale.ShortFormat)},
                        {name: Qt.locale().monthName(10, Locale.ShortFormat)},
                        {name: Qt.locale().monthName(11, Locale.ShortFormat)}
                    ]
                    selectedIndex: root._visibleMonth;
                    onSelectedIndexChanged: {
                        root._visibleMonth = selectedIndex;
                    }
                    Component.onCompleted: {
                        root.on_visibleMonthChanged.connect(() => {
                            selectedIndex = root._visibleMonth;
                            console.log(selectedIndex);
                        });
                    }
                }

                B.NumberField {
                    width: 75
                    from: 100
                    to: 9999
                    value: root._visibleYear;
                    onValueChanged: {
                        root._visibleYear = value;
                    }
                    Component.onCompleted: {
                        root.on_visibleYearChanged.connect(() => {
                            value = root._visibleYear;
                        });
                    }
                }

                B.Button {
                    Layout.preferredWidth: 40
                    Layout.preferredHeight: 40
                    order: B.Button.Order.Tertiary
                    icon.name: !root.shiftDown ? "navigate_before" : "keyboard_double_arrow_left"

                    onReleased: {
                        if (!root.shiftDown) {
                            if (root._visibleMonth - 1 < 0) {
                                root._visibleMonth = 11
                                root._visibleYear -= 1
                            } else {
                                root._visibleMonth -= 1
                            }
                        } else {
                            root._visibleYear -= 1
                        }
                    }
                }

                B.Button {
                    Layout.preferredWidth: 40
                    Layout.preferredHeight: 40
                    order: B.Button.Order.Tertiary
                    icon.name: !root.shiftDown ? "navigate_next" : "keyboard_double_arrow_right"

                    onReleased: {
                        if (!root.shiftDown) {
                            if (root._visibleMonth + 1 > 11) {
                                root._visibleMonth = 0
                                root._visibleYear += 1
                            } else {
                                root._visibleMonth += 1
                            }
                        } else {
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

                        B.CaptionText {
                            text: Qt.locale().dayName((index + Qt.locale().firstDayOfWeek)%7, Locale.ShortFormat)
                            anchors.centerIn: parent
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

                    B.DateButton {
                        property date date: {
                            var tmpDate = new Date(root._visibleYear, root._visibleMonth)
                            tmpDate.setDate((index + 1) - (7+tmpDate.getDay()-Qt.locale().firstDayOfWeek)%7)
                            return tmpDate
                        }
                        property bool isEditDate: root.editDate.getDate() === date.getDate() && root.editDate.getMonth() === date.getMonth() && root.editDate.getFullYear() === date.getFullYear()
                        property bool isEditEndDate: root.editEndDate.getDate() === date.getDate() && root.editEndDate.getMonth() === date.getMonth() && root.editEndDate.getFullYear() === date.getFullYear()
                        property bool isAtLeft: date.getDay() === Qt.locale().firstDayOfWeek
                        property bool isAtRight: date.getDay() === (Qt.locale().firstDayOfWeek + 6)%7

                        text: date.getDate()
                        today: root.now.getDate() === date.getDate() && root.now.getMonth() === date.getMonth() && root.now.getFullYear() === date.getFullYear()
                        enabled: date.getMonth() === root._visibleMonth && date.getFullYear() === root._visibleYear

                        checkable: false
                        checked: isEditDate || isEditEndDate
                        rangeSelected: root.selectRange && date.getTime() > root.editDate.getTime() && date.getTime() < root.editEndDate.getTime()

                        Rectangle {
                            anchors.fill: parent
                            color: B.Theme.palette.accent_1
                            visible: (parent.rangeSelected || (
                                         (parent.isEditDate || parent.isEditEndDate) && !root.oneDateSelected
                                     )) //&& parent.enabled
                            z: parent.parent.z-1
                            anchors.leftMargin: parent.isEditDate ? parent.width/2 : -buttonGrid.columnSpacing - (parent.isAtLeft ? overflowArea.leftMargin : 0)
                            anchors.rightMargin: parent.isEditEndDate ? parent.width/2 : -buttonGrid.columnSpacing  - (parent.isAtRight ? overflowArea.leftMargin : 0)
                        }

                        onReleased: {
                            if (!root.selectRange) {
                                root.editDate = date
                                root.editEndDate = date
                                root._lastClickedDate = date
                            } else {
                                if (!root.shiftDown) {
                                    if (!root.oneDateSelected || date.getTime() < root.editDate.getTime()) {
                                        root.editDate = date
                                        root.editEndDate = date
                                        root._lastClickedDate = date
                                    } else {
                                        if (date.getTime() > root._lastClickedDate.getTime()) {
                                            root.editDate = root._lastClickedDate
                                            root.editEndDate = date
                                        } else {
                                            root.editDate = date
                                            root.editEndDate = root._lastClickedDate
                                        }
                                    }
                                } else {
                                    if (date.getTime() > root._lastClickedDate.getTime()) {
                                        root.editDate = root._lastClickedDate
                                        root.editEndDate = date
                                    } else {
                                        root.editDate = date
                                        root.editEndDate = root._lastClickedDate
                                    }
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
                                    if (Math.abs(position.x - beginDragPosition.x) > dragThreshold
                                            || Math.abs(position.y - beginDragPosition.y) > dragThreshold) {
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
                                            root.editDate = pressedDate
                                            root.editEndDate = hoveredDate
                                        } else {
                                            root.editDate = hoveredDate
                                            root.editEndDate = pressedDate
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
