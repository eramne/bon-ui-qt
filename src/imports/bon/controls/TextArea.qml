import QtQuick
import QtQuick.Layouts
import QtQuick.Templates as T
import bon

Item {
    id: root
    width: 220
    height: 100

    opacity: _opacity
    layer.enabled: !root.enabled

    property real _borderWidth: 2
    property color _borderColor: area.focus ? __app__.style.palette.controls.background_1 : __app__.style.palette.controls.background
    property color _backgroundColor: __app__.style.palette.background
    property real _radius: 8
    property font _font: __app__.style.text.label
    property color _textColor: __app__.style.palette.text.label
    property real _opacity: !root.enabled ? __app__.style.misc_values.disabled_opacity : 1
    property real _easing: __app__.style.animations.basic.type
    property real _duration: __app__.style.animations.basic.duration

    property bool bordered: true
    property string helpText: ""
    property string labelText: ""
    property bool showCharacterCount: false
    property bool wordWrap: false

    property alias area: area

    Behavior on _borderColor {
        ColorAnimation {
            duration: _duration;
            easing.type: _easing
        }
    }

    ColumnLayout {
        spacing: 4
        anchors.fill: parent

        Text {
            id: label
            Layout.fillWidth: true
            Layout.leftMargin: 10
            Layout.rightMargin: 10
            text: root.labelText
            font: __app__.style.text.caption
            color: _textColor
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
                border.width: root.bordered ? _borderWidth : 0
                border.color: _borderColor
                radius: _radius
                color: _backgroundColor
            }

            Flickable {
                id: flickable
                anchors.fill: parent
                contentWidth: area.implicitWidth
                contentHeight: area.implicitHeight
                boundsBehavior: Flickable.StopAtBounds
                clip: true

                ScrollBar.vertical: ScrollBar { }
                ScrollBar.horizontal: ScrollBar { }

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

                    color: _textColor
                    selectionColor: __app__.style.palette.selection_background
                    selectedTextColor: __app__.style.palette.selection_text
                    font: _font
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

                    Text {
                        id: placeholder
                        x: area.leftPadding
                        y: area.topPadding
                        width: area.width - (area.leftPadding + area.rightPadding)
                        height: area.height - (area.topPadding + area.bottomPadding)

                        text: area.placeholderText
                        font: area.font
                        color: _textColor
                        opacity: 0.5
                        verticalAlignment: area.verticalAlignment
                        visible: !area.length && !area.preeditText && (!area.activeFocus || area.horizontalAlignment !== Qt.AlignHCenter)
                        elide: Text.ElideRight
                        renderType: area.renderType
                    }
                }
            }
        }

        RowLayout {
            Layout.fillWidth: true
            Layout.leftMargin: 10
            Layout.rightMargin: 10
            visible: root.helpText.length > 0 || root.showCharacterCount

            Text {
                id: helpText
                Layout.fillWidth: true
                text: root.helpText
                font: __app__.style.text.caption
                color: _textColor
                opacity: 0.5
                visible: root.helpText.length > 0
                elide: Text.ElideRight
            }

            Text {
                text: area.length
                Layout.fillWidth: !helpText.visible
                horizontalAlignment: Text.AlignRight
                font: __app__.style.text.caption
                color: _textColor
                opacity: 0.5
                visible: root.showCharacterCount
                elide: Text.ElideRight
            }
        }
    }
}
