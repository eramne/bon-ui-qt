import QtQuick
import bon as B

B.TextField {
    id: root
    property alias selectRange: datePopup.selectRange
    property alias currentDate: datePopup.currentDate
    property alias currentEndDate: datePopup.currentEndDate
    property alias editDate: datePopup.editDate
    property alias editEndDate: datePopup.editEndDate
    field.text: datePopup.editDate.toLocaleDateString(Qt.locale(), Locale.ShortFormat) + (!selectRange ? "" : (datePopup.oneDateSelected ? "" : " - " + datePopup.editEndDate.toLocaleDateString(Qt.locale(), Locale.ShortFormat)));
    field.readOnly: true

    buttonIcon: "today"
    onIconClicked: {
        datePopup.open();
    }

    field.onFocusChanged: {
        if (field.focus) {
            datePopup.open();
        }
    }

    B.DatePicker {
        id: datePopup
        currentDate: new Date()
        currentEndDate: new Date()
    }
}
