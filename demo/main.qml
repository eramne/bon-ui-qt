import QtQuick
import QtQuick.Templates as T
import QtQuick.Layouts
import bon as B

B.App {
    id: root
    width: 800
    height: 600
    visible: true
    title: qsTr("bonUI demo application")

    property url avatarImgSrc: "https://www.eramne.com/portfolio/art/imgs/Fractal/1%2011%202022%20fractal.png"
    property url thumbImgSrc: "https://www.eramne.com/portfolio/art/imgs/Fractal/1%2024%202022%20(2).png"

    homepage: B.Page {

        //icon.name: "article"
        contents: Component {
            Item {
                B.HeadingText {
                    anchors.centerIn: parent
                    text: "Homepage"
                }
            }
        }
    }

    pages: [
        B.Page {
            id: controlsPage
            icon.name: "toggle_on"
            label: "Controls"

            contents: Component {
                B.List {
                    leftMargin: 40
                    topMargin: 40
                    bottomMargin: 40
                    rightMargin: 40

                    model: [
                        {name: "Action", trailing: B.ListTrailing.icon({name: "chevron_right"}), onActivated:
                            () => {
                                root.currentPage = root.actionPage;
                            }
                        },
                        {name: "Feedback", trailing: B.ListTrailing.icon({name: "chevron_right"}), onActivated:
                            () => {
                                root.currentPage = root.feedbackPage;
                            }
                        },
                        {name: "Input", trailing: B.ListTrailing.icon({name: "chevron_right"}), onActivated:
                            () => {
                                root.currentPage = root.inputPage;
                            }
                        },
                        {name: "Layout", trailing: B.ListTrailing.icon({name: "chevron_right"}), onActivated:
                            () => {
                                root.currentPage = root.layoutPage;
                            }
                        }
                    ]
                }
            }
        },
        B.Page {
            icon.name: "text_fields"
            label: "Text"
            contents: Component {
                B.OverflowArea {
                    margins: 40

                    Column {
                        spacing: 20

                        B.DisplayText {
                            text: "Display"
                        }

                        B.Display2Text {
                            text: "Display 2"
                        }

                        B.TitleText {
                            text: "Title"
                        }

                        B.SubtitleText {
                            text: "Subtitle"
                        }

                        B.SectionText {
                            text: "Section"
                        }

                        B.Section2Text {
                            text: "Section 2"
                        }

                        B.Section3Text {
                            text: "Section 3"
                        }

                        B.HeadingText {
                            text: "Heading"
                        }

                        B.SubheadingText {
                            text: "Subheading"
                        }

                        B.BodyText {
                            text: "Body"
                        }

                        B.LabelText {
                            text: "Label"
                        }

                        B.CaptionText {
                            text: "Caption"
                        }

                        B.OverlineText {
                            text: "Overline"
                        }

                        B.ButtonText {
                            text: "Button"
                        }
                    }
                }
            }
        },
        B.Page {
            icon.name: "gradient"
            label: "Elevation"
            contents: Component {
                B.OverflowArea {
                    margins: 40

                    Flow {
                        id: flow1
                        property var elevations: [1,2,3,4,6,8,9,12,16,24]
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
                                    color: "#FEFBFA"
                                }
                            }
                        }
                    }
                }
            }
        }
    ]



    property B.Page actionPage: B.Page {
        contents: Component {
            ColumnLayout {
                spacing: 10

                RowLayout {
                    spacing: 10
                    Layout.leftMargin: 40
                    Layout.rightMargin: 40
                    Layout.topMargin: 40

                    B.Button {
                        icon.name: "arrow_back"
                        order: 3
                        onReleased: {
                            root.currentPage = controlsPage
                        }
                    }

                    B.HeadingText {
                        text: "Action"
                    }
                }

                B.OverflowArea {
                    id: scrollView
                    margins: 40
                    topMargin: 20
                    Layout.fillHeight: true
                    Layout.fillWidth: true

                    Flow {
                        id: flow
                        width: scrollView.width - scrollView.leftMargin - scrollView.rightMargin
                        spacing: 20

                        B.Divider {
                            width: parent.width
                            name: "Buttons"
                        }

                        B.Button {
                            order: B.Button.Order.Primary
                            text: "Click me"
                        }

                        B.Button {
                            order: B.Button.Order.Primary
                            text: "Click me"
                            enabled: false
                        }

                        B.Button {
                            order: B.Button.Order.Secondary
                            text: "Click me"
                        }

                        B.Button {
                            order: B.Button.Order.Secondary
                            text: "Click me"
                            enabled: false
                        }

                        B.Button {
                            order: B.Button.Order.Tertiary
                            text: "Click me"
                        }

                        B.Button {
                            order: B.Button.Order.Tertiary
                            text: "Click me"
                            enabled: false
                        }

                        B.Button {
                            order: B.Button.Order.Primary
                            icon.name: "settings"
                            text: "Click me"
                        }

                        B.Button {
                            order: B.Button.Order.Primary
                            icon.name: "settings"
                            text: "Click me"
                            enabled: false
                        }

                        B.Button {
                            order: B.Button.Order.Secondary
                            icon.name: "settings"
                            text: "Click me"
                        }

                        B.Button {
                            order: B.Button.Order.Secondary
                            icon.name: "settings"
                            text: "Click me"
                            enabled: false
                        }

                        B.Button {
                            order: B.Button.Order.Tertiary
                            icon.name: "settings"
                            text: "Click me"
                        }

                        B.Button {
                            order: B.Button.Order.Tertiary
                            icon.name: "settings"
                            text: "Click me"
                            enabled: false
                        }

                        B.Button {
                            order: B.Button.Order.Primary
                            icon.name: "settings"
                        }

                        B.Button {
                            order: B.Button.Order.Primary
                            icon.name: "settings"
                            enabled: false
                        }

                        B.Button {
                            order: B.Button.Order.Secondary
                            icon.name: "settings"
                        }

                        B.Button {
                            order: B.Button.Order.Secondary
                            icon.name: "settings"
                            enabled: false
                        }

                        B.Button {
                            order: B.Button.Order.Tertiary
                            icon.name: "settings"
                        }

                        B.Button {
                            order: B.Button.Order.Tertiary
                            icon.name: "settings"
                            enabled: false
                        }

                        B.SmallIconButton {
                            icon.name: "star"
                        }

                        B.SmallIconButton {
                            icon.name: "star"
                            enabled: false
                        }

                        B.SmallIconButton {
                            icon.name: checked ? "star" : "star_border"
                            checkable: true
                        }

                        B.SmallIconButton {
                            icon.name: checked ? "star" : "star_border"
                            checkable: true
                            enabled: false
                        }

                        B.Divider {
                            width: parent.width
                            name: "Menu"
                        }

                        B.Button {
                            icon.name: "more_vert"
                            order: B.Button.Order.Secondary
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
                            name: "Context Menu"
                        }

                        B.Pane {

                            B.ContextMenu {
                                B.MenuItem {
                                    text: "Cut"
                                    shortcut: StandardKey.Cut
                                }
                                B.MenuItem {
                                    text: "Copy"
                                    shortcut: StandardKey.Copy
                                }
                                B.MenuItem {
                                    text: "Paste"
                                    shortcut: StandardKey.Paste
                                }
                            }
                        }
                    }
                }
            }
        }
    }





    property B.Page feedbackPage: B.Page {
        contents: Component {
            ColumnLayout {
                spacing: 10

                RowLayout {
                    spacing: 10
                    Layout.leftMargin: 40
                    Layout.rightMargin: 40
                    Layout.topMargin: 40

                    B.Button {
                        icon.name: "arrow_back"
                        order: 3
                        onReleased: {
                            root.currentPage = controlsPage
                        }
                    }

                    B.HeadingText {
                        text: "Feedback"
                    }
                }

                B.OverflowArea {
                    id: scrollView
                    margins: 40
                    topMargin: 20
                    Layout.fillHeight: true
                    Layout.fillWidth: true

                    Flow {
                        id: flow
                        width: scrollView.width - scrollView.leftMargin - scrollView.rightMargin
                        spacing: 20

                        B.Divider {
                            width: parent.width
                            name: "Alerts"
                        }

                        B.Alert {
                            title: "Sign in"
                            description: "Enter your email address and password."
                            Component.onCompleted: open()
                        }

                        B.Alert {
                            id: alert1
                            title: "Couldn't sign in"
                            description: "Please check your internet connection and try again."
                            variant: B.Alert.Variant.Error
                            Component.onCompleted: open()
                            actions: [
                                B.Button {
                                    text: "Dismiss"
                                    order: B.Button.Order.Tertiary
                                    onClicked: {
                                        alert1.close();
                                    }
                                },
                                B.Button {
                                    text: "Retry"
                                    order: B.Button.Order.Tertiary
                                }
                            ]
                        }

                        B.Alert {
                            title: "Your subscription is about to expire"
                            description: "Please renew your subscription or download your data."
                            variant: B.Alert.Variant.Warning
                            Component.onCompleted: open()
                        }

                        B.Alert {
                            title: "Successfully registered"
                            description: "Welcome to <site>"
                            variant: B.Alert.Variant.Success
                            Component.onCompleted: open()
                        }

                        B.Alert {
                            title: "Update available"
                            description: "The update will be installed on the next launch."
                            variant: B.Alert.Variant.Info
                            Component.onCompleted: open()
                        }

                        B.Divider {
                            width: parent.width
                            name: "Dialogs"
                        }

                        B.Dialog {
                            id: dialog1
                            icon.name: "warning"
                            title: "Discard draft?"
                            description: "All changes will be lost."
                            actions: [
                                B.Button {
                                    text: "Cancel"
                                    order: B.Button.Order.Secondary
                                    onClicked: {
                                        console.log("Cancelled");
                                    }
                                },
                                B.Button {
                                    text: "Delete"
                                    order: B.Button.Order.Primary
                                    onClicked: {
                                        console.log("Deleted");
                                    }
                                }
                            ]
                        }

                        B.Button {
                            text: "Show dialog"
                            onClicked: {
                                dialog1.open()
                            }
                        }

                        B.Divider {
                            width: parent.width
                            name: "Progress"
                        }

                        B.ProgressBar {
                            width: 200
                            from: 0
                            to: 1
                            value: 0
                            state: B.ProgressBar.State.Running
                            Timer {
                                interval: 500;
                                running: true;
                                repeat: true
                                onTriggered: function () {
                                    parent.value += Math.random()/5
                                    if (parent.value >= 1) {
                                        parent.value = 0;
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
                        }

                        B.ProgressCircle {
                            from: 0
                            to: 1
                            value: 0
                            state: B.ProgressCircle.State.Running
                            Timer {
                                interval: 500;
                                running: true;
                                repeat: true
                                onTriggered: function () {
                                    parent.value += Math.random()/5
                                    if (parent.value >= 1) {
                                        parent.value = 0;
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
                        }

                        B.ProgressCircle {
                            from: 0
                            to: 1
                            value: 0
                            small: true
                            state: B.ProgressBar.State.Running
                            Timer {
                                interval: 500;
                                running: true;
                                repeat: true
                                onTriggered: function () {
                                    parent.value += Math.random()/5
                                    if (parent.value >= 1) {
                                        parent.value = 0;
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
                        }

                        B.Divider {
                            width: parent.width
                            name: "Toasts/Notifications"
                        }

                        B.Toast {
                            id: toast1
                            text: "5 files converted successfully"
                            icon.name: "check"
                            variant: B.Toast.Variant.Success
                        }

                        B.Toast {
                            id: toast2
                            text: "5 files could not be converted"
                            icon.name: "error"
                            variant: B.Toast.Variant.Error
                            action: B.Button {
                                order: B.Button.Order.Tertiary
                                text: "Retry"
                            }
                        }

                        B.Button {
                            text: "Show toast"
                            onClicked: {
                                toast1.queue()
                            }
                        }

                        B.Button {
                            text: "Show toast 2"
                            onClicked: {
                                toast2.queue()
                            }
                        }

                        B.Divider {
                            width: parent.width
                            name: "Tooltip"
                        }

                        B.Button {
                            text: "Click me!"

                            B.ToolTip {
                                text: "Test Tooltip"
                                visible: parent.hovered
                            }
                        }
                    }
                }
            }
        }
    }



    property B.Page inputPage: B.Page {
        contents: Component {
            ColumnLayout {
                spacing: 10

                RowLayout {
                    spacing: 10
                    Layout.leftMargin: 40
                    Layout.rightMargin: 40
                    Layout.topMargin: 40

                    B.Button {
                        icon.name: "arrow_back"
                        order: 3
                        onReleased: {
                            root.currentPage = controlsPage
                        }
                    }

                    B.HeadingText {
                        text: "Input"
                    }
                }

                B.OverflowArea {
                    id: scrollView
                    margins: 40
                    topMargin: 20
                    Layout.fillHeight: true
                    Layout.fillWidth: true

                    Flow {
                        id: flow
                        width: scrollView.width - scrollView.leftMargin - scrollView.rightMargin
                        spacing: 20

                        B.Divider {
                            width: parent.width
                            name: "Switches"
                        }

                        B.Switch {}

                        B.Switch {checked: true}

                        B.Divider {
                            width: parent.width
                            name: "Radio Buttons"
                        }

                        B.RadioButton {}

                        B.RadioButton {checked: true}

                        B.RadioButton {mixed: true}

                        B.Divider {
                            width: parent.width
                            name: "Checkboxes"
                        }

                        B.CheckBox {}

                        B.CheckBox {checked: true}

                        B.CheckBox {mixed: true}

                        B.Divider {
                            width: parent.width
                            name: "Choices"
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
                            name: "Sliders"
                        }

                        B.Slider {}

                        B.Slider {
                            from: 0
                            value: 25
                            to: 100
                            stepSize: 25
                            snapMode: B.Slider.SnapAlways
                        }

                        B.Divider {
                            width: parent.width
                            name: "Dials"
                        }

                        B.Dial {}

                        B.Dial {showValue: true}

                        B.Dial {showValue: true; snapMode: B.Dial.SnapAlways; stepSize: 0.1}

                        B.Divider {
                            width: parent.width
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
                            name: "Ratings"
                        }

                        B.Rating {

                        }

                        B.Rating {
                            editable: false
                            displayValue: 2.35
                        }

                        B.Rating {
                            editable: true
                            displayValue: 2.35
                        }

                        B.Divider {
                            width: parent.width
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
                            name: "Chips"
                        }

                        B.ChipSet {
                            variant: B.Chip.Variant.Action
                            overflow: false
                            B.Chip {
                                text: "Run Action 1"

                                onClicked: {
                                    console.log("Running action 1");
                                }
                            }
                            B.Chip {
                                text: "Run Action 2"

                                onClicked: {
                                    console.log("Running action 2");
                                }
                            }
                            B.Chip {
                                text: "Run Action 3"
                                icon.name: "play_arrow"

                                onClicked: {
                                    console.log("Running action 3");
                                }
                            }
                            B.Chip {
                                text: "Run Action 4"
                                icon.name: "play_arrow"

                                onClicked: {
                                    console.log("Running action 4");
                                }
                            }
                        }

                        B.ChipSet {
                            variant: B.Chip.Variant.Input
                            overflow: true
                            B.Chip {
                                text: "John Doe"
                                icon.name: "face"
                            }
                            B.Chip {
                                text: "Jane Doe"
                            }
                            B.Chip {
                                text: "Joe Q. Public"
                                icon.name: "face"
                            }
                            B.Chip {
                                text: "Johnny Doe"
                            }
                        }

                        B.ChipSet {
                            variant: B.Chip.Variant.Choice
                            overflow: false
                            exclusive: false
                            B.Chip {
                                text: "Red"
                            }
                            B.Chip {
                                text: "Green"
                            }
                            B.Chip {
                                text: "Blue"
                            }
                        }

                        B.ChipSet {
                            variant: B.Chip.Variant.Choice
                            overflow: false
                            exclusive: true
                            B.Chip {
                                text: "Red"
                            }
                            B.Chip {
                                text: "Green"
                            }
                            B.Chip {
                                text: "Blue"
                            }
                        }

                        B.Divider {
                            width: parent.width
                            name: "Chip Input"
                        }

                        B.ChipInput {
                            model: combobox1.model
                        }

                        B.Divider {
                            width: parent.width
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

                        B.Divider {
                            width: parent.width
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
                            name: "Text Fields"
                        }

                        B.TextField {
                            field.placeholderText: "Enter name"
                        }

                        B.TextField {
                            field.placeholderText: "Enter name"
                            buttonIcon: field.length > 0 ? "cancel" : ""
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
                            field.placeholderText: "1.00"
                            prefixText: "$"
                        }

                        B.TextField {
                            field.placeholderText: "john.doe"
                            suffixText: "@example.com"
                        }

                        B.TextField {
                            field.placeholderText: "Enter name"
                            helpText: "Helper Text"
                            field.maximumLength: 20
                            showCharacterCount: true
                        }

                        B.TextField {
                            labelText: "Email address*"
                            field.placeholderText: "jon.doe@example.com"
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
                            name: "Text Areas"
                        }

                        B.TextArea {
                            area.placeholderText: "Enter message"
                        }

                        B.TextArea {
                            area.placeholderText: "Enter message"
                            wordWrap: true
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
                    }
                }
            }
        }
    }



    property B.Page layoutPage: B.Page {
        contents: Component {
            ColumnLayout {
                spacing: 10

                RowLayout {
                    spacing: 10
                    Layout.leftMargin: 40
                    Layout.rightMargin: 40
                    Layout.topMargin: 40

                    B.Button {
                        icon.name: "arrow_back"
                        order: 3
                        onReleased: {
                            root.currentPage = controlsPage
                        }
                    }

                    B.HeadingText {
                        text: "Layout"
                    }
                }

                B.OverflowArea {
                    id: scrollView
                    margins: 40
                    topMargin: 20
                    Layout.fillHeight: true
                    Layout.fillWidth: true

                    Flow {
                        id: flow
                        width: scrollView.width - scrollView.leftMargin - scrollView.rightMargin
                        spacing: 20

                        B.Divider {
                            width: parent.width
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
                                {name: "goenfdj", leading: B.ListLeading.avatar({source: root.avatarImgSrc})},
                                {name: "chrimsntas yayaya", caption: "Lorem ipsum dolor sit amet",  overline: "breaking", leading: B.ListLeading.thumbnail({source: root.thumbImgSrc})},
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

                            T.ButtonGroup {
                                id: listButtonGroupTest
                                exclusive: true
                            }

                            Component {
                                id: listRadioButton

                                B.RadioButton {
                                    //opacity: (parent.parent.parent.index%3)/4+1/4

                                    T.ButtonGroup.group: listButtonGroupTest
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
                            name: "Pane"
                        }

                        B.Pane {
                            B.Button {
                                text: "Click me!"
                            }
                        }

                        B.Divider {
                            width: parent.width
                            name: "Card"
                        }

                        B.Card {

                        }

                        B.Card {
                            width: 400
                            overline: "tech"
                            title: "Lorem Ipsum"
                            subtitle: "by John Doe"
                            description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."
                        }

                        B.Card {
                            width: 400
                            title: "Lorem Ipsum"
                            description: "Lorem ipsum dolor sit amet"
                            rightActions: [
                                B.Button {
                                    order: B.Button.Order.Primary
                                    text: "Action"
                                },

                                B.Button {
                                    order: B.Button.Order.Tertiary
                                    text: "Action"
                                }
                            ]
                        }

                        B.Card {
                            width: 400
                            title: "Lorem Ipsum"
                            description: "Lorem ipsum dolor sit amet"
                            leftActions: [
                                B.Button {
                                    order: B.Button.Order.Primary
                                    text: "Action"
                                },

                                B.Button {
                                    order: B.Button.Order.Tertiary
                                    text: "Action"
                                }
                            ]
                        }

                        B.Card {
                            width: 400
                            title: "Lorem Ipsum"
                            description: "Lorem ipsum dolor sit amet"
                            leftActions: [
                                B.Button {
                                    order: B.Button.Order.Primary
                                    text: "Action"
                                },

                                B.Button {
                                    order: B.Button.Order.Tertiary
                                    text: "Action"
                                }
                            ]
                            rightActions: [
                                B.Button {
                                    icon.name: checked ? "favorite" : "favorite_border"
                                    checkable: true
                                    order: B.Button.Order.Tertiary
                                },

                                B.Button {
                                    icon.name: "chat_bubble_outline"
                                    order: B.Button.Order.Tertiary
                                },

                                B.Button {
                                    icon.name: "share"
                                    order: B.Button.Order.Tertiary
                                }
                            ]
                        }

                        B.Card {
                            width: 300
                            media: B.Thumbnail {
                                source: root.thumbImgSrc
                            }
                            overline: "tech"
                            title: "Lorem Ipsum"
                            subtitle: "by John Doe"
                        }

                        B.Card {
                            width: 300
                            menu: B.Menu {
                                B.MenuItem {
                                    text: "Cut"
                                    shortcut: StandardKey.Cut
                                }
                                B.MenuItem {
                                    text: "Copy"
                                    shortcut: StandardKey.Copy
                                }
                                B.MenuItem {
                                    text: "Paste"
                                    shortcut: StandardKey.Paste
                                }
                            }

                            media: B.Thumbnail {
                                source: root.thumbImgSrc
                            }
                            overline: "tech"
                            title: "Lorem Ipsum"
                            subtitle: "by John Doe"
                        }

                        B.Card {
                            width: 300
                            menu: B.Menu {
                                B.MenuItem {
                                    text: "Cut"
                                    shortcut: StandardKey.Cut
                                }
                                B.MenuItem {
                                    text: "Copy"
                                    shortcut: StandardKey.Copy
                                }
                                B.MenuItem {
                                    text: "Paste"
                                    shortcut: StandardKey.Paste
                                }
                            }
                            overline: "tech"
                            title: "Lorem Ipsum Dolor Sit Amet"
                            subtitle: "by John Doe"
                            description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. "
                        }

                        B.Card {
                            width: 400
                            header: "Header"
                            subheader: "Subheader"
                            headerIcon: "home"
                            menu: B.Menu {
                                B.MenuItem {
                                    text: "Cut"
                                    shortcut: StandardKey.Cut
                                }
                                B.MenuItem {
                                    text: "Copy"
                                    shortcut: StandardKey.Copy
                                }
                                B.MenuItem {
                                    text: "Paste"
                                    shortcut: StandardKey.Paste
                                }
                            }
                            overline: "tech"
                            title: "Lorem Ipsum Dolor Sit Amet"
                            subtitle: "by John Doe"
                            description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. "
                        }

                        B.Card {
                            width: 400
                            header: "eramne"
                            subheader: "1:12 PM, 1/28/2022"
                            headerAvatar: root.avatarImgSrc
                            description: "hello how are you today"
                        }
                    }
                }
            }
        }
    }
}
