import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as C
import Qt5Compat.GraphicalEffects
import bon as B

B.Dropdown {
    id: root

    targetWidth: 275
    targetHeight: popupContentLayout.height + overflowArea.topMargin + overflowArea.bottomMargin

    property color color: "red"
    property color editColor: color

    signal finished
    signal canceled

    Component.onCompleted: {
        editColor = color;
        root.closed.connect(finished);
    }

    onFinished: {
        color = editColor;
    }
    onCanceled: {
        editColor = color;
        root.close();
    }

    contentItem: B.OverflowArea {
        id: overflowArea
        anchors.fill: parent
        contentWidth: popupContentLayout.width

        margins: 20

        ColumnLayout {
            id: popupContentLayout
            spacing: 10
            width: root.availableWidth - overflowArea.leftMargin - overflowArea.rightMargin

            RowLayout {
                Layout.fillWidth: true
                spacing: 10

                B.HeadingText {
                    Layout.fillWidth: true
                    text: "Adjust Color"
                }

                B.Button {
                    Layout.preferredWidth: 40
                    Layout.preferredHeight: 40
                    order: 3
                    icon.name: "close"
                    onClicked: {
                        root.canceled();
                    }
                }

                B.Button {
                    Layout.preferredWidth: 40
                    Layout.preferredHeight: 40
                    order: 2
                    icon.name: "done"

                    onClicked: {
                        root.close();
                    }
                }
            }

            RowLayout {
                Layout.fillWidth: true
                spacing: 10

                Rectangle {
                    Layout.fillWidth: true
                    height: 20
                    radius: 10
                    color: "white"

                    Image {
                        anchors.fill: parent
                        id: checkerboardImage
                        fillMode: Image.Tile

                        source: "../assets/checkerboard.svg"
                        visible: false
                    }

                    Rectangle {
                        id: maskRect
                        anchors.fill: parent
                        color: "black"
                        radius: parent.radius
                    }

                    ShaderEffectSource {
                        id: maskRectSource
                        anchors.fill: maskRect
                        sourceItem: maskRect
                        hideSource: true
                        visible: false
                    }

                    OpacityMask {
                        anchors.fill: checkerboardImage
                        source: checkerboardImage
                        maskSource: maskRectSource
                        opacity: 0.125
                    }

                    Rectangle {
                        anchors.fill: parent
                        color: root.color
                        radius: parent.radius
                    }
                }

                Rectangle {
                    Layout.fillWidth: true
                    height: 20
                    radius: 10
                    color: "white"

                    Image {
                        anchors.fill: parent
                        id: checkerboardImage2
                        fillMode: Image.Tile

                        source: "../assets/checkerboard.svg"
                        visible: false
                    }

                    Rectangle {
                        id: maskRect2
                        anchors.fill: parent
                        color: "black"
                        radius: parent.radius
                    }

                    ShaderEffectSource {
                        id: maskRectSource2
                        anchors.fill: maskRect2
                        sourceItem: maskRect2
                        hideSource: true
                        visible: false
                    }

                    OpacityMask {
                        anchors.fill: checkerboardImage2
                        source: checkerboardImage2
                        maskSource: maskRectSource2
                        opacity: 0.125
                    }

                    Rectangle {
                        anchors.fill: parent
                        color: root.editColor
                        radius: parent.radius
                    }
                }
            }

            B.ColorArea {
                Layout.fillWidth: true
                id: colorArea
                hue: root.editColor.hsvHue;
                onSaturationChanged: {
                    root.editColor.hsvSaturation = saturation;
                }
                onValueChanged: {
                    root.editColor.hsvValue = value;
                }
                Component.onCompleted: {
                    function update() {
                        saturation = root.editColor.hsvSaturation;
                        value = root.editColor.hsvValue;
                    }
                    root.onEditColorChanged.connect(update);
                    update();
                }
            }

            B.ColorSlider {
                id: hueSlider
                Layout.fillWidth: true
                color: Qt.hsva(root.editColor.hsvHue, 1, 1, 1)
                gradient: Gradient {
                    orientation: Gradient.Horizontal

                    GradientStop { position: 0; color: Qt.hsva(0,1,1,1) }
                    GradientStop { position: 1/6; color: Qt.hsva(1/6,1,1,1) }
                    GradientStop { position: 2/6; color: Qt.hsva(2/6,1,1,1) }
                    GradientStop { position: 3/6; color: Qt.hsva(3/6,1,1,1) }
                    GradientStop { position: 4/6; color: Qt.hsva(4/6,1,1,1) }
                    GradientStop { position: 5/6; color: Qt.hsva(5/6,1,1,1) }
                    GradientStop { position: 1; color: Qt.hsva(1,1,1,1) }
                }
                Component.onCompleted: {
                    root.onEditColorChanged.connect(function () {
                        value = root.editColor.hsvHue;
                    });
                }
                onPositionChanged: {
                    root.editColor.hsvHue = position
                }
            }

            B.ColorSlider {
                id: alphaSlider
                value: 1
                Layout.fillWidth: true
                color: root.editColor
                gradient: Gradient {
                    orientation: Gradient.Horizontal

                    GradientStop { position: 0; color: "transparent" }
                    GradientStop { position: 1; color: Qt.alpha(root.editColor,1) }
                }
                onPositionChanged: {
                    root.editColor.a = position
                }
                Component.onCompleted: {
                    root.onEditColorChanged.connect(function () {
                        value = root.editColor.a;
                    });
                }
            }



            //Number/Hex inputs

            B.ComboBox {
                id: textInputTypeBox
                width: 100
                editable: false
                selectedIndex: 2

                model: [
                    { name: "RGBA" },
                    { name: "HSVA" },
                    { name: "HEX" }
                ]
            }

            StackLayout {
                Layout.fillWidth: true
                currentIndex: textInputTypeBox.selectedIndex

                //RGBA
                RowLayout {
                    Layout.fillWidth: true
                    spacing: 10
                    B.NumberField {
                        Layout.fillWidth: true
                        from: 0
                        to: 255
                        field.onAccepted: {
                            root.editColor.r = value/255
                        }
                        Component.onCompleted: {
                            function updateVal() {
                                value = Math.floor(root.editColor.r*255);
                            }
                            root.onEditColorChanged.connect(updateVal);
                            updateVal();
                        }
                    }
                    B.NumberField {
                        Layout.fillWidth: true
                        from: 0
                        to: 255
                        field.onAccepted: {
                            root.editColor.g = value/255
                        }
                        Component.onCompleted: {
                            function updateVal() {
                                value = Math.floor(root.editColor.g*255);
                            }
                            root.onEditColorChanged.connect(updateVal);
                            updateVal();
                        }
                    }
                    B.NumberField {
                        Layout.fillWidth: true
                        from: 0
                        to: 255
                        field.onAccepted: {
                            root.editColor.b = value/255
                        }
                        Component.onCompleted: {
                            function updateVal() {
                                value = Math.floor(root.editColor.b*255);
                            }
                            root.onEditColorChanged.connect(updateVal);
                            updateVal();
                        }
                    }
                    B.NumberField {
                        Layout.fillWidth: true
                        from: 0
                        to: 100
                        field.onAccepted: {
                            root.editColor.a = value/100
                        }
                        Component.onCompleted: {
                            function updateVal() {
                                value = Math.floor(root.editColor.a*100);
                            }
                            root.onEditColorChanged.connect(updateVal);
                            updateVal();
                        }
                    }
                }


                //HSVA
                RowLayout {
                    Layout.fillWidth: true
                    spacing: 10
                    B.NumberField {
                        Layout.fillWidth: true
                        from: 0
                        to: 360
                        field.onAccepted: {
                            root.editColor.hsvHue = value/360
                        }
                        Component.onCompleted: {
                            function updateVal() {
                                value = Math.floor(root.editColor.hsvHue*360);
                            }
                            root.onEditColorChanged.connect(updateVal);
                            updateVal();
                        }
                    }
                    B.NumberField {
                        Layout.fillWidth: true
                        from: 0
                        to: 100
                        field.onAccepted: {
                            root.editColor.hsvSaturation = value/100
                        }
                        Component.onCompleted: {
                            function updateVal() {
                                value = Math.floor(root.editColor.hsvSaturation*100);
                            }
                            root.onEditColorChanged.connect(updateVal);
                            updateVal();
                        }
                    }
                    B.NumberField {
                        Layout.fillWidth: true
                        from: 0
                        to: 100
                        field.onAccepted: {
                            root.editColor.hsvValue = value/100
                        }
                        Component.onCompleted: {
                            function updateVal() {
                                value = Math.floor(root.editColor.hsvValue*100);
                            }
                            root.onEditColorChanged.connect(updateVal);
                            updateVal();
                        }
                    }
                    B.NumberField {
                        Layout.fillWidth: true
                        from: 0
                        to: 100
                        field.onAccepted: {
                            root.editColor.a = value/100
                        }
                        Component.onCompleted: {
                            function updateVal() {
                                value = Math.floor(root.editColor.a*100);
                            }
                            root.onEditColorChanged.connect(updateVal);
                            updateVal();
                        }
                    }
                }


                //HEX
                B.TextField {
                    Layout.fillWidth: true
                    field.onAccepted: {
                        root.editColor = field.text;
                        field.text = root.editColor;
                    }
                    Component.onCompleted: {
                        function updateVal() {
                            field.text = root.editColor;
                        }
                        root.onEditColorChanged.connect(updateVal);
                        updateVal();
                    }

                    Timer {
                        interval: 1
                        running: true
                        repeat: false
                        onTriggered: {
                            parent.field.clear();
                            parent.field.insert(0,root.editColor);
                        }
                    }
                }
            }
        }
    }
}
