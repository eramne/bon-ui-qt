import QtQuick
import bon as B

B.TextField {
    id: root
    property alias selectRange: datePopup.selectRange
    property alias date: datePopup.date
    property alias endDate: datePopup.endDate
    property alias selectedDate: datePopup.selectedDate
    property alias selectedEndDate: datePopup.selectedEndDate
    field.text: !selectRange ? datePopup.selectedDate.toLocaleDateString(Qt.locale(), Locale.ShortFormat) : datePopup.selectedDate.toLocaleDateString(Qt.locale(), Locale.ShortFormat) + (datePopup.oneDateSelected ? "" : " - " + datePopup.selectedEndDate.toLocaleDateString(Qt.locale(), Locale.ShortFormat))
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
        date: new Date()
        endDate: new Date()
    }
}
