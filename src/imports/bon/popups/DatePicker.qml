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
    property date selectedDate: date

    signal finished
    signal canceled

    Component.onCompleted: {
        selectedDate = date;
        root.closed.connect(finished);
    }

    onFinished: {
        date = selectedDate;
    }
    onCanceled: {
        selectedDate = date;
        root.close();
    }

    contentItem: OverflowArea {
        id: overflowArea
        anchors.fill: parent
        contentWidth: popupContentLayout.width

        margins: 20

        ColumnLayout {
            id: popupContentLayout
            spacing: 10

            RowLayout {
                Layout.fillWidth: true
                Layout.leftMargin: 15
                spacing: 10

                Text {
                    Layout.fillWidth: true
                    text: "Pick a date"
                    color: Theme.palette.text.heading
                    font: Theme.text.heading
                }

                Button {
                    Layout.preferredWidth: 40
                    Layout.preferredHeight: 40
                    order: 3
                    icon.name: "close"
                    onClicked: {
                        root.canceled();
                    }
                }

                Button {
                    Layout.preferredWidth: 40
                    Layout.preferredHeight: 40
                    order: 2
                    icon.name: "done"

                    onClicked: {
                        root.close();
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
                        text: date.getDate()
                        today: root.now.getDate() == date.getDate() && root.now.getMonth() == date.getMonth() && root.now.getFullYear() == date.getFullYear()
                        enabled: date.getMonth() == root._visibleMonth && date.getFullYear() == root._visibleYear

                        checkable: false
                        checked: root.selectedDate.getDate() == date.getDate() && root.selectedDate.getMonth() == date.getMonth() && root.selectedDate.getFullYear() == date.getFullYear()
                        onReleased: {
                            root.selectedDate = new Date(date.getFullYear(), date.getMonth(), date.getDate())
                        }
                    }
                }
            }
        }
    }
}
