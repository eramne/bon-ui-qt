import QtQuick
import bon as B

B.TextBase {
    color: !dark ? B.Theme.palette.text.label : B.Theme.palette.text.label_dark
    font: B.Theme.text.label
}
