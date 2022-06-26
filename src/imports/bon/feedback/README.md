# Feedback

Controls for showing progress or status, like progress bars, tooltips, notifications, alerts, etc.

QML types:

[Alert](#alert)

[Dialog](#dialog)

[ProgressBar](#progressbar)

[ProgressCircle](#progresscircle)

[Toast](#toast)

[ToolTip](#tooltip)

---

## Alert

Inherits: [bon.Pane](link needed)

A non-modal alert/message, embedded in a page rather than in a popup, displaying information or requesting an action to be taken.

### Properties

**`actions`** : **[list](https://doc.qt.io/qt-6/qml-list.html)\<[Button](/src/imports/bon/action/README.md#button)\>** - An list of buttons to optionally be shown at the bottom-right to allow the user to dismiss or take action from the alert.

**`description`** : **required [string](https://doc.qt.io/qt-6/qml-string.html)** - The description of the message, displayed just below the title/heading.

**`icon.name`** : **[string](https://doc.qt.io/qt-6/qml-string.html)** - The icon to show at the top-right. The default icon shown as well as its color depends on the `variant` property.

**`title`** : **required [string](https://doc.qt.io/qt-6/qml-string.html)** - The title/heading of the message, displayed at the top.

**`variant`** : **Alert.Variant** - The type or tone of the message to be shown, e.g. `Neutral`, `Success`, `Error`, etc. Affects the border, icon color, and the default icon. When set to `Alert.Variant.Neutral`, no border is shown and the icon is hidden. Set to `Alert.Variant.Neutral` by default.

### Enums

**`Variant`** - Represents the type or tone of message an alert shows. See `Alert.variant`.

- *`Alert.Variant.Neutral`* - The default, shows no border or icon, for neutral or unimportant tones or when nothing else fits.
- *`Alert.Variant.Info`* - For informational messages, shows a blue border with a blue "info" icon.
- *`Alert.Variant.Success`* - For success messages, shows a green border with a green check icon.
- *`Alert.Variant.Warning`* - For warning messages, shows a yellow border with a yellow "warning" icon.
- *`Alert.Variant.Error`* - For error messages, shows a red border with a red "error" icon.

**[All inherited members](link needed)**

### Examples

```qml
import QtQuick;
import bon as B;

B.Alert {
    id: alert1;
    title: "Couldn't sign in";
    description: "Please check your internet connection and try again.";
    variant: B.Alert.Variant.Error;
    Component.onCompleted: open();
    actions: [
        B.Button {
            text: "Dismiss";
            order: B.Button.Order.Tertiary;
            onClicked: {
                alert1.close();
            }
        },
        B.Button {
            text: "Retry";
            order: B.Button.Order.Tertiary;
        }
    ]
}
```

---

## Dialog

Inherits: [QtQuick.Controls.Popup](https://doc.qt.io/qt-6/qml-qtquick-controls2-popup.html)

A modal dialog, dimming the rest of the window and requesting an action to be taken.

### Properties

**`actions`** : **[required list](https://doc.qt.io/qt-6/qml-list.html)\<[Button](/src/imports/bon/action/README.md#button)\>** - An list of buttons to be shown at the bottom-right to allow the user to dismiss or take action from the dialog.

**`description`** : **required [string](https://doc.qt.io/qt-6/qml-string.html)** - The description of the message, displayed just below the title/heading.

**`icon.name`** : **[string](https://doc.qt.io/qt-6/qml-string.html)** - The icon to show at the top-right.

**`title`** : **required [string](https://doc.qt.io/qt-6/qml-string.html)** - The title/heading of the message, displayed at the top.

**[All inherited members on doc.qt.io](https://doc.qt.io/qt-6/qml-qtquick-controls2-popup.html)**

### Examples

```qml
import QtQuick;
import bon as B;

B.Dialog {
    id: dialog1;
    icon.name: "warning";
    title: "Discard draft?";
    description: "All changes will be lost.";
    actions: [
        B.Button {
            text: "Cancel";
            order: B.Button.Order.Secondary;
            onClicked: {
                dialog1.close();
            }
        },
        B.Button {
            text: "Delete";
            order: B.Button.Order.Primary;
            onClicked: {
                dialog1.close();
            }
        }
    ]
}

B.Button {
    text: "Show dialog";
    onClicked: {
        dialog1.open();
    }
}
```

---

## ProgressBar

Inherits: [QtQuick.Controls.ProgressBar](https://doc.qt.io/qt-6/qml-qtquick-controls2-progressbar.html)

For displaying the progress and/or status of a task.

### Properties

**`state`** : **ProgressBar.State** - Effects the color and animation of the bar. Set to `ProgressBar.State.Paused` by default. See `ProgressBar.State`.

### Enums

**`State`** - Represents the current status of the task. See `ProgressBar.state`.

- *`ProgressBar.State.Running`* - The task is currently running. The progress bar's indicator will be animated.
- *`ProgressBar.State.Paused`* - The task is paused or not running. The progress bar will not be animated, and the indicator will be shown at whatever value it left off at, with a less contrasting color.
- *`ProgressBar.State.Success`* - The task has finished successfully. The progress bar will not be animated, and the whole bar will show as a soft green color.
- *`ProgressBar.State.Error`* - The task has been cancelled or ran into an error. The progress bar will not be animated, and the whole bar will show as a soft red color.

**[All inherited members on doc.qt.io](https://doc.qt.io/qt-6/qml-qtquick-controls2-progressbar.html)**

### Examples

```qml
import QtQuick;
import bon as B;

B.ProgressBar {
    width: 200;
    from: 0;
    to: 1;
    value: 0;
    state: B.ProgressBar.State.Running;

    Timer {
        interval: 500;
        running: true;
        repeat: true;
        onTriggered: function () {
            parent.value += Math.random()/5;
            if (parent.value >= 1) {
                parent.value = 0;
            }
        }
    }
}
```

```qml
import QtQuick;
import bon as B;

B.ProgressBar {
    width: 200;
    from: 0;
    to: 1;
    value: 0;
    indeterminate: true;
    state: B.ProgressBar.State.Running;
}
```

---

## ProgressCircle

Inherits: [QtQuick.Controls.ProgressBar](https://doc.qt.io/qt-6/qml-qtquick-controls2-progressbar.html)

For displaying the progress and/or status of a task.

### Properties

**`small`** : **[bool](https://doc.qt.io/qt-6/qml-bool.html)** - Whether the progress circle should be shown as a smaller variant. `false` by default.

**`state`** : **ProgressCircle.State** - Effects the color and animation of the circle. Set to `ProgressCircle.State.Paused` by default. See `ProgressCircle.State`.

### Enums

**`State`** - Represents the current status of the task. See `ProgressCircle.state`.

- *`ProgressCircle.State.Running`* - The task is currently running. The progress circle's indicator will be animated.
- *`ProgressCircle.State.Paused`* - The task is paused or not running. The progress circle will not be animated, and the indicator will be shown at whatever value it left off at, with a less contrasting color.
- *`ProgressCircle.State.Success`* - The task has finished successfully. The progress circle will not be animated, and the whole circle will show as a soft green color.
- *`ProgressCircle.State.Error`* - The task has been cancelled or ran into an error. The progress circle will not be animated, and the whole circle will show as a soft red color.

**[All inherited members on doc.qt.io](https://doc.qt.io/qt-6/qml-qtquick-controls2-progressbar.html)**

### Examples

```qml
import QtQuick;
import bon as B;

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
```

```qml
import QtQuick;
import bon as B;

B.ProgressCircle {
    from: 0
    to: 1
    value: 0
    indeterminate: true
    state: B.ProgressCircle.State.Running
    small: true
}
```

---

## Toast

Inherits: [QtQuick.Controls.Popup](https://doc.qt.io/qt-6/qml-qtquick-controls2-popup.html)

A small notification to be put in a queue to be shown at the bottom of the window one at a time, displaying information or requesting an action to be taken.

### Properties

**`action`** : **[Button](/src/imports/bon/action/README.md#button)** - A button to optionally be shown at the right to allow the user to take action from the notification.

**`text`** : **required [string](https://doc.qt.io/qt-6/qml-string.html)** - The text shown in the notification.

**`icon.name`** : **[string](https://doc.qt.io/qt-6/qml-string.html)** - The icon to show at the left. The default icon shown as well as its color depends on the `variant` property.

**`variant`** : **Toast.Variant** - The type or tone of the message to be shown, e.g. `Neutral`, `Success`, `Error`, etc. Affects the border, icon color, and the default icon. When set to `Toast.Variant.Neutral`, no border is shown and the icon is hidden. Set to `Toast.Variant.Neutral` by default.

### Functions

**[int](https://doc.qt.io/qt-6/qml-int.html)** **`getPriority`**() - Used for calculating the order in which to show notifications if there are multiple waiting in the queue, in range from 1-8, where 1 shows first and 8 shows last.

> Priority 1 - Actionable, Error
>
> Priority 2 - Error
>
> Priority 3 - Actionable, Success
>
> Priority 4 - Actionable, Info
>
> Priority 5 - Actionable, Neutral
>
> Priority 6 - Success
>
> Priority 7 - Info
>
> Priority 8 - Neutral

### Enums

**`Variant`** - Represents the type or tone of message a notification shows. See `Toast.variant`.

- *`Toast.Variant.Neutral`* - The default, shows no border or icon, for neutral or unimportant tones or when nothing else fits.
- *`Toast.Variant.Info`* - For informational messages, shows a blue border with a blue "info" icon.
- *`Toast.Variant.Success`* - For success messages, shows a green border with a green check icon.
- *`Toast.Variant.Error`* - For error messages, shows a red border with a red "error" icon.

**[All inherited members on doc.qt.io](https://doc.qt.io/qt-6/qml-qtquick-controls2-popup.html)**

### Examples

```qml
import QtQuick;
import bon as B;

B.Toast {
    id: toast1
    text: "5 files converted successfully"
    icon.name: "check"
    variant: B.Toast.Variant.Success
}

B.Button {
    text: "Show toast"
    onClicked: {
        toast1.queue()
    }
}
```

```qml
import QtQuick;
import bon as B;

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
    text: "Show toast 2"
    onClicked: {
        toast2.queue()
    }
}
```

---

## ToolTip

Inherits: [QtQuick.Controls.ToolTip](https://doc.qt.io/qt-6/qml-qtquick-controls2-tooltip.html)

A tooltip that anchors to its parent item's horizontal center and either just below or above the item, and should be shown on hover. You must set its `visible` property manually.

**[All inherited members on doc.qt.io](https://doc.qt.io/qt-6/qml-qtquick-controls2-tooltip.html)**

### Examples

```qml
import QtQuick;
import bon as B;

B.Button {
    text: "Click me!";

    B.ToolTip {
        text: "Test Tooltip";
        visible: parent.hovered;
    }
}
```
