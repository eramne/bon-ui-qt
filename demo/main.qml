import QtQuick
import QtQuick.Controls as QuickControls
import QtQuick.Layouts
import QtQuick.Window
import bon as Bon

Window {
    width: 800
    height: 600
    visible: true
    title: qsTr("Hello World")

    Bon.App {
        id: __app__

        Flickable {
            id: scrollview
            anchors.fill: parent
            contentWidth: width
            contentHeight: flow.height
            boundsBehavior: Flickable.DragOverBounds

            Flow {
                id: flow
                padding: 20
                width: parent.width
                spacing: 20

                Bon.Switch {}

                Bon.Switch {checked: true}

                Bon.Switch {enabled: false}

                Bon.Switch {checked:true; enabled: false}

                Bon.RadioButton {}

                Bon.RadioButton {checked: true}

                Bon.RadioButton {mixed: true}

                Bon.RadioButton {enabled: false}

                Bon.RadioButton {checked:true; enabled: false}

                Bon.RadioButton {mixed:true; enabled: false}

                Bon.CheckBox {}

                Bon.CheckBox {checked: true}

                Bon.CheckBox {mixed: true}

                Bon.CheckBox {enabled: false}

                Bon.CheckBox {checked:true; enabled: false}

                Bon.CheckBox {mixed:true; enabled: false}

                Item {
                    width: Layout.maximumWidth
                    height: 10
                }

                Bon.Slider {}

                Bon.Slider {enabled: false}

                Bon.Slider {orientation: Qt.Vertical}

                Bon.Slider {enabled: false; orientation: Qt.Vertical}

                Bon.Slider {
                    from: 0
                    value: 25
                    to: 100
                    stepSize: 25
                    snapMode: QuickControls.Slider.SnapAlways
                }

                Bon.Slider {
                    from: 0
                    value: 25
                    to: 100
                    stepSize: 25
                    snapMode: QuickControls.Slider.SnapAlways
                    enabled: false
                }

                Bon.Slider {
                    from: 0
                    value: 25
                    to: 100
                    stepSize: 25
                    snapMode: QuickControls.Slider.SnapAlways
                    orientation: Qt.Vertical
                }

                Bon.Slider {
                    from: 0
                    value: 25
                    to: 100
                    stepSize: 25
                    snapMode: QuickControls.Slider.SnapAlways
                    enabled: false
                    orientation: Qt.Vertical
                }

                Item {
                    width: Layout.maximumWidth
                    height: 10
                }

                Bon.ProgressBar {
                    width: 200
                    from: 0
                    to: 1
                    value: 0
                    Timer {
                        interval: 2000; running: true; repeat: true
                        onTriggered: function () {
                            interval = 500;
                            if (parent.value >= 1) {
                                parent.value = 0;
                            }
                            if (Math.random() > 0.1) {
                                parent.state = Bon.ProgressBar.State.Running
                                parent.value += Math.random()/5
                                if (parent.value >= 1) {
                                    parent.value = 1;
                                    parent.state = Math.random() > 0.5 ? Bon.ProgressBar.State.Success : Bon.ProgressBar.State.Error
                                    interval = 2000;
                                }
                            } else {
                                parent.state = Bon.ProgressBar.State.Paused
                                interval = 2000;
                            }
                        }
                    }
                }

                Bon.ProgressBar {
                    width: 200
                    from: 0
                    to: 1
                    value: 0
                    indeterminate: true
                    state: Bon.ProgressBar.State.Running
                    Timer {
                        interval: 2000; running: true; repeat: true
                        onTriggered: function () {
                            if (parent.state === Bon.ProgressBar.State.Running) {
                                var dice = Math.floor(Math.random()*3);
                                if (dice == 2) {
                                    parent.state = Bon.ProgressBar.State.Success
                                } else if (dice == 1) {
                                    parent.state = Bon.ProgressBar.State.Error
                                } else if (dice == 0) {
                                    parent.state = Bon.ProgressBar.State.Paused
                                }
                                interval = 1000;
                            } else {
                                parent.state = Bon.ProgressBar.State.Running
                                interval = 5000;
                            }
                        }
                    }
                }

                Bon.ProgressCircle {
                    from: 0
                    to: 1
                    value: 0
                    Timer {
                        interval: 2000; running: true; repeat: true
                        onTriggered: function () {
                            interval = 500;
                            if (parent.value >= 1) {
                                parent.value = 0;
                            }
                            if (Math.random() > 0.1) {
                                parent.state = Bon.ProgressCircle.State.Running
                                parent.value += Math.random()/5
                                if (parent.value >= 1) {
                                    parent.value = 1;
                                    parent.state = Math.random() > 0.5 ? Bon.ProgressCircle.State.Success : Bon.ProgressCircle.State.Error
                                    interval = 2000;
                                }
                            } else {
                                parent.state = Bon.ProgressCircle.State.Paused
                                interval = 2000;
                            }
                        }
                    }
                }

                Bon.ProgressCircle {
                    from: 0
                    to: 1
                    value: 0
                    indeterminate: true
                    state: Bon.ProgressCircle.State.Running
                    Timer {
                        interval: 2000; running: true; repeat: true
                        onTriggered: function () {
                            if (parent.state === Bon.ProgressCircle.State.Running) {
                                var dice = Math.floor(Math.random()*3);
                                if (dice == 2) {
                                    parent.state = Bon.ProgressCircle.State.Success
                                } else if (dice == 1) {
                                    parent.state = Bon.ProgressCircle.State.Error
                                } else if (dice == 0) {
                                    parent.state = Bon.ProgressCircle.State.Paused
                                }
                                interval = 1000;
                            } else {
                                parent.state = Bon.ProgressCircle.State.Running
                                interval = 5000;
                            }
                        }
                    }
                }

                Bon.ProgressCircle {
                    from: 0
                    to: 1
                    value: 0
                    small: true
                    Timer {
                        interval: 2000; running: true; repeat: true
                        onTriggered: function () {
                            interval = 500;
                            if (parent.value >= 1) {
                                parent.value = 0;
                            }
                            if (Math.random() > 0.1) {
                                parent.state = Bon.ProgressCircle.State.Running
                                parent.value += Math.random()/5
                                if (parent.value >= 1) {
                                    parent.value = 1;
                                    parent.state = Math.random() > 0.5 ? Bon.ProgressCircle.State.Success : Bon.ProgressCircle.State.Error
                                    interval = 2000;
                                }
                            } else {
                                parent.state = Bon.ProgressCircle.State.Paused
                                interval = 2000;
                            }
                        }
                    }
                }

                Bon.ProgressCircle {
                    from: 0
                    to: 1
                    value: 0
                    indeterminate: true
                    state: Bon.ProgressCircle.State.Running
                    small: true
                    Timer {
                        interval: 2000; running: true; repeat: true
                        onTriggered: function () {
                            if (parent.state === Bon.ProgressCircle.State.Running) {
                                var dice = Math.floor(Math.random()*3);
                                if (dice == 2) {
                                    parent.state = Bon.ProgressCircle.State.Success
                                } else if (dice == 1) {
                                    parent.state = Bon.ProgressCircle.State.Error
                                } else if (dice == 0) {
                                    parent.state = Bon.ProgressCircle.State.Paused
                                }
                                interval = 1000;
                            } else {
                                parent.state = Bon.ProgressCircle.State.Running
                                interval = 5000;
                            }
                        }
                    }
                }

                Item {
                    width: Layout.maximumWidth
                    height: 10
                }

                Bon.Dial {}

                Bon.Dial {enabled: false}

                Bon.Dial {showValue: true}

                Bon.Dial {enabled: false; showValue: true}

                Bon.Dial {showValue: true; snapMode: Bon.Dial.SnapAlways; stepSize: 0.1}

                Bon.Dial {enabled: false; showValue: true; snapMode: Bon.Dial.SnapAlways; stepSize: 0.1}

                Item {
                    width: Layout.maximumWidth
                    height: 10
                }

                Bon.Button {
                    order: 1
                    text: "Click me"
                }

                Bon.Button {
                    order: 1
                    text: "Click me"
                    enabled: false
                }

                Bon.Button {
                    order: 2
                    text: "Click me"
                }

                Bon.Button {
                    order: 2
                    text: "Click me"
                    enabled: false
                }

                Bon.Button {
                    order: 3
                    text: "Click me"
                }

                Bon.Button {
                    order: 3
                    text: "Click me"
                    enabled: false
                }

                Bon.Button {
                    order: 1
                    icon.name: "settings"
                    text: "Click me"
                }

                Bon.Button {
                    order: 1
                    icon.name: "settings"
                    text: "Click me"
                    enabled: false
                }

                Bon.Button {
                    order: 2
                    icon.name: "settings"
                    text: "Click me"
                }

                Bon.Button {
                    order: 2
                    icon.name: "settings"
                    text: "Click me"
                    enabled: false
                }

                Bon.Button {
                    order: 3
                    icon.name: "settings"
                    text: "Click me"
                }

                Bon.Button {
                    order: 3
                    icon.name: "settings"
                    text: "Click me"
                    enabled: false
                }

                Bon.Button {
                    order: 1
                    icon.name: "settings"
                }

                Bon.Button {
                    order: 1
                    icon.name: "settings"
                    enabled: false
                }

                Bon.Button {
                    order: 2
                    icon.name: "settings"
                }

                Bon.Button {
                    order: 2
                    icon.name: "settings"
                    enabled: false
                }

                Bon.Button {
                    order: 3
                    icon.name: "settings"
                }

                Bon.Button {
                    order: 3
                    icon.name: "settings"
                    enabled: false
                }

                Bon.ToggleButton {
                    checked: true
                    icon.name: "format_bold"
                }

                Bon.ToggleButton {
                    checked: true
                    icon.name: "format_italic"
                    enabled: false
                }

                Bon.ToggleButton {
                    icon.name: "format_underlined"
                }

                Bon.ToggleButton {
                    icon.name: "strikethrough_s"
                    enabled: false
                }

                Bon.SmallIconButton {
                    offIcon: "star"
                }

                Bon.SmallIconButton {
                    offIcon: "star"
                    enabled: false
                }

                Bon.SmallIconButton {
                    offIcon: "star_border"
                    onIcon: "star"
                    checkable: true
                }

                Bon.SmallIconButton {
                    offIcon: "star_border"
                    onIcon: "star"
                    checkable: true
                    enabled: false
                }

                /*Bon.SmallIconButton {
                    offIcon: "star"
                    dark: true
                }

                Bon.SmallIconButton {
                    offIcon: "star"
                    enabled: false
                    dark: true
                }

                Bon.SmallIconButton {
                    offIcon: "star_border"
                    onIcon: "star"
                    checkable: true
                    dark: true
                }

                Bon.SmallIconButton {
                    offIcon: "star_border"
                    onIcon: "star"
                    checkable: true
                    enabled: false
                    dark: true
                }*/

                Bon.DateButton {
                    checked: true
                    text: "31"
                }

                Bon.DateButton {
                    checked: true
                    text: "31"
                    enabled: false
                }

                Bon.DateButton {
                    today: true
                    text: "31"
                }

                Bon.DateButton {
                    today: true
                    text: "31"
                    enabled: false
                }

                Bon.DateButton {
                    text: "31"
                }

                Bon.DateButton {
                    text: "31"
                    enabled: false
                }

                Bon.DateButton {
                    rangeSelected: true
                    text: "31"
                }

                Bon.DateButton {
                    rangeSelected: true
                    text: "31"
                    enabled: false
                }
            }
        }

        /*QuickControls.ScrollView {
            anchors.fill: parent

            Column {
                padding: 20
                anchors.fill: parent
                spacing: 50

                Text {
                    text: "Display"
                    color: __app__.style.palette.text.heading
                    font: __app__.style.text.display
                }

                Text {
                    text: "Display 2"
                    color: __app__.style.palette.text.heading
                    font: __app__.style.text.display_2
                }

                Text {
                    text: "Title"
                    color: __app__.style.palette.text.heading
                    font: __app__.style.text.title
                }

                Text {
                    text: "Subtitle"
                    color: __app__.style.palette.text.heading
                    font: __app__.style.text.subtitle
                }

                Text {
                    text: "Section"
                    color: __app__.style.palette.text.heading
                    font: __app__.style.text.section
                }

                Text {
                    text: "Section 2"
                    color: __app__.style.palette.text.heading
                    font: __app__.style.text.section_2
                }

                Text {
                    text: "Section 3"
                    color: __app__.style.palette.text.heading
                    font: __app__.style.text.section_3
                }

                Text {
                    text: "Heading"
                    color: __app__.style.palette.text.heading
                    font: __app__.style.text.heading
                }

                Text {
                    text: "Subheading"
                    color: __app__.style.palette.text.heading
                    font: __app__.style.text.subheading
                }

                Text {
                    text: "Body"
                    color: __app__.style.palette.text.body
                    font: __app__.style.text.body
                }

                Text {
                    text: "Label"
                    color: __app__.style.palette.text.label
                    font: __app__.style.text.label
                }

                Text {
                    text: "Caption"
                    color: __app__.style.palette.text.label
                    font: __app__.style.text.caption
                }

                Text {
                    text: "Overline"
                    color: __app__.style.palette.text.overline
                    font: __app__.style.text.overline
                }

                Text {
                    text: "Button"
                    color: __app__.style.palette.text.label
                    font: __app__.style.text.button
                }
            }
        }*/

        /*Flow {
            id: flow
            property var elevations: [1,2,3,4,6,8,9,12,16,24]
            padding: 20
            anchors.fill: parent
            spacing: 60
            Repeater {
                model: flow.elevations.length

                Item {
                    width: 40+40*(index/4)
                    height: width

                    Bon.Elevation {
                        anchors.fill: rect
                        radius: rect.radius
                        elevation: flow.elevations[index]
                        z: -1
                    }

                    Rectangle {
                        id: rect
                        radius: 8
                        anchors.fill: parent
                        //color: "#0A2E45"
                        color: "#FEFBFA"
                    }
                }
            }
        }*/
    }
}
