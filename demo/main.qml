import QtQuick
import QtQuick.Controls as C
import QtQuick.Layouts
import QtQuick.Window
import bon as B

Window {
    width: 800
    height: 600
    visible: true
    title: qsTr("umagos")

    B.App {

        StackLayout {
            anchors.fill: parent
            currentIndex: 0

            /*focus: true
            Keys.onReleased: (event) => {
                                if (event.key >= Qt.Key_0 && event.key <= Qt.Key_9) {
                                    currentIndex = event.key - Qt.Key_0;
                                }
                            }*/

            B.OverflowArea {
                id: scrollview
                margins: 0

                Flow {
                    id: flow
                    padding: 40
                    width: scrollview.width - scrollview.leftMargin - scrollview.rightMargin
                    spacing: 20

                    B.Divider {
                        width: parent.width
                        leftInset: -parent.leftPadding
                        name: "Switches"
                    }

                    B.Switch {}

                    B.Switch {checked: true}

                    B.Switch {enabled: false}

                    B.Switch {checked:true; enabled: false}

                    B.Divider {
                        width: parent.width
                        leftInset: -parent.leftPadding
                        name: "Radio Buttons"
                    }

                    B.RadioButton {}

                    B.RadioButton {checked: true}

                    B.RadioButton {mixed: true}

                    B.RadioButton {enabled: false}

                    B.RadioButton {checked:true; enabled: false}

                    B.RadioButton {mixed:true; enabled: false}

                    B.Divider {
                        width: parent.width
                        leftInset: -parent.leftPadding
                        name: "Checkboxes"
                    }

                    B.CheckBox {}

                    B.CheckBox {checked: true}

                    B.CheckBox {mixed: true}

                    B.CheckBox {enabled: false}

                    B.CheckBox {checked:true; enabled: false}

                    B.CheckBox {mixed:true; enabled: false}

                    B.Divider {
                        width: parent.width
                        leftInset: -parent.leftPadding
                        name: "Sliders"
                    }

                    B.Slider {}

                    B.Slider {enabled: false}

                    B.Slider {orientation: Qt.Vertical}

                    B.Slider {enabled: false; orientation: Qt.Vertical}

                    B.Slider {
                        from: 0
                        value: 25
                        to: 100
                        stepSize: 25
                        snapMode: C.Slider.SnapAlways
                    }

                    B.Slider {
                        from: 0
                        value: 25
                        to: 100
                        stepSize: 25
                        snapMode: C.Slider.SnapAlways
                        enabled: false
                    }

                    B.Slider {
                        from: 0
                        value: 25
                        to: 100
                        stepSize: 25
                        snapMode: C.Slider.SnapAlways
                        orientation: Qt.Vertical
                    }

                    B.Slider {
                        from: 0
                        value: 25
                        to: 100
                        stepSize: 25
                        snapMode: C.Slider.SnapAlways
                        enabled: false
                        orientation: Qt.Vertical
                    }

                    B.Divider {
                        width: parent.width
                        leftInset: -parent.leftPadding
                        name: "Progress"
                    }

                    B.ProgressBar {
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
                                    parent.state = B.ProgressBar.State.Running
                                    parent.value += Math.random()/5
                                    if (parent.value >= 1) {
                                        parent.value = 1;
                                        parent.state = Math.random() > 0.5 ? B.ProgressBar.State.Success : B.ProgressBar.State.Error
                                        interval = 2000;
                                    }
                                } else {
                                    parent.state = B.ProgressBar.State.Paused
                                    interval = 2000;
                                }
                            }
                        }
                    }

                    B.ProgressBar {
                        width: 200
                        from: 0
                        to: 1
                        value: 0
                        indeterminate: true
                        state: B.ProgressBar.State.Running
                        Timer {
                            interval: 2000; running: true; repeat: true
                            onTriggered: function () {
                                if (parent.state === B.ProgressBar.State.Running) {
                                    var dice = Math.floor(Math.random()*3);
                                    if (dice == 2) {
                                        parent.state = B.ProgressBar.State.Success
                                    } else if (dice == 1) {
                                        parent.state = B.ProgressBar.State.Error
                                    } else if (dice == 0) {
                                        parent.state = B.ProgressBar.State.Paused
                                    }
                                    interval = 1000;
                                } else {
                                    parent.state = B.ProgressBar.State.Running
                                    interval = 5000;
                                }
                            }
                        }
                    }

                    B.ProgressCircle {
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
                                    parent.state = B.ProgressCircle.State.Running
                                    parent.value += Math.random()/5
                                    if (parent.value >= 1) {
                                        parent.value = 1;
                                        parent.state = Math.random() > 0.5 ? B.ProgressCircle.State.Success : B.ProgressCircle.State.Error
                                        interval = 2000;
                                    }
                                } else {
                                    parent.state = B.ProgressCircle.State.Paused
                                    interval = 2000;
                                }
                            }
                        }
                    }

                    B.ProgressCircle {
                        from: 0
                        to: 1
                        value: 0
                        indeterminate: true
                        state: B.ProgressCircle.State.Running
                        Timer {
                            interval: 2000; running: true; repeat: true
                            onTriggered: function () {
                                if (parent.state === B.ProgressCircle.State.Running) {
                                    var dice = Math.floor(Math.random()*3);
                                    if (dice == 2) {
                                        parent.state = B.ProgressCircle.State.Success
                                    } else if (dice == 1) {
                                        parent.state = B.ProgressCircle.State.Error
                                    } else if (dice == 0) {
                                        parent.state = B.ProgressCircle.State.Paused
                                    }
                                    interval = 1000;
                                } else {
                                    parent.state = B.ProgressCircle.State.Running
                                    interval = 5000;
                                }
                            }
                        }
                    }

                    B.ProgressCircle {
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
                                    parent.state = B.ProgressCircle.State.Running
                                    parent.value += Math.random()/5
                                    if (parent.value >= 1) {
                                        parent.value = 1;
                                        parent.state = Math.random() > 0.5 ? B.ProgressCircle.State.Success : B.ProgressCircle.State.Error
                                        interval = 2000;
                                    }
                                } else {
                                    parent.state = B.ProgressCircle.State.Paused
                                    interval = 2000;
                                }
                            }
                        }
                    }

                    B.ProgressCircle {
                        from: 0
                        to: 1
                        value: 0
                        indeterminate: true
                        state: B.ProgressCircle.State.Running
                        small: true
                        Timer {
                            interval: 2000; running: true; repeat: true
                            onTriggered: function () {
                                if (parent.state === B.ProgressCircle.State.Running) {
                                    var dice = Math.floor(Math.random()*3);
                                    if (dice == 2) {
                                        parent.state = B.ProgressCircle.State.Success
                                    } else if (dice == 1) {
                                        parent.state = B.ProgressCircle.State.Error
                                    } else if (dice == 0) {
                                        parent.state = B.ProgressCircle.State.Paused
                                    }
                                    interval = 1000;
                                } else {
                                    parent.state = B.ProgressCircle.State.Running
                                    interval = 5000;
                                }
                            }
                        }
                    }

                    B.Divider {
                        width: parent.width
                        leftInset: -parent.leftPadding
                        name: "Dials"
                    }

                    B.Dial {}

                    B.Dial {enabled: false}

                    B.Dial {showValue: true}

                    B.Dial {enabled: false; showValue: true}

                    B.Dial {showValue: true; snapMode: B.Dial.SnapAlways; stepSize: 0.1}

                    B.Dial {enabled: false; showValue: true; snapMode: B.Dial.SnapAlways; stepSize: 0.1}

                    B.Divider {
                        width: parent.width
                        leftInset: -parent.leftPadding
                        name: "Buttons"
                    }

                    B.Button {
                        order: 1
                        text: "Click me"
                    }

                    B.Button {
                        order: 1
                        text: "Click me"
                        enabled: false
                    }

                    B.Button {
                        order: 2
                        text: "Click me"
                    }

                    B.Button {
                        order: 2
                        text: "Click me"
                        enabled: false
                    }

                    B.Button {
                        order: 3
                        text: "Click me"
                    }

                    B.Button {
                        order: 3
                        text: "Click me"
                        enabled: false
                    }

                    B.Button {
                        order: 1
                        icon.name: "settings"
                        text: "Click me"
                    }

                    B.Button {
                        order: 1
                        icon.name: "settings"
                        text: "Click me"
                        enabled: false
                    }

                    B.Button {
                        order: 2
                        icon.name: "settings"
                        text: "Click me"
                    }

                    B.Button {
                        order: 2
                        icon.name: "settings"
                        text: "Click me"
                        enabled: false
                    }

                    B.Button {
                        order: 3
                        icon.name: "settings"
                        text: "Click me"
                    }

                    B.Button {
                        order: 3
                        icon.name: "settings"
                        text: "Click me"
                        enabled: false
                    }

                    B.Button {
                        order: 1
                        icon.name: "settings"
                    }

                    B.Button {
                        order: 1
                        icon.name: "settings"
                        enabled: false
                    }

                    B.Button {
                        order: 2
                        icon.name: "settings"
                    }

                    B.Button {
                        order: 2
                        icon.name: "settings"
                        enabled: false
                    }

                    B.Button {
                        order: 3
                        icon.name: "settings"
                    }

                    B.Button {
                        order: 3
                        icon.name: "settings"
                        enabled: false
                    }

                    B.ToggleButton {
                        checked: true
                        icon.name: "format_bold"
                    }

                    B.ToggleButton {
                        checked: true
                        icon.name: "format_italic"
                        enabled: false
                    }

                    B.ToggleButton {
                        icon.name: "format_underlined"
                    }

                    B.ToggleButton {
                        icon.name: "strikethrough_s"
                        enabled: false
                    }

                    B.SmallIconButton {
                        offIcon: "star"
                    }

                    B.SmallIconButton {
                        offIcon: "star"
                        enabled: false
                    }

                    B.SmallIconButton {
                        offIcon: "star_border"
                        onIcon: "star"
                        checkable: true
                    }

                    B.SmallIconButton {
                        offIcon: "star_border"
                        onIcon: "star"
                        checkable: true
                        enabled: false
                    }

                    B.DateButton {
                        checked: true
                        text: "31"
                    }

                    B.DateButton {
                        checked: true
                        text: "31"
                        enabled: false
                    }

                    B.DateButton {
                        today: true
                        text: "31"
                    }

                    B.DateButton {
                        today: true
                        text: "31"
                        enabled: false
                    }

                    B.DateButton {
                        text: "31"
                    }

                    B.DateButton {
                        text: "31"
                        enabled: false
                    }

                    B.DateButton {
                        rangeSelected: true
                        text: "31"
                    }

                    B.DateButton {
                        rangeSelected: true
                        text: "31"
                        enabled: false
                    }

                    B.Divider {
                        width: parent.width
                        leftInset: -parent.leftPadding
                        name: "Chips"
                    }

                    B.InputChip {
                        text: "Favorites"
                        onClosed: {
                            visible = false;
                        }
                    }

                    B.InputChip {
                        text: "Nature"
                        enabled: false
                        onClosed: {
                            visible = false;
                        }
                    }

                    B.InputChip {
                        text: "Mountains"
                        icon.name: "terrain"
                        onClosed: {
                            visible = false;
                        }
                    }

                    B.InputChip {
                        text: "Portraits"
                        enabled: false
                        icon.name: "portrait"
                        onClosed: {
                            visible = false;
                        }
                    }

                    B.ChoiceChip {
                        text: "Option 1"
                    }

                    B.ChoiceChip {
                        text: "Option 2"
                        enabled: false
                    }

                    B.ChoiceChip {
                        text: "Option 3"
                        icon.name: "dashboard"
                    }

                    B.ChoiceChip {
                        text: "Option 4"
                        enabled: false
                        icon.name: "dashboard"
                    }

                    B.FilterChip {
                        text: "Favorites"
                    }

                    B.FilterChip {
                        text: "Nature"
                        enabled: false
                    }

                    B.ActionChip {
                        text: "Action 1"

                        onClicked: {
                            console.log("Running action 1");
                        }
                    }

                    B.ActionChip {
                        text: "Action 2"
                        enabled: false

                        onClicked: {
                            console.log("Running action 2");
                        }
                    }

                    B.ActionChip {
                        text: "Action 3"
                        icon.name: "play_arrow"

                        onClicked: {
                            console.log("Running action 3");
                        }
                    }

                    B.ActionChip {
                        text: "Action 4"
                        enabled: false
                        icon.name: "stop"

                        onClicked: {
                            console.log("Running action 4");
                        }
                    }

                    B.Divider {
                        width: parent.width
                        leftInset: -parent.leftPadding
                        name: "Text Fields"
                    }

                    B.TextField {
                        field.placeholderText: "Enter name"
                    }

                    B.TextField {
                        field.placeholderText: "Enter name"
                        enabled: false
                    }

                    B.TextField {
                        field.placeholderText: "Enter name"
                        buttonIcon: field.length > 0 ? "cancel" : ""
                        onIconClicked: {
                            field.text = "";
                        }
                    }

                    B.TextField {
                        field.placeholderText: "Enter name"
                        buttonIcon: field.length > 0 ? "cancel" : ""
                        enabled: false
                        onIconClicked: {
                            field.text = "";
                        }
                    }

                    B.TextField {
                        field.placeholderText: "Enter an amount"
                        field.validator: DoubleValidator {}
                        buttonIcon: field.length > 0 ? "cancel" : ""
                        showStatus: true
                        onIconClicked: {
                            field.text = "";
                        }
                    }

                    B.TextField {
                        field.placeholderText: "Enter an amount"
                        field.validator: DoubleValidator {}
                        buttonIcon: field.length > 0 ? "cancel" : ""
                        showStatus: true
                        onIconClicked: {
                            field.text = "";
                        }
                    }

                    B.TextField {
                        field.placeholderText: "Enter name"
                        leadingIcon: "face"
                    }

                    B.TextField {
                        field.placeholderText: "Enter name"
                        enabled: false
                        leadingIcon: "face"
                    }

                    B.TextField {
                        field.placeholderText: "1.00"
                        prefixText: "$"
                    }

                    B.TextField {
                        field.placeholderText: "john.doe"
                        suffixText: "@gmail.com"
                    }

                    B.TextField {
                        field.placeholderText: "Enter name"
                        helpText: "Helper Text"
                    }

                    B.TextField {
                        field.placeholderText: "Enter name"
                        field.maximumLength: 20
                        showCharacterCount: true
                    }

                    B.TextField {
                        field.placeholderText: "Enter name"
                        helpText: "Helper Text"
                        field.maximumLength: 20
                        showCharacterCount: true
                    }

                    B.TextField {
                        field.placeholderText: "Enter name"
                        labelText: "First name"
                    }

                    B.TextField {
                        labelText: "Email address*"
                        field.placeholderText: "jon.doe@gmail.com"
                        helpText: "*Required"
                    }

                    B.TextField {
                        field.placeholderText: "Enter an amount*"
                        labelText: "Amount to donate"
                        field.validator: DoubleValidator {}
                        buttonIcon: field.length > 0 ? "cancel" : ""
                        onIconClicked: {
                            field.text = "";
                        }
                        prefixText: "$"
                        suffixText: "USD"
                        helpText: "*Required"
                        successText: "Good"
                        errorText: "Invalid amount"
                        field.onAccepted: showStatus = true
                    }

                    B.Divider {
                        width: parent.width
                        leftInset: -parent.leftPadding
                        name: "Text Areas"
                    }

                    B.TextArea {
                        enabled: false
                        area.placeholderText: "Enter message"
                    }

                    B.TextArea {
                        area.placeholderText: "Enter message"
                    }

                    B.TextArea {
                        area.placeholderText: "Enter message"
                        wordWrap: true
                    }

                    B.TextArea {
                        area.placeholderText: "Enter message"
                        helpText: "Required"
                    }

                    B.TextArea {
                        labelText: "Message"
                        area.placeholderText: "Enter message"
                    }

                    B.TextArea {
                        labelText: "Message*"
                        helpText: "*Required"
                        showCharacterCount: true
                        area.placeholderText: "Enter message"
                    }

                    B.TextArea {
                        area.placeholderText: "Enter message"
                        bordered: false
                    }

                    B.Divider {
                        width: parent.width
                        leftInset: -parent.leftPadding
                        name: "Number Fields"
                    }

                    B.NumberField {
                        value: 5
                    }

                    B.NumberField {
                        value: 5
                        from: 0
                        to: 100
                        stepSize: 12
                    }

                    B.NumberField {
                        value: 5
                        wrap: true
                        from: 0
                        to: 100
                        stepSize: 12
                    }

                    B.NumberField {
                        value: 5
                        showStepButtons: true
                    }

                    B.NumberField {
                        value: 5
                        showStepButtons: true
                        from: 0
                        to: 100
                        stepSize: 12
                    }

                    B.NumberField {
                        value: 5
                        showStepButtons: true
                        wrap: true
                        from: 0
                        to: 100
                        stepSize: 12
                    }

                    B.NumberField {
                        value: 5
                        showStepButtons: true
                        from: 0
                        to: 100
                        stepSize: 1
                        wrap: true
                        editable: false
                    }

                    B.Divider {
                        width: parent.width
                        leftInset: -parent.leftPadding
                        name: "Combo Boxes"
                    }

                    B.ComboBox {
                        id: combobox1

                        model: [
                            { name: "Point" },
                            { name: "Line" },
                            { name: "Line Segment" },
                            { name: "Ray" },
                            { name: "Triangle" },
                            { name: "Square" },
                            { name: "Rectangle" },
                            { name: "Rhombus" },
                            { name: "Parallelogram" },
                            { name: "Trapezoid" },
                            { name: "Pentagon" },
                            { name: "Hexagon" },
                            { name: "Octagon" },
                            { name: "Polygon" },
                            { name: "Circle" },
                            { name: "Semicircle" },
                            { name: "Arc" },
                            { name: "Plane" },
                            { name: "Triangular Prism" },
                            { name: "Rectangular Prism" },
                            { name: "Cube" },
                            { name: "Pentagonal Prism" },
                            { name: "Hexagonal Prism" },
                            { name: "Prism" },
                            { name: "Tetrahedron" },
                            { name: "Octahedron" },
                            { name: "Dodecahedron" },
                            { name: "Icosahedron" },
                            { name: "Sphere" },
                            { name: "Dome" },
                            { name: "Empty" }
                        ]
                    }

                    B.ComboBox {
                        model: combobox1.model
                        editable: false
                    }

                    B.ComboBox {
                        model: combobox1.model
                        labelText: "Choose a shape"
                        helpText: "Optional"
                    }

                    B.Divider {
                        width: parent.width
                        leftInset: -parent.leftPadding
                        name: "Ratings"
                    }

                    B.Rating {

                    }

                    B.Rating {
                        editable: false
                        displayValue: 2.35
                    }

                    B.Rating {
                        enabled: false
                    }

                    B.Divider {
                        width: parent.width
                        leftInset: -parent.leftPadding
                        name: "Color Swatches"
                    }

                    B.ColorSwatch {

                    }

                    B.ColorSwatch {
                        color: "#cc66788A"
                    }

                    B.ColorSwatch {
                        color: "#74D2D8"
                    }

                    B.ColorSwatch {
                        color: "#D1B4B4"
                    }

                    B.ColorSwatch {
                        color: "#D1B4B4"
                        enabled: false
                    }

                    B.Divider {
                        width: parent.width
                        leftInset: -parent.leftPadding
                        name: "Toggle Buttons"
                    }

                    B.ToggleButtonGroup {
                        B.ToggleButton {
                            checked: true
                            icon.name: "format_bold"
                        }
                        B.ToggleButton {
                            checked: false
                            enabled: false
                            icon.name: "format_italic"
                        }
                        B.ToggleButton {
                            checked: false
                            icon.name: "format_underline"
                        }
                    }

                    B.Divider {
                        width: parent.width
                        leftInset: -parent.leftPadding
                        name: "Single Options"
                    }

                    B.Option {
                        name: "Option 1"
                        width: 300
                    }

                    B.Option {
                        name: "Option 1"
                        enabled: false
                        width: 300
                    }

                    B.Option {
                        name: "Option 1"
                        width: 300
                        exclusive: true
                    }

                    B.Option {
                        name: "Option 1"
                        enabled: false
                        width: 300
                        exclusive: true
                    }

                    B.Divider {
                        width: parent.width
                        leftInset: -parent.leftPadding
                        name: "Multiple Choices"
                    }

                    B.Choice {
                        width: 300

                        B.Option {
                            name: "Option 1"
                        }

                        B.Option {
                            name: "Option 2"
                        }

                        B.Option {
                            name: "Option 3"
                        }
                    }

                    B.Choice {
                        width: 300
                        exclusive: true

                        B.Option {
                            name: "Option 1"
                        }

                        B.Option {
                            name: "Option 2"
                        }

                        B.Option {
                            name: "Option 3"
                        }
                    }

                    B.Divider {
                        width: parent.width
                        leftInset: -parent.leftPadding
                        name: "Tumblers"
                    }

                    B.Tumbler {
                        model: 60
                    }

                    B.Tumbler {
                        orientation: Qt.Horizontal
                        model: 60
                    }

                    B.Divider {
                        width: parent.width
                        leftInset: -parent.leftPadding
                        name: "Pickers"
                    }

                    B.ColorField {
                        currentColor: "#e16c88"
                    }

                    B.DateField {

                    }

                    B.DateField {
                        selectRange: true
                    }

                    B.TimeField {

                    }

                    B.TimeField {
                        twentyFourHour: true
                    }

                    B.TimeField {
                        showSeconds: true
                    }

                    B.TimeField {
                        twentyFourHour: true
                        showSeconds: true
                    }

                    B.Divider {
                        width: parent.width
                        leftInset: -parent.leftPadding
                        name: "List"
                    }

                    B.List {
                        id: list1
                        width: 400

                        model: [
                            {name: "hi"},
                            {name: "test", caption: "caption test", showDivider: true},
                            {name: "the", overline: "tech"},
                            {name: "an", leading: B.ListLeading.icon({name: "home"})},
                            {name: "goenfdj", leading: B.ListLeading.avatar({source: "https://pbs.twimg.com/profile_images/1466199778598047749/sdljjuYA_400x400.jpg"})},
                            {name: "chrimsntas yayaya", caption: "Lorem ipsum dolor sit amet",  overline: "breaking", leading: B.ListLeading.thumbnail({source: "https://picography.co/wp-content/uploads/2017/12/xmas-bokeh-lights-768x525.jpg"})},
                            {name: "hi", showDivider: true, sectionName: "Heading"},
                            {name: "test", trailing: B.ListTrailing.caption({text: "Caption"})},
                            {name: "the", trailing: B.ListTrailing.icon({name: "arrow_right"})},
                            {name: "a", trailing: B.ListTrailing.item({component: listRadioButton}) },
                            {name: "b", trailing: B.ListTrailing.item({component: listRadioButton}) },
                            {name: "c", trailing: B.ListTrailing.item({component: listRadioButton}) },
                            {name: "d", trailing: B.ListTrailing.item({component: listRadioButton}) },
                            {name: "e", trailing: B.ListTrailing.item({component: listRadioButton}) },
                            {name: "goenfdj", caption: "Lorem ipsum dolor sit amet, consectetur adsipling elit, the quick brown fox jumps over the lazy dog, etc"},
                            {name: "cataaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa", caption: "Lorem ipsum dolor sit amet, consectetur adsipling elit, the quick brown fox jumps over the lazy dog, etc nhioteshbtugboiutewbioutwbhitw go tsh tsh t h rsth rst hsoeige bo bo bou we", trailing: B.ListTrailing.caption({text: "aaaaaaa"})},
                            {name: "hi"},
                            {name: "test"},
                            {name: "the"},
                            {name: "an"},
                            {name: "goenfdj"},
                            {name: "cat"}
                        ]

                        C.ButtonGroup {
                            id: listButtonGroupTest
                            exclusive: true
                        }

                        Component {
                            id: listRadioButton

                            B.RadioButton {
                                //opacity: (parent.parent.parent.index%3)/4+1/4

                                C.ButtonGroup.group: listButtonGroupTest
                            }
                        }
                    }

                    B.List {
                        model: list1.model
                        compact: true
                    }

                    B.List {
                        model: [
                            {name: "item", showDivider: true, sectionName: "Heading"},
                            {name: "a"},
                            {name: "abc123"},
                            {name: "hgend"},
                            {name: "cat"},
                            {name: "dog", showDivider: true},
                            {name: "hound"},
                            {name: "AAAAAAAA"},
                            {name: "qwertyuiop"},
                            {name: "asdfghjkl"},
                            {name: "zxcvbnm"},
                            {name: "option", showDivider: true, sectionName: "Heading"},
                            {name: "file1"},
                            {name: "file2"},
                            {name: "file3"},
                            {name: "loremipsumdolorsitametngjdfk", showDivider: true, sectionName: "Heading"}
                        ]
                        compact: true
                        selectionMode: B.List.SelectionMode.Multiple
                    }

                    B.Divider {
                        width: parent.width
                        leftInset: -parent.leftPadding
                        name: "Menu"
                    }

                    B.Button {
                        text: "Open Menu"
                        onReleased: menu1.open()

                        B.Menu {
                            id: menu1

                            B.MenuItem {
                                text: "Copy"
                                shortcut: StandardKey.Copy
                                icon.name: "content_copy"
                                onTriggered: {
                                    console.log("Copied!");
                                }
                            }

                            B.MenuItem {
                                text: "Paste"
                                shortcut: StandardKey.Paste
                                enabled: false
                            }

                            B.Menu {
                                title: "Submenu"
                                showDivider: true

                                B.Menu {
                                    title: "SubSubmenu"

                                    B.MenuItem {
                                        text: "deeep action"

                                        onTriggered: {
                                            console.log("a");
                                        }
                                    }

                                    B.MenuItem {text: "a"; shortcut: "Ctrl+Shift+H"}
                                    B.MenuItem {text: "bbb"}
                                    B.MenuItem {text: "cccds"}
                                    B.MenuItem {text: "fdbdhbd"}
                                    B.MenuItem {text: "s"}
                                    B.MenuItem {text: "hsahstrh"}
                                    B.MenuItem {text: "vat"}
                                    B.MenuItem {text: "ahtegdc"}
                                    B.MenuItem {text: "dog"}
                                    B.MenuItem {text: "animal"}
                                    B.MenuItem {text: "plant"}
                                    B.MenuItem {text: "snkgndjkhhh"}
                                    B.MenuItem {text: "a"}
                                    B.MenuItem {text: "bbb"}
                                    B.MenuItem {text: "cccds"}
                                    B.MenuItem {text: "fdbdhbdhhhhhhhhhhhhhhhhhhhh"; shortcut: "Ctrl+Shift+H"}
                                    B.MenuItem {text: "s"}
                                    B.MenuItem {text: "hsahstrh"}
                                    B.MenuItem {text: "vat"}
                                    B.MenuItem {text: "ahtegdc"}
                                    B.MenuItem {text: "dog"}
                                    B.MenuItem {text: "animal"}
                                    B.MenuItem {text: "planthhhhhhhhhh"}
                                    B.MenuItem {text: "a"}
                                    B.MenuItem {text: "bbb"}
                                    B.MenuItem {text: "cccds"}
                                    B.MenuItem {text: "fdbdhbd"}
                                    B.MenuItem {text: "s"}
                                    B.MenuItem {text: "hsahstrh"}
                                    B.MenuItem {text: "vat"}
                                    B.MenuItem {text: "ahtegdc"}
                                    B.MenuItem {text: "dog"}
                                    B.MenuItem {text: "animal"}
                                    B.MenuItem {text: "plant"}
                                }

                                B.MenuItem {
                                    text: "do nothing"

                                    onTriggered: {
                                        console.log("nothing");
                                    }
                                }
                            }

                            B.MenuItem {
                                text: "something"
                                showDivider: true
                            }

                            B.MenuItem {
                                text: "Toggle"
                                checkable: true
                                shortcut: "Ctrl+H"
                                onToggled: {
                                    console.log(checked ? "Toggled On" : "Toggled Off");
                                }
                            }

                            B.MenuItem {
                                text: "Toggle Disabled"
                                showDivider: true
                                checkable: true
                                enabled: false
                                checked: true
                            }

                            B.Menu {
                                title: "Submenu"

                                B.Menu {
                                    title: "SubSubmenu"

                                    B.MenuItem {
                                        text: "deeep action"

                                        onTriggered: {
                                            console.log("a");
                                        }
                                    }
                                }

                                B.MenuItem {
                                    text: "do nothing"

                                    onTriggered: {
                                        console.log("nothing");
                                    }
                                }
                            }
                        }
                    }

                    B.Divider {
                        width: parent.width
                        leftInset: -parent.leftPadding
                        name: "Pane"
                    }

                    B.Pane {
                        width: 200
                        height: 200

                        B.Button {
                            text: "Click me!"
                        }
                    }
                }
            }

            /*MouseArea {
                anchors.fill: parent
                propagateComposedEvents: true
                acceptedButtons: Qt.RightButton
                onClicked: function (mouse) {
                    popup.targetX = mouse.x;
                    popup.targetY = mouse.y;
                    popup.open();
                }
            }

            B.Popup {
                id: popup
            }*/

            B.OverflowArea {

                Column {
                    padding: 20
                    spacing: 50

                    Text {
                        text: "Display"
                        color: B.Theme.palette.text.heading
                        font: B.Theme.text.display
                    }

                    Text {
                        text: "Display 2"
                        color: B.Theme.palette.text.heading
                        font: B.Theme.text.display_2
                    }

                    Text {
                        text: "Title"
                        color: B.Theme.palette.text.heading
                        font: B.Theme.text.title
                    }

                    Text {
                        text: "Subtitle"
                        color: B.Theme.palette.text.heading
                        font: B.Theme.text.subtitle
                    }

                    Text {
                        text: "Section"
                        color: B.Theme.palette.text.heading
                        font: B.Theme.text.section
                    }

                    Text {
                        text: "Section 2"
                        color: B.Theme.palette.text.heading
                        font: B.Theme.text.section_2
                    }

                    Text {
                        text: "Section 3"
                        color: B.Theme.palette.text.heading
                        font: B.Theme.text.section_3
                    }

                    Text {
                        text: "Heading"
                        color: B.Theme.palette.text.heading
                        font: B.Theme.text.heading
                    }

                    Text {
                        text: "Subheading"
                        color: B.Theme.palette.text.heading
                        font: B.Theme.text.subheading
                    }

                    Text {
                        text: "Body"
                        color: B.Theme.palette.text.body
                        font: B.Theme.text.body
                    }

                    Text {
                        text: "Label"
                        color: B.Theme.palette.text.label
                        font: B.Theme.text.label
                    }

                    Text {
                        text: "Caption"
                        color: B.Theme.palette.text.label
                        font: B.Theme.text.caption
                    }

                    Text {
                        text: "Overline"
                        color: B.Theme.palette.text.overline
                        font: B.Theme.text.overline
                    }

                    Text {
                        text: "Button"
                        color: B.Theme.palette.text.label
                        font: B.Theme.text.button
                    }
                }
            }

            Flow {
                id: flow1
                property var elevations: [1,2,3,4,6,8,9,12,16,24]
                padding: 20
                spacing: 60
                Repeater {
                    model: flow1.elevations.length

                    Item {
                        width: 40+40*(index/4)
                        height: width

                        B.Elevation {
                            anchors.fill: rect
                            radius: rect.radius
                            elevation: flow1.elevations[index]
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
            }
        }
    }
}
