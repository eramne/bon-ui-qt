import QtQuick
import QtQuick.Layouts
import bon as B

B.Dropdown {
    id: root

    targetWidth: popupContentLayout.width + overflowArea.leftMargin + overflowArea.rightMargin
    targetHeight: popupContentLayout.height + overflowArea.topMargin + overflowArea.bottomMargin

    property bool twentyFourHour: false
    property bool showSeconds: false

    property date time: new Date()
    property date editTime: time

    signal finished
    signal canceled

    Timer {
        interval: 0; running: true; repeat: false
        onTriggered: editTime = time
    }

    Component.onCompleted: {
        //editTime = time
        root.closed.connect(finished)
    }

    onFinished: {
        time = editTime
    }
    onCanceled: {
        editTime = time
        root.close()
    }

    contentItem: B.OverflowArea {
        id: overflowArea
        anchors.fill: parent
        contentWidth: popupContentLayout.width

        margins: 20

        Rectangle {
            height: 40
            width: -x*2 + hourTumbler.width + tumblerRow.spacing + minuteTumbler.width + (root.showSeconds ? tumblerRow.spacing + secondsTumbler.width : 0)
            x: -5
            y: tumblerRow.y + hourTumbler.height/2 - height/2
            radius: Math.max(width,height)/2
            color: B.Theme.palette.accent
        }

        ColumnLayout {
            id: popupContentLayout
            spacing: 10

            RowLayout {
                Layout.fillWidth: true
                spacing: 10

                B.HeadingText {
                    Layout.fillWidth: true
                    text: "Pick a time"
                }

                B.Button {
                    Layout.preferredWidth: width
                    Layout.preferredHeight: height
                    order: 3
                    icon.name: "close"
                    onClicked: {
                        root.canceled();
                    }
                }

                B.Button {
                    Layout.preferredWidth: width
                    Layout.preferredHeight: height
                    order: 2
                    icon.name: "done"

                    onClicked: {
                        root.close();
                    }
                }
            }

            RowLayout {
                id: tumblerRow
                Layout.fillWidth: true
                spacing: 20

                ColumnLayout {
                    width: hourTumbler.width
                    spacing: 10

                    B.Tumbler {
                        id: hourTumbler
                        model: ListModel {}

                        Layout.preferredHeight: height

                        Component.onCompleted: {
                            updateHourModel()
                            updateTumblerIndex()
                            root.onTwentyFourHourChanged.connect(updateHourModel)
                            root.onEditTimeChanged.connect(updateTumblerIndex)
                        }

                        onCurrentIndexChanged: {
                            updateEnteredTime()
                        }

                        //handling 12 hour times is so confusing aaa
                        //my brain hurts its so hard to visualize this in my head and understand it
                        //is 12am midnight or noon
                        //and the indexes count from 0, 0 is hour 1, 1 is hour 2, and i keep needing
                        //to adjust for that by adding or subtracting 1 from whatever things i need
                        //to and its just so confusing aa

                        //and for whatever goddamn reason using the Date's setHour() function
                        //isn't setting the goddamn date's hour, and i have to make a new
                        //temporary date variable and set that temp variable's hour value and
                        //assign the temp variable to the date and i have no clue why

                        //i wish people just used 24 hour time

                        function updateEnteredTime() {
                            if (root.twentyFourHour) {
                                var tmpDate2 = root.editTime
                                tmpDate2.setHours(currentIndex)
                                root.editTime = tmpDate2
                            } else {
                                if (amOption.checked) {
                                    var tmpDate = root.editTime
                                    var tmpHour = 0
                                    if (currentIndex === 11) { //if selected hour is 12, 12AM should be midnight, or hour 0 in a 24 hour clock
                                        tmpHour = 0
                                    } else {
                                        tmpHour = currentIndex + 1
                                    }
                                    tmpDate.setHours(tmpHour)
                                    root.editTime = tmpDate
                                } else {
                                    var tmpDate1 = root.editTime
                                    var tmpHour1 = 0
                                    if (currentIndex === 11) { //if selected hour is 12, 12PM should be noon, or hour 12 in a 24 hour clock
                                        tmpHour1 = 12
                                    } else {
                                        tmpHour1 = 12 + currentIndex + 1
                                    }
                                    tmpDate1.setHours(tmpHour1)
                                    root.editTime = tmpDate1
                                }
                            }
                        }

                        function updateTumblerIndex() {
                            var hours = root.editTime.getHours()
                            if (root.twentyFourHour) {
                                currentIndex = hours
                            } else {
                                if (hours <= 11) {
                                    currentIndex = hours === 0 ? 11 : hours - 1 //if 24hr hour is 0, 12hr hour is 12 (index = 11), otherwise 24hr hour = 12hr hour (index = 12hr hour - 1)
                                    amOption.checked = true
                                    pmOption.checked = false
                                } else {
                                    currentIndex = hours === 12 ? 11 : (hours-12) - 1 //if 24hr hour is 12, 12hr hour is 12 (index = 11), otherwise 12hr hour (index = 12hr hour - 1) = 24hr - 12
                                    amOption.checked = false
                                    pmOption.checked = true
                                }
                            }
                        }

                        function updateHourModel() {
                            if (root.twentyFourHour) {
                                for (var i = 0; i <= 23; i++) {
                                    model.append({'modelData': i})
                                }
                            } else {
                                for (var j = 1; j <= 12; j++) {
                                    model.append({'modelData': j})
                                }
                            }
                        }
                    }

                    B.NumberField {
                        id: hourNumberField
                        width: hourTumbler.width
                        from: root.twentyFourHour ? 0 : 1
                        to: root.twentyFourHour ? 23 : 12

                        Component.onCompleted: {
                            hourTumbler.onCurrentIndexChanged.connect(updateValue)
                            updateValue()
                        }

                        function updateValue() {
                            if (root.twentyFourHour) {
                                value = hourTumbler.currentIndex
                            } else {
                                value = hourTumbler.currentIndex + 1
                            }
                        }

                        onValueChanged: {
                            if (root.twentyFourHour) {
                                hourTumbler.currentIndex = value
                            } else {
                                hourTumbler.currentIndex = value - 1
                            }
                        }
                    }
                }

                ColumnLayout {
                    width: minuteTumbler.width
                    spacing: 10

                    B.Tumbler {
                        id: minuteTumbler
                        model: 60
                        Layout.preferredHeight: height

                        Component.onCompleted: {
                            updateTumblerIndex()
                            root.onEditTimeChanged.connect(updateTumblerIndex)
                        }

                        onCurrentIndexChanged: {
                            updateEnteredTime()
                        }

                        function updateEnteredTime() {
                            var tmpDate = root.editTime
                            tmpDate.setMinutes(currentIndex)
                            root.editTime = tmpDate
                        }

                        function updateTumblerIndex() {
                            currentIndex = root.editTime.getMinutes()
                        }
                    }

                    B.NumberField {
                        id: minuteNumberField
                        width: minuteTumbler.width
                        from: 0
                        to: 59

                        Component.onCompleted: {
                            minuteTumbler.onCurrentIndexChanged.connect(updateValue)
                            updateValue()
                        }

                        function updateValue() {
                            value = minuteTumbler.currentIndex
                        }

                        onValueChanged: {
                            minuteTumbler.currentIndex = value
                        }
                    }
                }

                ColumnLayout {
                    width: secondsTumbler.width
                    visible: root.showSeconds
                    spacing: 10

                    B.Tumbler {
                        id: secondsTumbler
                        model: 60
                        Layout.preferredHeight: height

                        Component.onCompleted: {
                            updateTumblerIndex()
                            root.onEditTimeChanged.connect(updateTumblerIndex)
                        }

                        onCurrentIndexChanged: {
                            updateEnteredTime()
                        }

                        function updateEnteredTime() {
                            var tmpDate = root.editTime
                            tmpDate.setSeconds(currentIndex)
                            root.editTime = tmpDate
                        }

                        function updateTumblerIndex() {
                            currentIndex = root.editTime.getSeconds()
                        }
                    }

                    B.NumberField {
                        id: secondsNumberField
                        width: secondsTumbler.width
                        from: 0
                        to: 59

                        Component.onCompleted: {
                            secondsTumbler.onCurrentIndexChanged.connect(updateValue)
                            updateValue()
                        }

                        function updateValue() {
                            value = secondsTumbler.currentIndex
                        }

                        onValueChanged: {
                            secondsTumbler.currentIndex = value
                        }
                    }
                }

                Item {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.minimumWidth: 50
                    visible: !root.twentyFourHour

                    B.Choice {
                        width: 50
                        anchors.bottom: parent.bottom
                        anchors.right: parent.right
                        exclusive: true

                        B.Option {
                            id: amOption
                            width: 100
                            checked: true
                            name: Qt.locale().amText

                            onCheckedChanged: {
                                hourTumbler.updateEnteredTime()
                            }
                        }
                        B.Option {
                            id: pmOption
                            width: 100
                            name: Qt.locale().pmText

                            onCheckedChanged: {
                                hourTumbler.updateEnteredTime()
                            }
                        }
                    }
                }
            }
        }
    }
}
