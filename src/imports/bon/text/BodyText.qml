import QtQuick
import bon as B

B.TextBase {
    color: !dark ? B.Theme.palette.text.body : B.Theme.palette.text.body_dark
    font: B.Theme.text.body
}
