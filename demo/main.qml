import QtQuick
import QtQuick.Controls as QuickControls
import QtQuick.Layouts
import QtQuick.Window
import bon as Bon

Window {
    width: 800
    height: 600
    visible: true
    title: qsTr("umagos")

    Bon.App {

        StackLayout {
            anchors.fill: parent
            currentIndex: 0

            /*focus: true
            Keys.onReleased: (event) => {
                                if (event.key >= Qt.Key_0 && event.key <= Qt.Key_9) {
                                    currentIndex = event.key - Qt.Key_0;
                                }
                            }*/

            Bon.OverflowArea {
                id: scrollview
                margins: 0

                Flow {
                    id: flow
                    padding: 40
                    width: scrollview.width - scrollview.leftMargin - scrollview.rightMargin
                    spacing: 20

                    Bon.List {
                        id: list1
                        width: 400

                        model: [
                            {name: "hi"},
                            {name: "test", caption: "caption test"},
                            {name: "the", overline: "tech"},
                            {name: "an", leading: Bon.ListLeading.icon({name: "home"})},
                            {name: "goenfdj", leading: Bon.ListLeading.avatar({source: "https://pbs.twimg.com/profile_images/1466199778598047749/sdljjuYA_400x400.jpg"})},
                            {name: "chrimsntas yayaya", caption: "Lorem ipsum dolor sit amet",  overline: "breaking", leading: Bon.ListLeading.thumbnail({source: "https://picography.co/wp-content/uploads/2017/12/xmas-bokeh-lights-768x525.jpg"})},
                            {name: "hi"},
                            {name: "test", trailing: Bon.ListTrailing.caption({text: "Caption"})},
                            {name: "the", trailing: Bon.ListTrailing.icon({name: "arrow_right"})},
                            {name: "a", trailing: Bon.ListTrailing.item({component: listRadioButton}) },
                            {name: "b", trailing: Bon.ListTrailing.item({component: listRadioButton}) },
                            {name: "c", trailing: Bon.ListTrailing.item({component: listRadioButton}) },
                            {name: "d", trailing: Bon.ListTrailing.item({component: listRadioButton}) },
                            {name: "e", trailing: Bon.ListTrailing.item({component: listRadioButton}) },
                            {name: "goenfdj", caption: "Lorem ipsum dolor sit amet, consectetur adsipling elit, the quick brown fox jumps over the lazy dog, etc"},
                            {name: "cataaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa", caption: "Lorem ipsum dolor sit amet, consectetur adsipling elit, the quick brown fox jumps over the lazy dog, etc nhioteshbtugboiutewbioutwbhitw go tsh tsh t h rsth rst hsoeige bo bo bou we", trailing: Bon.ListTrailing.caption({text: "aaaaaaa"})},
                            {name: "hi"},
                            {name: "test"},
                            {name: "the"},
                            {name: "an"},
                            {name: "goenfdj"},
                            {name: "cat"}
                        ]

                        QuickControls.ButtonGroup {
                            id: listButtonGroupTest
                            exclusive: true
                        }

                        Component {
                            id: listRadioButton

                            Bon.RadioButton {
                                //opacity: (parent.parent.parent.index%3)/4+1/4

                                QuickControls.ButtonGroup.group: listButtonGroupTest
                            }
                        }
                    }

                    Bon.List {
                        model: list1.model
                        compact: true
                    }

                    Bon.Divider {
                        width: parent.width
                        leftInset: -parent.leftPadding
                        name: "Switches"
                    }

                    Bon.Switch {}

                    Bon.Switch {checked: true}

                    Bon.Switch {enabled: false}

                    Bon.Switch {checked:true; enabled: false}

                    Bon.Divider {
                        width: parent.width
                        leftInset: -parent.leftPadding
                        name: "Radio Buttons"
                    }

                    Bon.RadioButton {}

                    Bon.RadioButton {checked: true}

                    Bon.RadioButton {mixed: true}

                    Bon.RadioButton {enabled: false}

                    Bon.RadioButton {checked:true; enabled: false}

                    Bon.RadioButton {mixed:true; enabled: false}

                    Bon.Divider {
                        width: parent.width
                        leftInset: -parent.leftPadding
                        name: "Checkboxes"
                    }

                    Bon.CheckBox {}

                    Bon.CheckBox {checked: true}

                    Bon.CheckBox {mixed: true}

                    Bon.CheckBox {enabled: false}

                    Bon.CheckBox {checked:true; enabled: false}

                    Bon.CheckBox {mixed:true; enabled: false}

                    Bon.Divider {
                        width: parent.width
                        leftInset: -parent.leftPadding
                        name: "Sliders"
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

                    Bon.Divider {
                        width: parent.width
                        leftInset: -parent.leftPadding
                        name: "Progress"
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

                    Bon.Divider {
                        width: parent.width
                        leftInset: -parent.leftPadding
                        name: "Dials"
                    }

                    Bon.Dial {}

                    Bon.Dial {enabled: false}

                    Bon.Dial {showValue: true}

                    Bon.Dial {enabled: false; showValue: true}

                    Bon.Dial {showValue: true; snapMode: Bon.Dial.SnapAlways; stepSize: 0.1}

                    Bon.Dial {enabled: false; showValue: true; snapMode: Bon.Dial.SnapAlways; stepSize: 0.1}

                    Bon.Divider {
                        width: parent.width
                        leftInset: -parent.leftPadding
                        name: "Buttons"
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

                    Bon.Divider {
                        width: parent.width
                        leftInset: -parent.leftPadding
                        name: "Chips"
                    }

                    Bon.InputChip {
                        text: "Favorites"
                        onClosed: {
                            visible = false;
                        }
                    }

                    Bon.InputChip {
                        text: "Nature"
                        enabled: false
                        onClosed: {
                            visible = false;
                        }
                    }

                    Bon.InputChip {
                        text: "Mountains"
                        icon.name: "terrain"
                        onClosed: {
                            visible = false;
                        }
                    }

                    Bon.InputChip {
                        text: "Portraits"
                        enabled: false
                        icon.name: "portrait"
                        onClosed: {
                            visible = false;
                        }
                    }

                    Bon.ChoiceChip {
                        text: "Option 1"
                    }

                    Bon.ChoiceChip {
                        text: "Option 2"
                        enabled: false
                    }

                    Bon.ChoiceChip {
                        text: "Option 3"
                        icon.name: "dashboard"
                    }

                    Bon.ChoiceChip {
                        text: "Option 4"
                        enabled: false
                        icon.name: "dashboard"
                    }

                    Bon.FilterChip {
                        text: "Favorites"
                    }

                    Bon.FilterChip {
                        text: "Nature"
                        enabled: false
                    }

                    Bon.ActionChip {
                        text: "Action 1"

                        onClicked: {
                            console.log("Running action 1");
                        }
                    }

                    Bon.ActionChip {
                        text: "Action 2"
                        enabled: false

                        onClicked: {
                            console.log("Running action 2");
                        }
                    }

                    Bon.ActionChip {
                        text: "Action 3"
                        icon.name: "play_arrow"

                        onClicked: {
                            console.log("Running action 3");
                        }
                    }

                    Bon.ActionChip {
                        text: "Action 4"
                        enabled: false
                        icon.name: "stop"

                        onClicked: {
                            console.log("Running action 4");
                        }
                    }

                    Bon.Divider {
                        width: parent.width
                        leftInset: -parent.leftPadding
                        name: "Text Fields"
                    }

                    Bon.TextField {
                        field.placeholderText: "Enter name"
                    }

                    Bon.TextField {
                        field.placeholderText: "Enter name"
                        enabled: false
                    }

                    Bon.TextField {
                        field.placeholderText: "Enter name"
                        buttonIcon: field.length > 0 ? "cancel" : ""
                        onIconClicked: {
                            field.text = "";
                        }
                    }

                    Bon.TextField {
                        field.placeholderText: "Enter name"
                        buttonIcon: field.length > 0 ? "cancel" : ""
                        enabled: false
                        onIconClicked: {
                            field.text = "";
                        }
                    }

                    Bon.TextField {
                        field.placeholderText: "Enter an amount"
                        field.validator: DoubleValidator {}
                        buttonIcon: field.length > 0 ? "cancel" : ""
                        showStatus: true
                        onIconClicked: {
                            field.text = "";
                        }
                    }

                    Bon.TextField {
                        field.placeholderText: "Enter an amount"
                        field.validator: DoubleValidator {}
                        buttonIcon: field.length > 0 ? "cancel" : ""
                        showStatus: true
                        onIconClicked: {
                            field.text = "";
                        }
                    }

                    Bon.TextField {
                        field.placeholderText: "Enter name"
                        leadingIcon: "face"
                    }

                    Bon.TextField {
                        field.placeholderText: "Enter name"
                        enabled: false
                        leadingIcon: "face"
                    }

                    Bon.TextField {
                        field.placeholderText: "1.00"
                        prefixText: "$"
                    }

                    Bon.TextField {
                        field.placeholderText: "john.doe"
                        suffixText: "@gmail.com"
                    }

                    Bon.TextField {
                        field.placeholderText: "Enter name"
                        helpText: "Helper Text"
                    }

                    Bon.TextField {
                        field.placeholderText: "Enter name"
                        field.maximumLength: 20
                        showCharacterCount: true
                    }

                    Bon.TextField {
                        field.placeholderText: "Enter name"
                        helpText: "Helper Text"
                        field.maximumLength: 20
                        showCharacterCount: true
                    }

                    Bon.TextField {
                        field.placeholderText: "Enter name"
                        labelText: "First name"
                    }

                    Bon.TextField {
                        labelText: "Email address*"
                        field.placeholderText: "jon.doe@gmail.com"
                        helpText: "*Required"
                    }

                    Bon.TextField {
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

                    Bon.Divider {
                        width: parent.width
                        leftInset: -parent.leftPadding
                        name: "Text Areas"
                    }

                    Bon.TextArea {
                        enabled: false
                        area.placeholderText: "Enter message"
                    }

                    Bon.TextArea {
                        area.placeholderText: "Enter message"
                    }

                    Bon.TextArea {
                        area.placeholderText: "Enter message"
                        wordWrap: true
                    }

                    Bon.TextArea {
                        area.placeholderText: "Enter message"
                        helpText: "Required"
                    }

                    Bon.TextArea {
                        labelText: "Message"
                        area.placeholderText: "Enter message"
                    }

                    Bon.TextArea {
                        labelText: "Message*"
                        helpText: "*Required"
                        showCharacterCount: true
                        area.placeholderText: "Enter message"
                    }

                    Bon.TextArea {
                        area.placeholderText: "Enter message"
                        bordered: false
                    }

                    Bon.Divider {
                        width: parent.width
                        leftInset: -parent.leftPadding
                        name: "Number Fields"
                    }

                    Bon.NumberField {
                        value: 5
                    }

                    Bon.NumberField {
                        value: 5
                        from: 0
                        to: 100
                        stepSize: 12
                    }

                    Bon.NumberField {
                        value: 5
                        wrap: true
                        from: 0
                        to: 100
                        stepSize: 12
                    }

                    Bon.NumberField {
                        value: 5
                        showStepButtons: true
                    }

                    Bon.NumberField {
                        value: 5
                        showStepButtons: true
                        from: 0
                        to: 100
                        stepSize: 12
                    }

                    Bon.NumberField {
                        value: 5
                        showStepButtons: true
                        wrap: true
                        from: 0
                        to: 100
                        stepSize: 12
                    }

                    Bon.NumberField {
                        value: 5
                        showStepButtons: true
                        from: 0
                        to: 100
                        stepSize: 1
                        wrap: true
                        editable: false
                    }

                    Bon.Divider {
                        width: parent.width
                        leftInset: -parent.leftPadding
                        name: "Combo Boxes"
                    }

                    Bon.ComboBox {
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

                    Bon.ComboBox {
                        model: combobox1.model
                        editable: false
                    }

                    Bon.ComboBox {
                        model: combobox1.model
                        labelText: "Choose a shape"
                        helpText: "Optional"
                    }

                    Bon.Divider {
                        width: parent.width
                        leftInset: -parent.leftPadding
                        name: "Ratings"
                    }

                    Bon.Rating {

                    }

                    Bon.Rating {
                        editable: false
                        displayValue: 2.35
                    }

                    Bon.Rating {
                        enabled: false
                    }

                    Bon.Divider {
                        width: parent.width
                        leftInset: -parent.leftPadding
                        name: "Color Swatches"
                    }

                    Bon.ColorSwatch {

                    }

                    Bon.ColorSwatch {
                        color: "#cc66788A"
                    }

                    Bon.ColorSwatch {
                        color: "#74D2D8"
                    }

                    Bon.ColorSwatch {
                        color: "#D1B4B4"
                    }

                    Bon.ColorSwatch {
                        color: "#D1B4B4"
                        enabled: false
                    }

                    Bon.Divider {
                        width: parent.width
                        leftInset: -parent.leftPadding
                        name: "Toggle Buttons"
                    }

                    Bon.ToggleButtonGroup {
                        Bon.ToggleButton {
                            checked: true
                            icon.name: "format_bold"
                        }
                        Bon.ToggleButton {
                            checked: false
                            enabled: false
                            icon.name: "format_italic"
                        }
                        Bon.ToggleButton {
                            checked: false
                            icon.name: "format_underline"
                        }
                    }

                    Bon.Divider {
                        width: parent.width
                        leftInset: -parent.leftPadding
                        name: "Single Options"
                    }

                    Bon.Option {
                        name: "Option 1"
                        width: 300
                    }

                    Bon.Option {
                        name: "Option 1"
                        enabled: false
                        width: 300
                    }

                    Bon.Option {
                        name: "Option 1"
                        width: 300
                        exclusive: true
                    }

                    Bon.Option {
                        name: "Option 1"
                        enabled: false
                        width: 300
                        exclusive: true
                    }

                    Bon.Divider {
                        width: parent.width
                        leftInset: -parent.leftPadding
                        name: "Multiple Choices"
                    }

                    Bon.Choice {
                        width: 300

                        Bon.Option {
                            name: "Option 1"
                        }

                        Bon.Option {
                            name: "Option 2"
                        }

                        Bon.Option {
                            name: "Option 3"
                        }
                    }

                    Bon.Choice {
                        width: 300
                        exclusive: true

                        Bon.Option {
                            name: "Option 1"
                        }

                        Bon.Option {
                            name: "Option 2"
                        }

                        Bon.Option {
                            name: "Option 3"
                        }
                    }

                    Bon.Divider {
                        width: parent.width
                        leftInset: -parent.leftPadding
                        name: "Tumblers"
                    }

                    Bon.Tumbler {
                        model: 60
                    }

                    Bon.Tumbler {
                        orientation: Qt.Horizontal
                        model: 60
                    }

                    Bon.Divider {
                        width: parent.width
                        leftInset: -parent.leftPadding
                        name: "Pickers"
                    }

                    Bon.ColorField {
                        currentColor: "#e16c88"
                    }

                    Bon.DateField {

                    }

                    Bon.DateField {
                        selectRange: true
                    }

                    Bon.TimeField {

                    }

                    Bon.TimeField {
                        twentyFourHour: true
                    }

                    Bon.TimeField {
                        showSeconds: true
                    }

                    Bon.TimeField {
                        twentyFourHour: true
                        showSeconds: true
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

            Bon.Popup {
                id: popup
            }*/

            Bon.OverflowArea {

                Column {
                    padding: 20
                    spacing: 50

                    Text {
                        text: "Display"
                        color: Bon.Theme.palette.text.heading
                        font: Bon.Theme.text.display
                    }

                    Text {
                        text: "Display 2"
                        color: Bon.Theme.palette.text.heading
                        font: Bon.Theme.text.display_2
                    }

                    Text {
                        text: "Title"
                        color: Bon.Theme.palette.text.heading
                        font: Bon.Theme.text.title
                    }

                    Text {
                        text: "Subtitle"
                        color: Bon.Theme.palette.text.heading
                        font: Bon.Theme.text.subtitle
                    }

                    Text {
                        text: "Section"
                        color: Bon.Theme.palette.text.heading
                        font: Bon.Theme.text.section
                    }

                    Text {
                        text: "Section 2"
                        color: Bon.Theme.palette.text.heading
                        font: Bon.Theme.text.section_2
                    }

                    Text {
                        text: "Section 3"
                        color: Bon.Theme.palette.text.heading
                        font: Bon.Theme.text.section_3
                    }

                    Text {
                        text: "Heading"
                        color: Bon.Theme.palette.text.heading
                        font: Bon.Theme.text.heading
                    }

                    Text {
                        text: "Subheading"
                        color: Bon.Theme.palette.text.heading
                        font: Bon.Theme.text.subheading
                    }

                    Text {
                        text: "Body"
                        color: Bon.Theme.palette.text.body
                        font: Bon.Theme.text.body
                    }

                    Text {
                        text: "Label"
                        color: Bon.Theme.palette.text.label
                        font: Bon.Theme.text.label
                    }

                    Text {
                        text: "Caption"
                        color: Bon.Theme.palette.text.label
                        font: Bon.Theme.text.caption
                    }

                    Text {
                        text: "Overline"
                        color: Bon.Theme.palette.text.overline
                        font: Bon.Theme.text.overline
                    }

                    Text {
                        text: "Button"
                        color: Bon.Theme.palette.text.label
                        font: Bon.Theme.text.button
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

                        Bon.Elevation {
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
