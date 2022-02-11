import QtQuick
import QtQuick.Layouts
import QtQuick.Templates as T
import bon as B

Item {
    id: root
    width: 220
    height: 100

    opacity: !root.enabled ? B.Theme.disabled_opacity : 1
    layer.enabled: !root.enabled

    property bool bordered: true
    property string helpText: ""
    property string labelText: ""
    property bool showCharacterCount: false
    property bool wordWrap: false

    property alias area: area

    ColumnLayout {
        spacing: 4
        anchors.fill: parent

        B.CaptionText {
            id: label
            Layout.fillWidth: true
            Layout.leftMargin: 10
            Layout.rightMargin: 10
            text: root.labelText
            opacity: 0.5
            visible: root.labelText.length > 0
            elide: Text.ElideRight
        }

        Item {
            Layout.fillHeight: true
            Layout.fillWidth: true

            Rectangle {
                id: background
                anchors.fill: parent
                border.width: root.bordered ? 2 : 0
                border.color: area.focus ? B.Theme.palette.background_2 : B.Theme.palette.background_1
                radius: 8
                color: B.Theme.palette.background

                Behavior on border.color {
                    ColorAnimation {
                        duration: B.Theme.animations.basic.duration
                        easing.type: B.Theme.animations.basic.type
                    }
                }
            }

            Flickable {
                id: flickable
                anchors.fill: parent
                contentWidth: area.implicitWidth
                contentHeight: area.implicitHeight
                boundsBehavior: Flickable.StopAtBounds
                clip: true

                B.ScrollBar.vertical: B.ScrollBar { }
                B.ScrollBar.horizontal: B.ScrollBar { }

                function ensureVisible(r) {
                     if (contentX >= r.x)
                         contentX = r.x;
                     else if (contentX+width <= r.x+r.width)
                         contentX = r.x+r.width-width;
                     if (contentY >= r.y)
                         contentY = r.y;
                     else if (contentY+height <= r.y+r.height)
                         contentY = r.y+r.height-height;
                }

                T.TextArea {
                    id: area

                    implicitWidth: Math.max(contentWidth + leftPadding + rightPadding,
                                                implicitBackgroundWidth + leftInset + rightInset,
                                                placeholder.implicitWidth + leftPadding + rightPadding)
                    implicitHeight: Math.max(contentHeight + topPadding + bottomPadding,
                                             implicitBackgroundHeight + topInset + bottomInset,
                                             placeholder.implicitHeight + topPadding + bottomPadding)

                    color: B.Theme.palette.text.label
                    selectionColor: B.Theme.palette.selection_background
                    selectedTextColor: B.Theme.palette.selection_text
                    font: B.Theme.text.label
                    selectByMouse: true
                    enabled: root.enabled
                    hoverEnabled: root.enabled
                    padding: 10
                    wrapMode: root.wordWrap ? TextEdit.Wrap : TextEdit.NoWrap
                    width: root.wordWrap ? root.width : implicitWidth
                    onCursorRectangleChanged: flickable.ensureVisible(Qt.rect(cursorRectangle.x - leftPadding,
                                                                              cursorRectangle.y - topPadding,
                                                                              cursorRectangle.width + leftPadding + topPadding,
                                                                              cursorRectangle.height + topPadding + bottomPadding))

                    B.LabelText {
                        id: placeholder
                        x: area.leftPadding
                        y: area.topPadding
                        width: area.width - (area.leftPadding + area.rightPadding)
                        height: area.height - (area.topPadding + area.bottomPadding)

                        text: area.placeholderText
                        opacity: 0.5
                        verticalAlignment: area.verticalAlignment
                        visible: !area.length && !area.preeditText && (!area.activeFocus || area.horizontalAlignment !== Qt.AlignHCenter)
                    }
                }
            }
        }

        RowLayout {
            Layout.fillWidth: true
            Layout.leftMargin: 10
            Layout.rightMargin: 10
            visible: root.helpText.length > 0 || root.showCharacterCount

            B.CaptionText {
                id: helpText
                Layout.fillWidth: true
                text: root.helpText
                opacity: 0.5
                visible: root.helpText.length > 0
                elide: Text.ElideRight
            }

            B.CaptionText {
                text: area.length
                Layout.fillWidth: !helpText.visible
                horizontalAlignment: Text.AlignRight
                opacity: 0.5
                visible: root.showCharacterCount
                elide: Text.ElideRight
            }
        }
    }
}
