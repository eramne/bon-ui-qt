# Input

Controls for user choices and forms, such as radio buttons, combo boxes, color pickers, dials, sliders, text areas, switches, etc.

QML types:

[CheckBox](#checkbox)

[Chip](#chip)

[ChipInput](#chipinput)

[ChipSet](#chipset)

[Choice](#choice)

[ColorField](#colorfield)

[ColorSwatch](#colorswatch)

[ComboBox](#combobox)

[DateField](#datefield)

[Dial](#dial)

[NumberField](#numberfield)

[Option](#option)

[RadioButton](#radiobutton)

[Rating](#rating)

[Slider](#slider)

[Switch](#switch)

[TextArea](#textarea)

[TextField](#textfield)

[TextInputBase](#textinputbase)

[TimeField](#timefield)

[ToggleButton](#togglebutton)

[ToggleButtonGroup](#togglebuttongroup)

[Tumbler](#tumbler)

---

## CheckBox

Inherits: [QtQuick.Controls.CheckBox](https://doc.qt.io/qt-6/qml-qtquick-controls2-checkbox.html)

Used to allow the user to pick from a set of options. Unlike `RadioButton`, it is not mutually-exclusive, meaning multiple options can be picked at once. Also see [RadioButton](link needed).

### Properties

**`effectiveState`** : **CheckBox.State** - Whether the control is on, off, or in a mixed state. See the `CheckBox.State` enum. If `mixed` is true, will be set to `CheckBox.State.Mixed`, otherwise will be set to `CheckBox.State.On` if checked or `CheckBox.State.Off` if unchecked.

**`mixed`** : **[bool](https://doc.qt.io/qt-6/qml-bool.html)** - If the control is in a mixed state. `false` by default.

### Enums

**`State`** - Represents the control's power state, e.g. on or off. See `CheckBox.effectiveState`.

- *`CheckBox.State.On`* - The control is on.
- *`CheckBox.State.Off`* - The control is off.
- *`CheckBox.State.Mixed`* - The control is in a mixed state, e.g. if in a tree view in which some of the children items are checked and some are unchecked.

### Examples

```qml
import QtQuick;
import bon as B;

B.CheckBox {}

B.CheckBox {checked: true}

B.CheckBox {mixed: true}

B.CheckBox {enabled: false}

B.CheckBox {checked: true; enabled: false}

B.CheckBox {mixed: true; enabled: false}
```

## Chip

Inherits: [QtQuick.Controls.Button](https://doc.qt.io/qt-6/qml-qtquick-controls2-button.html)

A multi-purpose control shown in groups, appearing similarly to a `Button`, but with more varying functions, to be used with other chips as a selection, a choice, or a set of actions. Also see [ChipSet](link needed) and [ChipInput](link needed).

### Properties

**`variant`** : **Chip.Variant** - How the chip will appear and function, e.g. whether it should be used like an action button, a checkbox or radio button, or a selection. See the `Chip.Variant` enum. Set to `Chip.Variant.Action` by default.

### Signals

**`closed`**() - Emitted when the close button is clicked to hide an `Input` chip.
> **Note:** The corresponding handler is `onClosed`.

### Enums

**`Variant`** - Represents how a chip will appear and function. See `Chip.variant`.

- *`Chip.Variant.Action`* - Presents itself as a clickable button, can be pressed to execute an option.
- *`Chip.Variant.Choice`* - Presents itself as a toggleable button, can be used in a `ChipSet` to provide a set of choices, and can be set as exclusive or not, to function similarly to a `CheckBox` set or `RadioButton` set. Has a check icon on the left and turns a different color when checked, similar to a `CheckBox`.
- *`Chip.Variant.Input`* - Presents itself as an item with a close button on the right which hides the chip. Can be used for selections or filters with a `ChipInput` element, which utilizes a `ComboBox` to add input chips which can be removed from the selection with the close button.

### Examples

```qml
import QtQuick;
import bon as B;

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
```

```qml
import QtQuick;
import bon as B;

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
```

---

## ChipInput

Inherits: [QtQuick.Item](https://doc.qt.io/qt-6/qml-qtquick-item.html)

To input a selection of various choices specified by the `model` property, in which choices can be added and removed. Utilizes a `ComboBox` to add input chips which can be removed from the selection with its close button. Also see [ComboBox](link needed), [Chip](link needed), and [ChipSet](link needed).

### Properties

**`model`** : **[list](https://doc.qt.io/qt-6/qml-list.html)\<[listelement](link needed)\>** - A list model of the options from which the user can select.

**`selection`** : **[list](https://doc.qt.io/qt-6/qml-list.html)\<[listelement](link needed)\>** - A list of items from the `model` that have been selected by the user.

### Examples

```qml
import QtQuick;
import bon as B;

B.ChipInput {
    model: [
        { name: "Point" },
        { name: "Line" },
        { name: "Triangle" },
        { name: "Square" },
        { name: "Rectangle" },
        { name: "Hexagon" },
        { name: "Polygon" },
        { name: "Circle" }
    ]
}
```

---

## ChipSet

Inherits: [bon.OverflowArea](link needed)

For a set of multiple chips shown side by side. A `Chip` should always be joined with other chips in a `ChipSet`, otherwise its functionality would be better suited by a `Button` or other control.

### Properties

**`chips`** : **[default list](https://doc.qt.io/qt-6/qml-list.html)\<[Chip](#chip)\>** - A list of chips that will be shown side by side.

**`exclusive`** : **[bool](https://doc.qt.io/qt-6/qml-bool.html)** - Whether or not only one chip can be chosen at a time, to function similarly to a radio button rather than a check box. For `Choice` variant chips only. `false` by default.

**`overflow`** : **[bool](https://doc.qt.io/qt-6/qml-bool.html)** - Whether the chip set should be horizontally scrollable in a fixed-height container or if it should wrap the chips in a container with varying height. `false` by default.

**`variant`** : **Chip.Variant** - How the chips will appear and function. See the `Chip.variant` property.

### Examples

```qml
import QtQuick;
import bon as B;

B.ChipSet {
    variant: B.Chip.Variant.Input;
    overflow: true;
    B.Chip {
        text: "John Doe";
        icon.name: "face";
    }
    B.Chip {
        text: "Jane Doe";
    }
    B.Chip {
        text: "Joe Q. Public";
        icon.name: "face";
    }
    B.Chip {
        text: "Johnny Doe";
    }
}
```

---

## Choice

Inherits: [QtQuick.Controls.Control](https://doc.qt.io/qt-6/qml-qtquick-controls2-control.html)

For a multiple-choice form selection, displaying a list of `Option` items, using either check boxes or radio buttons depending on the `exclusive` property. Also see [Option](link needed).

### Properties

**`exclusive`** : **[bool](https://doc.qt.io/qt-6/qml-bool.html)** - Whether or not only one option can be chosen at a time, and show radio buttons rather than check boxes. `false` by default.

**`group`** : **[ButtonGroup](https://doc.qt.io/qt-6/qml-qtquick-controls2-buttongroup.html)** - A reference to the control's internal `ButtonGroup` item.

**`options`** : **[default list](https://doc.qt.io/qt-6/qml-list.html)\<[Option](#link needed)\>** - A list of options to select from, shown with a label and either a radio button or check box.

### Examples

```qml
import QtQuick;
import bon as B;

B.Choice {
    id: multipleChoice;
    width: 300;
    exclusive: false;

    function submitForm() {
        console.log("Option 1 is " + (option1.checked ? "checked" : "unchecked"));
        console.log("Option 2 is " + (option2.checked ? "checked" : "unchecked"));
        console.log("Option 3 is " + (option3.checked ? "checked" : "unchecked"));
    }

    B.Option {
        id: option1;
        name: "Option 1";
    }

    B.Option {
        id: option2;
        name: "Option 2";
    }

    B.Option {
        id: option2;
        name: "Option 3";
    }
}
```

---

## ColorField

Inherits: [bon.ColorSwatch](link needed)

For inputting a color. Displays a color swatch which opens a popup with a color picker when clicked, containing a box controlling the value and saturation, two sliders for the hue and alpha, and a combo box and text fields for setting specific values. Also see [ColorSwatch](link needed).

### Properties

**`currentColor`** : **[color](https://doc.qt.io/qt-6/qml-color.html)** - The color that has been chosen and saved. Use this property to reference the selected color.

**`editColor`** : **[color](https://doc.qt.io/qt-6/qml-color.html)** - The temporary color that is being changed as the popup is still open. Resets to the `currentColor` if canceled.

### Examples

```qml
import QtQuick;
import bon as B;

B.ColorField {
    currentColor: "#e16c88";
    onCurrentColorChanged: {
        console.log(currentColor);
    }
}
```

---

## ColorSwatch

Inherits: [QtQuick.Controls.RadioButton](https://doc.qt.io/qt-6/qml-qtquick-controls2-radiobutton.html)

For choosing a color from a set like a radio button, e.g. choosing from a palette, or choosing the color of an item of clothing in an order form.

### Properties

**`color`** : **[color](https://doc.qt.io/qt-6/qml-color.html)** - The color that is displayed on the button. If transparent, will show a checkerboard background behind it.

### Examples

```qml
import QtQuick;
import bon as B;

B.ColorSwatch {
    color: "#cc66788A";
}

B.ColorSwatch {
    color: "#74D2D8";
}

B.ColorSwatch {
    color: "#D1B4B4";
}

B.ColorSwatch {
    color: "#D1B4B4";
    enabled: false;
}
```

---

## ComboBox

Inherits: [bon.TextInputBase](link needed)

For inputting one plain text option from a set. Allows picking from a dropdown list or typing into the text box to function like a search bar to filter options. Can also be customized the same way other text fields can. Also see [List](link needed) and [TextInputBase](link needed).

### Properties

**`editable`** : **[bool](https://doc.qt.io/qt-6/qml-bool.html)** - If the text field should be editable, to allow the combobox to function like a search box to filter the options. Otherwise, it will behave simply like a dropdown menu, with the field being read-only and able to be pressed to open the dropdown list and select an option. `true` by default.

**`maxPopupHeight`** : **[real](https://doc.qt.io/qt-6/qml-real.html)** - For the maximum height of the dropdown list. Its height will be set to the height of the list's contents if small enough, otherwise will be set to this value and be scrollable. `300.0` by default.

**`model`** : **[list](https://doc.qt.io/qt-6/qml-list.html)\<[listelement](link needed)\>** - A list model of the options from which the user can select.

**`selectedIndex`** : **[int](https://doc.qt.io/qt-6/qml-int.html)** - The index of the item currently selected by the user.

**`value`** : **[readonly string](https://doc.qt.io/qt-6/qml-string.html)** - The item currently selected by the user.

### Examples

```qml
import QtQuick;
import bon as B;

B.ComboBox {
    width: 100;
    editable: false;
    selectedIndex: 2;

    model: [
        { name: "RGBA" },
        { name: "HSVA" },
        { name: "HEX" }
    ]
}
```

---

## DateField

Inherits: [bon.TextField](link needed)

For inputting a date or a date range. Shows a grid of date buttons, and two arrow buttons to change the month.

### Properties

**`currentDate`** : **[date](https://doc.qt.io/qt-6/qml-date.html)** - The date that has been chosen and saved. Use this property to reference the selected date.

**`currentEndDate`** : **[date](https://doc.qt.io/qt-6/qml-date.html)** - If `selectRange` is true, set to the date at the end of the range, chosen and saved.

**`editDate`** : **[date](https://doc.qt.io/qt-6/qml-date.html)** - The temporary date that is being changed as the popup is still open. Resets to the `currentDate` if canceled.

**`editEndDate`** : **[date](https://doc.qt.io/qt-6/qml-date.html)** - If `selectRange` is true, set to the date at the end of the range, being chosen as the popup is still open.

**`selectRange`** : **[bool](https://doc.qt.io/qt-6/qml-bool.html)** - If the picker should be to select a range of dates, otherwise just a single date. `false` by default.

### Examples

```qml
import QtQuick;
import bon as B;

B.DateField {
    onCurrentDateChanged: {
        console.log(field.text);
    }
}

B.DateField {
    selectRange: true;
}
```

---

## Dial

Inherits: [QtQuick.Controls.Dial](https://doc.qt.io/qt-6/qml-qtquick-controls2-dial.html)

Used to allow the user to choose a numerical value from a sliding circle. Also see [Slider](link needed).

### Properties

**`showValue`** : **[bool](https://doc.qt.io/qt-6/qml-bool.html)** - Whether the value of the dial should be shown in a circle around the dial, a dotted line if snapping is on or a solid line otherwise. `false` by default.

### Examples

```qml
import QtQuick;
import bon as B;

B.Dial {}

B.Dial {enabled: false}

B.Dial {showValue: true}

B.Dial {enabled: false; showValue: true}

B.Dial {showValue: true; snapMode: B.Dial.SnapAlways; stepSize: 0.1}

B.Dial {enabled: false; showValue: true; snapMode: B.Dial.SnapAlways; stepSize: 0.1}
```

---

## NumberField

Inherits: [bon.TextInputBase](link needed)

For inputting a number. May have increment/decrement icons. A math expression can be entered which will set the value of the field to the expression's solution. Also see [TextInputBase](link needed).

### Properties

**`editable`** : **[bool](https://doc.qt.io/qt-6/qml-bool.html)** - If the text field can be edited, otherwise only the step buttons can be used to change the value. Set to `true` by default.

**`from`** : **[real](https://doc.qt.io/qt-6/qml-real.html)** - The minimum number allowed. `-Infinity` by default.

**`showStepButtons`** : **[bool](https://doc.qt.io/qt-6/qml-bool.html)** - If increment and decrement buttons should be shown. Changes the value by `stepSize`, and will stop at `to` or `from`. Set to `false` by default.

**`stepSize`** : **[real](https://doc.qt.io/qt-6/qml-real.html)** - How much the increment/decrement buttons should change the value by. `1.0` by default.

**`to`** : **[real](https://doc.qt.io/qt-6/qml-real.html)** - The maximum number allowed. `Infinity` by default.

**`value`** : **[real](https://doc.qt.io/qt-6/qml-real.html)** - The number entered by the user.

**`wrap`** : **[bool](https://doc.qt.io/qt-6/qml-bool.html)** - If values set outside of the `from` - `to` range should wrap around to the opposite end of the range, e.g. with a `from` of 1 and a `to` of 100 and a `stepSize` of 1, if the increment button is pressed at 100, the value will wrap around to `1`. Set to `false` by default.

### Examples

```qml
import QtQuick;
import bon as B;

B.NumberField {
    value: 5;
}

B.NumberField {
    value: 5;
    from: 0;
    to: 100;
}

B.NumberField {
    value: 5;
    showStepButtons: true;
    from: 0;
    to: 100;
    stepSize: 1;
    wrap: true;
    editable: false;
}
```

---

## Option

Inherits: [QtQuick.Controls.AbstractButton](https://doc.qt.io/qt-6/qml-qtquick-controls2-abstractbutton.html)

For a single multiple-choice option, for use inside of a `Choice` item, using either a check box or a radio button depending on the `exclusive` property. Also see [Choice](link needed).

### Properties

**`button`** : **[AbstractButton](https://doc.qt.io/qt-6/qml-qtquick-controls2-buttongroup.html)** - A reference to the item's internal button control, either a `CheckBox` or a `RadioButton`.

**`enabled`** : **[bool](https://doc.qt.io/qt-6/qml-bool.html)** - Whether or not the toggle button should be able to be changed or interacted with, otherwise showing as semi-transparent. `true` by default.

**`exclusive`** : **[bool](https://doc.qt.io/qt-6/qml-bool.html)** - Whether or not only one option can be chosen at a time, and show radio buttons rather than check boxes. `false` by default.

**`name`** : **[required string](https://doc.qt.io/qt-6/qml-string.html)** - The text that should be shown beside the toggle button.

### Examples

```qml
import QtQuick;
import bon as B;

B.Choice {
    id: multipleChoice;
    width: 300;
    exclusive: false;

    function submitForm() {
        console.log("Option 1 is " + (option1.checked ? "checked" : "unchecked"));
        console.log("Option 2 is " + (option2.checked ? "checked" : "unchecked"));
        console.log("Option 3 is " + (option3.checked ? "checked" : "unchecked"));
    }

    B.Option {
        id: option1;
        name: "Option 1";
    }

    B.Option {
        id: option2;
        name: "Option 2";
    }

    B.Option {
        id: option2;
        name: "Option 3";
    }
}
```

---

## RadioButton

Inherits: [QtQuick.Controls.RadioButton](https://doc.qt.io/qt-6/qml-qtquick-controls2-radiobutton.html)

Used to allow the user to pick from a set of options. Unlike `CheckBox`, it is mutually-exclusive, meaning only one option can be picked at once. Also see [CheckBox](link needed).

### Properties

**`effectiveState`** : **RadioButton.State** - Whether the control is on, off, or in a mixed state. See the `RadioButton.State` enum. If `mixed` is true, will be set to `RadioButton.State.Mixed`, otherwise will be set to `RadioButton.State.On` if checked or `RadioButton.State.Off` if unchecked.

**`mixed`** : **[bool](https://doc.qt.io/qt-6/qml-bool.html)** - If the control is in a mixed state. `false` by default.

### Enums

**`State`** - Represents the control's power state, e.g. on or off. See `CheckBox.effectiveState`.

- *`RadioButton.State.On`* - The control is on.
- *`RadioButton.State.Off`* - The control is off.
- *`RadioButton.State.Mixed`* - The control is in a mixed state, e.g. if in a tree view in which some of the children items are checked and some are unchecked.

### Examples

```qml
import QtQuick;
import bon as B;

B.RadioButton {}

B.RadioButton {checked: true}

B.RadioButton {mixed: true}

B.RadioButton {enabled: false}

B.RadioButton {checked: true; enabled: false}

B.RadioButton {mixed: true; enabled: false}
```

---

## Rating

Inherits: [QtQuick.Item](https://doc.qt.io/qt-6/qml-qtquick-item.html)

To either input an integer rating or to display an average rating.

### Properties

**`displayValue`** : **[real](https://doc.qt.io/qt-6/qml-real.html)** - The value to be displayed in the rating stars, unless a value has been entered by the user if `editable` is true.

**`editable`** : **[bool](https://doc.qt.io/qt-6/qml-bool.html)** - If this control should be used for entering ratings or only for display. `true` by default.

**`enteredValue`** : **[int](https://doc.qt.io/qt-6/qml-int.html)** - The amount of stars currently entered by the user.

**`hovered`** : **[bool](https://doc.qt.io/qt-6/qml-bool.html)** - If the control is being hovered by the mouse.

**`pressed`** : **[bool](https://doc.qt.io/qt-6/qml-bool.html)** - If the control is being pressed by the mouse.

### Examples

```qml
import QtQuick;
import bon as B;

B.Rating { }

B.Rating {
    editable: false;
    displayValue: 2.35;
}

B.Rating {
    enabled: false;
}
```

---

## Slider

Inherits: [QtQuick.Controls.Slider](https://doc.qt.io/qt-6/qml-qtquick-controls2-slider.html)

Used to allow the user to choose a numerical value from a sliding bar. Shows a tooltip which displays the value of the slider when pressed. Also see [Dial](link needed).

### Examples

```qml
import QtQuick;
import bon as B;

B.Slider {}

B.Slider {enabled: false}

B.Slider {orientation: Qt.Vertical}

B.Slider {
    from: 0;
    value: 25;
    to: 100;
    stepSize: 25;
    snapMode: B.Slider.SnapAlways;
}

B.Slider {
    from: 0;
    value: 25;
    to: 100;
    stepSize: 25;
    snapMode: B.Slider.SnapAlways;
    orientation: Qt.Vertical;
}
```

---

## Switch

Inherits: [QtQuick.Controls.Switch](https://doc.qt.io/qt-6/qml-qtquick-controls2-switch.html)

A simple control which can be toggled on or off.

### Examples

```qml
import QtQuick;
import bon as B;

B.Switch {}

B.Switch {checked: true}

B.Switch {enabled: false}

B.Switch {checked: true; enabled: false}
```

---

## TextArea

Inherits: [QtQuick.Item](https://doc.qt.io/qt-6/qml-qtquick-item.html)

For inputting a string of text that can span multiple lines. Use the `area`'s `text` property to get the entered text. Also see [TextField](link needed) and [TextInputBase](link needed).

### Properties

**`area`** : **[TextArea](https://doc.qt.io/qt-6/qml-qtquick-controls2-textarea.html)** - A reference to the internal `QtQuick.Controls.TextArea` control, which inherits many important properties such as `text`, `placeholderText`, `length`, `selectionStart`, etc.

**`bordered`** : **[bool](https://doc.qt.io/qt-6/qml-bool.html)** - If a border should be shown around the area, otherwise will blend in with the background. `true` by default.

**`helpText`** : **[string](https://doc.qt.io/qt-6/qml-string.html)** - A small informational caption to be shown below the area, like "*Required" or "Error" or "Too long" or "Invalid number".

**`labelText`** : **[string](https://doc.qt.io/qt-6/qml-string.html)** - A small caption to be shown above the area to give a short description or title of the field.

**`showCharacterCount`** : **[bool](https://doc.qt.io/qt-6/qml-bool.html)** - If a tiny caption should be shown in the bottom-right of the control displaying the length of the text entered. `false` by default.

**`wordWrap`** : **[bool](https://doc.qt.io/qt-6/qml-bool.html)** - If the text should wrap around when a line gets too long, otherwise will be horizontally scrollable when a line gets long. `false` by default.

### Examples

```qml
import QtQuick;
import bon as B;

B.TextArea {
    enabled: false
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
    area.onTextChanged: {
        console.log(area.text);
    }
}

B.TextArea {
    area.placeholderText: "Enter message"
    bordered: false
}
```

---

## TextField

Inherits: [bon.TextInputBase](link needed)

For inputting a single-line string of text. Use the `field`'s `text` property to get the entered text. May have a button in the right side of the field. Also see [TextInputBase](link needed) and [TextArea](link needed).

### Properties

**`buttonIcon`** : **[string](https://doc.qt.io/qt-6/qml-string.html)** - The name of an icon that may show to the right of the entered text inside of the field. The `iconClicked` signal and the `onIconClicked` signal handler can be used to do something when this button is pressed.

### Examples

```qml
import QtQuick;
import bon as B;

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
```

---

## TextInputBase

Inherits: [QtQuick.Item](https://doc.qt.io/qt-6/qml-qtquick-item.html)

Inherited by:

A base class for text input fields, with features like labels, character counts, icons, buttons, validity, etc. Use the `field`'s `text` property to get the entered text.

### Properties

**`errorText`** : **[string](https://doc.qt.io/qt-6/qml-string.html)** - Red text to be shown when the `field.validator` is not met, in the same place where `helpText` would be.

**`field`** : **[TextField](https://doc.qt.io/qt-6/qml-qtquick-controls2-textfield.html)** - A reference to the internal `QtQuick.Controls.TextField` control, which inherits many important properties such as `text`, `placeholderText`, `length`, `selectionStart`, etc.

**`helpText`** : **[string](https://doc.qt.io/qt-6/qml-string.html)** - A small informational caption to be shown below the area, like "*Required" or "Error" or "Too long" or "Invalid number".

**`labelText`** : **[string](https://doc.qt.io/qt-6/qml-string.html)** - A small caption to be shown above the area to give a short description or title of the field.

**`leadingIcon`** : **[string](https://doc.qt.io/qt-6/qml-string.html)** - An icon to be shown outside of the field to the left.

**`prefixText`** : **[string](https://doc.qt.io/qt-6/qml-string.html)** - A short prefix to be shown directly before the text entered.

**`showCharacterCount`** : **[bool](https://doc.qt.io/qt-6/qml-bool.html)** - If a tiny caption should be shown in the bottom-right of the control displaying the length of the text entered. `false` by default.

**`showStatus`** : **[bool](https://doc.qt.io/qt-6/qml-bool.html)** - If the control should visibly show when a valid or invalid input is entered, e.g. a check and green accent when valid, an X and red accent when invalid, according to `field.acceptableInput`. Set to `false` by default.

**`successText`** : **[string](https://doc.qt.io/qt-6/qml-string.html)** - Green text to be shown when the `field.validator` is met, in the same place where `helpText` would be.

**`suffixText`** : **[string](https://doc.qt.io/qt-6/qml-string.html)** - A short suffix to be shown directly after the text entered.

### Signals

**`iconClicked`**() - Emitted when an icon button is clicked in certain types that inherit `TextInputBase`.
> **Note:** The corresponding handler is `onIconClicked`.

---

## TimeField

Inherits: [bon.TextField](link needed)

For inputting a time, optionally with seconds, 12 hour or 24 hour. Shows two or three tumblers for hours, minutes, and optionally seconds, an optional AM/PM choice, and text fields to alternatively pick values.

### Properties

**`currentTime`** : **[date](https://doc.qt.io/qt-6/qml-date.html)** - The time that has been chosen and saved. Use this property to reference the selected time.

**`editTime`** : **[date](https://doc.qt.io/qt-6/qml-date.html)** - The temporary time that is being changed as the popup is still open. Resets to the `currentTime` if canceled.

**`showSeconds`** : **[bool](https://doc.qt.io/qt-6/qml-bool.html)** - If an extra tumbler for selecting seconds should be shown. `false` by default.

**`twentyFourHour`** : **[bool](https://doc.qt.io/qt-6/qml-bool.html)** - If the hour tumbler should show 24 hours, otherwise 12 hours with an AM/PM choice. `false` by default.

### Examples

```qml
import QtQuick;
import bon as B;

B.TimeField { }

B.TimeField {
    twentyFourHour: true;
}

B.TimeField {
    showSeconds: true;
}

B.TimeField {
    twentyFourHour: true;
    showSeconds: true;
}
```

---

## ToggleButton

Inherits: [QtQuick.Controls.AbstractButton](https://doc.qt.io/qt-6/qml-qtquick-controls2-abstractbutton.html)

For a simple square button with an icon (no label) that can be toggled on and off. Also see [ToggleButtonGroup](link needed).

### Examples

```qml
import QtQuick;
import bon as B;

B.ToggleButtonGroup {

    B.ToggleButton {
        checked: true;
        icon.name: "format_bold";
    }
    B.ToggleButton {
        checked: false;
        enabled: false;
        icon.name: "format_italic";
    }
    B.ToggleButton {
        checked: false;
        icon.name: "format_underline";
    }
}
```

---

## ToggleButtonGroup

Inherits: [QtQuick.Item](https://doc.qt.io/qt-6/qml-qtquick-item.html)

A set of `ToggleButton` controls, shown side-by-side in a container with rounded edges. Also see [ToggleButton](link needed).

### Properties

**`buttons`** : **[default list](https://doc.qt.io/qt-6/qml-list.html)\<[ToggleButton](#link needed)\>** - A list of `ToggleButton` controls that will be shown.

---

## Tumbler

Inherits: [QtQuick.Controls.Tumbler](https://doc.qt.io/qt-6/qml-qtquick-controls2-tumbler.html)

A wheel-like control in which you can choose a number either by dragging to spin the wheel or pressing arrow buttons on either side to increment or decrement the value. Also see [TimeField](link needed).

### Properties

**`orientation`** : **orientation** - If the tumbler should be `Qt.Horizontal` or `Qt.Vertical`. Set to `Qt.Vertical` by default.

### Examples

```qml
import QtQuick;
import bon as B;

B.Tumbler {
    model: 60;
}

B.Tumbler {
    orientation: Qt.Horizontal;
    model: 60;
}
```
