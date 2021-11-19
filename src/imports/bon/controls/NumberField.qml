import QtQuick
import QtQuick.Layouts
import "../lib/BigEval.min.js" as BigEval
import bon

TextInputBase {
    id: control
    width: 160
    property bool showStepButtons: false
    property real value: 0
    property real from: -Infinity
    property real to: Infinity
    property real stepSize: 1
    property bool wrap: false
    property bool editable: true
    property string displayText: field.displayText

    field.readOnly: !editable

    onValueChanged: {
        field.text = value;
    }

    field.onEditingFinished: {
        value = valueFromText(field.text, Qt.locale());
        field.text = value;
    }

    Timer {
        interval: 1
        running: true
        repeat: false
        onTriggered: {
            field.clear();
            field.insert(0,value);
        }
    }

    function valueFromText(text, locale) {
        var val = 0;
        try {
            var tmp = __app__.bigEval.exec(text);
            if (tmp !== "ERROR") {
                val = parseFloat(tmp);
            } else {
                val = value;
            }
        } catch (e) {
            val = value;
        }
        return fixValue(val);
    }

    function fixValue(x) {
        var tmpValue = x;
        if (wrap) {
            if (x > to || x < from) {
                while (tmpValue > to) {
                    tmpValue -= (to - from)
                }
                while (tmpValue < from) {
                    tmpValue += (to - from)
                }
            }
        } else {
            if (x > to) {
                tmpValue = to;
            }
            if (x < from) {
                tmpValue = from;
            }
        }
        return tmpValue;
    }

    function increase() {
        value = fixValue(value + stepSize);
    }

    function decrease() {
        value = fixValue(value - stepSize);
    }

    _trailingIcons: Component {
        Row {
            visible: control.enabled && control.showStepButtons
            spacing: 10
            Layout.alignment: Qt.AlignVCenter
            rightPadding: 0

            SmallIconButton {
                offIcon: "keyboard_arrow_up"

                onClicked: {
                    control.increase();
                }

                onDoubleClicked: {
                    control.increase();
                }
            }

            SmallIconButton {
                offIcon: "keyboard_arrow_down"

                onClicked: {
                    control.decrease();
                }

                onDoubleClicked: {
                    control.decrease();
                }
            }
        }
    }
}
