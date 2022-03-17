import QtQuick
import bon as B

B.TextField {
    id: root
    field.text: !root.twentyFourHour && !root.showSeconds ? timePopup.editTime.toLocaleTimeString(Qt.locale(), "h:mm A") : (
                                                                root.twentyFourHour && !root.showSeconds ? timePopup.editTime.toLocaleTimeString(Qt.locale(), "H:mm") : (
                                                                !root.twentyFourHour && root.showSeconds ? timePopup.editTime.toLocaleTimeString(Qt.locale(), "h:mm:ss A") : (
                                                                timePopup.editTime.toLocaleTimeString(Qt.locale(), "H:mm:ss") )));
    field.readOnly: true

    property alias time: timePopup.time
    property alias editTime: timePopup.editTime
    property alias twentyFourHour: timePopup.twentyFourHour
    property alias showSeconds: timePopup.showSeconds

    buttonIcon: "schedule"
    onIconClicked: {
        timePopup.open();
    }

    field.onFocusChanged: {
        if (field.focus) {
            timePopup.open();
        }
    }

    B.TimePicker {
        id: timePopup

        /*onEditTimeChanged: {
            root.field.text = getFormattedTimeText();
        }*/
    }
}
