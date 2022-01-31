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
        anchors.fill: parent
        spacing: 8

        B.Icon {
            name: leadingIcon
            visible: isValid
            color: B.Theme.palette.text.label
            Layout.alignment: Qt.AlignVCenter
        }

        ColumnLayout {
            spacing: 4
            Layout.fillWidth: true

            Text {
                id: label
                Layout.fillWidth: true
                Layout.leftMargin: 10
                Layout.rightMargin: 10
                text: root.labelText
                font: B.Theme.text.caption
                color: B.Theme.palette.text.label
                opacity: 0.5
                verticalAlignment: field.verticalAlignment
                visible: root.labelText.length > 0
                elide: Text.ElideRight
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

                    Text {
                        text: root.prefixText
                        font: field.font
                        color: B.Theme.palette.text.label
                        opacity: 0.5
                        verticalAlignment: field.verticalAlignment
                        visible: prefixText.length > 0
                        elide: Text.ElideRight
                        renderType: field.renderType
                    }

                    Item {
                        Layout.fillHeight: true
                        Layout.fillWidth: true

                        Text {
                            id: placeholder
                            x: field.leftPadding
                            y: field.topPadding
                            width: field.width - (field.leftPadding + field.rightPadding)
                            height: field.height - (field.topPadding + field.bottomPadding)

                            text: field.placeholderText
                            font: field.font
                            color: B.Theme.palette.text.label
                            opacity: 0.5
                            verticalAlignment: field.verticalAlignment
                            visible: !field.length && !field.preeditText && (!field.activeFocus || field.horizontalAlignment !== Qt.AlignHCenter)
                            elide: Text.ElideRight
                            renderType: field.renderType
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
                                selectionColor: B.Theme.palette.selection_background
                                selectedTextColor: B.Theme.palette.selection_text
                                placeholderTextColor: "transparent"
                                verticalAlignment: TextInput.AlignVCenter
                                font: B.Theme.text.label
                                selectByMouse: true
                                enabled: root.enabled
                                hoverEnabled: root.enabled
                            }

                            Item {
                                id: fadeEffect
                                anchors.fill: root.field

                                ShaderEffectSource {
                                    id: fieldSource
                                    anchors.fill: parent
                                    sourceItem: root.field
                                    hideSource: true
                                    visible: false
                                }

                                Item {
                                    id: gradientMask
                                    anchors.fill: parent

                                    Item {
                                        anchors.top: parent.top
                                        anchors.bottom: parent.bottom

                                        LinearGradient {
                                            anchors.top: parent.top
                                            anchors.bottom: parent.bottom
                                            x: parent.width/2
                                            width: parent.width/2
                                            start: Qt.point(width-_fadeLength, 0)
                                            end: Qt.point(width, 0)
                                            gradient: Gradient {
                                                GradientStop { position: 0.0; color: "#FF000000" }
                                                GradientStop { position: 1.0; color: "#00000000" }
                                            }
                                        }
                                        LinearGradient {
                                            anchors.top: parent.top
                                            anchors.bottom: parent.bottom
                                            x: 0
                                            width: parent.width/2
                                            start: Qt.point(0, 0)
                                            end: Qt.point(_fadeLength, 0)
                                            gradient: Gradient {
                                                GradientStop { position: 0.0; color: "#00000000" }
                                                GradientStop { position: 1.0; color: "#FF000000" }
                                            }
                                        }
                                        Component.onCompleted: {
                                            field.textChanged.connect(updateDimensions);
                                            field.cursorPositionChanged.connect(updateDimensions);
                                            field.widthChanged.connect(updateDimensions);
                                        }

                                        function updateDimensions() { //i will definitely forget how this works, modelled it in a graph on desmos somewhere
                                            var textBeginPos = field.positionToRectangle(0).x
                                            var textEndPos = field.positionToRectangle(field.length).x
                                            x = Math.min(-textBeginPos-40,0)
                                            var endX = Math.max((2*field.width)-textEndPos+_fadeLength,field.width)
                                            width = endX - x
                                        }
                                    }
                                }

                                ShaderEffectSource {
                                    id: gradientSource
                                    anchors.fill: gradientMask
                                    sourceItem: gradientMask
                                    hideSource: true
                                    visible: false
                                }

                                OpacityMask {
                                    anchors.fill: fieldSource
                                    source: fieldSource
                                    maskSource: gradientSource
                                    visible: true
                                }
                            }
                        }
                    }

                    Text {
                        text: root.suffixText
                        font: field.font
                        color: B.Theme.palette.text.label
                        opacity: 0.5
                        verticalAlignment: field.verticalAlignment
                        visible: suffixText.length > 0
                        elide: Text.ElideRight
                        renderType: field.renderType
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

                Text {
                    id: helpText
                    Layout.fillWidth: true
                    text: !(root.showStatus && !field.focus) ? root.helpText : (field.acceptableInput ? root.successText : root.errorText)
                    font: B.Theme.text.caption
                    color: !(root.showStatus && !field.focus) ? B.Theme.palette.text.label : (field.acceptableInput ? B.Theme.palette.success : B.Theme.palette.error)
                    opacity: !(root.showStatus && !field.focus) ? 0.5 : 1
                    verticalAlignment: field.verticalAlignment
                    visible: root.helpText.length > 0 || ((root.showStatus && !field.focus) && !field.acceptableInput && root.errorText.length > 0) || ((root.showStatus && !field.focus) && field.acceptableInput && root.successText.length > 0)
                    elide: Text.ElideRight
                }

                Text {
                    text: field.maximumLength < 32767 ? `${field.length}/${field.maximumLength}` : field.length
                    Layout.fillWidth: !helpText.visible
                    horizontalAlignment: Text.AlignRight
                    font: B.Theme.text.caption
                    color: B.Theme.palette.text.label
                    opacity: 0.5
                    verticalAlignment: field.verticalAlignment
                    visible: root.showCharacterCount
                    elide: Text.ElideRight
                }
            }
        }
    }
}