import QtQuick
import QtQuick.Templates as T
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import bon as B

Item {
    id: root
    width: 220
    height: rowLayout.implicitHeight

    opacity: !root.enabled ? B.Theme.disabled_opacity : 1
    layer.enabled: !root.enabled

    property color _backgroundColor: field.focus ? B.Theme.palette.background_2 : (
                                         field.hovered ? B.Theme.palette.background_1 : (
                                             (showStatus && !field.acceptableInput) ? B.Theme.palette.error : B.Theme.palette.background
                                         )
                                     )
    property real _fadeLength: 40

    property string leadingIcon: ""
    property string prefixText: ""
    property string suffixText: ""
    property string helpText: ""
    property string labelText: ""
    property string successText: ""
    property string errorText: "Error"
    property bool showCharacterCount: false
    property bool showStatus: false

    property Component _trailingIcons: Component {
        QtObject{}
    }

    signal iconClicked();

    Behavior on _backgroundColor {
        ColorAnimation {
            duration: B.Theme.animations.basic.duration
            easing.type: B.Theme.animations.basic.type
        }
    }

    property alias field: field

    RowLayout {
        id: rowLayout
        anchors.fill: root
        spacing: 8

        B.Icon {
            name: leadingIcon
            visible: isValid
            Layout.alignment: Qt.AlignVCenter
        }

        ColumnLayout {
            spacing: 4
            Layout.fillWidth: true

            B.CaptionText {
                id: label
                Layout.fillWidth: true
                Layout.leftMargin: 10
                Layout.rightMargin: 10
                text: root.labelText
                opacity: 0.5
                verticalAlignment: field.verticalAlignment
                visible: root.labelText.length > 0
            }

            Item {
                height: 40
                Layout.fillWidth: true

                Item {
                    id: background
                    anchors.fill: parent

                    Item {
                        anchors.fill: parent
                        opacity: field.focus || field.hovered ? 0.3 : (showStatus && !field.acceptableInput ? 0.3 : 0)
                        layer.enabled: true

                        Behavior on opacity {
                            NumberAnimation {
                                duration: B.Theme.animations.basic.duration
                                easing.type: B.Theme.animations.basic.type
                            }
                        }

                        Rectangle {
                            anchors.fill: parent
                            color: _backgroundColor
                            radius: 4
                        }

                        Rectangle {
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.bottom: parent.bottom
                            height: parent.height/2
                            color: _backgroundColor
                        }
                    }

                    Rectangle {
                        anchors.bottom: parent.bottom
                        anchors.right: parent.right
                        anchors.left: parent.left
                        height: 2
                        color: field.focus ? B.Theme.palette.background_2 : showStatus ? (
                                   field.acceptableInput ? B.Theme.palette.success : B.Theme.palette.error
                               ) : B.Theme.palette.background_1
                        Behavior on color {
                            ColorAnimation {
                                duration: B.Theme.animations.basic.duration
                                easing.type: B.Theme.animations.basic.type
                            }
                        }
                    }
                }

                RowLayout {
                    anchors.fill: parent
                    anchors.leftMargin: 10
                    anchors.rightMargin: 10
                    spacing: 4

                    B.LabelText {
                        text: root.prefixText
                        opacity: 0.5
                        verticalAlignment: field.verticalAlignment
                        visible: prefixText.length > 0
                    }

                    Item {
                        Layout.fillHeight: true
                        Layout.fillWidth: true

                        B.LabelText {
                            id: placeholder
                            x: field.leftPadding
                            y: field.topPadding
                            width: field.width - (field.leftPadding + field.rightPadding)
                            height: field.height - (field.topPadding + field.bottomPadding)
                            text: field.placeholderText
                            opacity: 0.5
                            verticalAlignment: field.verticalAlignment
                            visible: !field.length && !field.preeditText && (!field.activeFocus || field.horizontalAlignment !== Qt.AlignHCenter)
                        }

                        Item {
                            anchors.fill: parent

                            T.TextField {
                                id: field

                                implicitWidth: implicitBackgroundWidth + leftInset + rightInset
                                               || Math.max(contentWidth, placeholder.implicitWidth) + leftPadding + rightPadding
                                implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                                                         contentHeight + topPadding + bottomPadding,
                                                         placeholder.implicitHeight + topPadding + bottomPadding)

                                anchors.fill: parent
                                color: B.Theme.palette.text.label
                                font: B.Theme.text.label
                                selectionColor: B.Theme.palette.selection_background
                                selectedTextColor: B.Theme.palette.selection_text
                                placeholderTextColor: "transparent"
                                verticalAlignment: TextInput.AlignVCenter
                                selectByMouse: true
                                enabled: root.enabled
                                hoverEnabled: root.enabled

                                Component.onCompleted: {
                                    select(0,0);
                                }
                            }

                            B.OverflowFadeEffect {
                                target: field
                                anchors.fill: field
                                fadeLength: 40
                                startContainerPos: field.x
                                endContainerPos: field.x + field.width
                                startContentPos: field.positionToRectangle(0).x
                                endContentPos: field.positionToRectangle(field.length).x
                                orientation: Qt.Horizontal

                                function updateDimensions2() {
                                    startContentPos = field.positionToRectangle(0).x
                                    endContentPos = field.positionToRectangle(field.length).x
                                    updateDimensions();
                                }

                                Component.onCompleted: {
                                    field.textChanged.connect(updateDimensions2);
                                    field.cursorPositionChanged.connect(updateDimensions2);
                                    field.widthChanged.connect(updateDimensions2);
                                }
                            }
                        }
                    }

                    B.LabelText {
                        text: root.suffixText
                        opacity: 0.5
                        verticalAlignment: field.verticalAlignment
                        visible: suffixText.length > 0
                    }

                    Loader {
                        sourceComponent: root._trailingIcons
                    }
                }
            }

            RowLayout {
                Layout.fillWidth: true
                Layout.leftMargin: 10
                Layout.rightMargin: 10

                B.CaptionText {
                    id: helpText
                    Layout.fillWidth: true
                    text: !(root.showStatus && !field.focus) ? root.helpText : (field.acceptableInput ? root.successText : root.errorText)
                    color: !(root.showStatus && !field.focus) ? B.Theme.palette.text.label : (field.acceptableInput ? B.Theme.palette.success : B.Theme.palette.error)
                    opacity: !(root.showStatus && !field.focus) ? 0.5 : 1
                    verticalAlignment: field.verticalAlignment
                    visible: root.helpText.length > 0 || ((root.showStatus && !field.focus) && !field.acceptableInput && root.errorText.length > 0) || ((root.showStatus && !field.focus) && field.acceptableInput && root.successText.length > 0)
                }

                B.CaptionText {
                    text: field.maximumLength < 32767 ? `${field.length}/${field.maximumLength}` : field.length
                    Layout.fillWidth: !helpText.visible
                    horizontalAlignment: Text.AlignRight
                    opacity: 0.5
                    verticalAlignment: field.verticalAlignment
                    visible: root.showCharacterCount
                }
            }
        }
    }
}
