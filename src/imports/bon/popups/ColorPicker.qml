import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as C
import Qt5Compat.GraphicalEffects
import bon as Bon

Bon.Dropdown {
    id: root

    width: 275
    height: contentItem.implicitHeight

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

    contentItem: C.Pane {
        width: parent.width
        padding: 20
        background: Rectangle {color: "transparent"}

        ColumnLayout {
            spacing: 10
            width: parent.width

            RowLayout {
                Layout.fillWidth: true
                spacing: 10

                Text {
                    Layout.fillWidth: true
                    text: "Adjust Color"
                    color: __app__.style.palette.text.heading
                    font: __app__.style.text.heading
                }

                Bon.Button {
                    Layout.preferredWidth: 40
                    Layout.preferredHeight: 40
                    order: 3
                    icon.name: "close"
                    onClicked: {
                        root.canceled();
                    }
                }

                Bon.Button {
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

            Bon.ColorArea {
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

            Bon.ColorSlider {
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

            Bon.ColorSlider {
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

            Bon.ComboBox {
                id: textInputTypeBox
                width: 100
                editable: false
                currentIndex: 2

                model: ListModel {
                    ListElement { name: "RGBA"; }
                    ListElement { name: "HSVA"; }
                    ListElement { name: "HEX"; }
                }
            }

            StackLayout {
                Layout.fillWidth: true
                currentIndex: textInputTypeBox.currentIndex

                //RGBA
                RowLayout {
                    Layout.fillWidth: true
                    spacing: 10
                    Bon.NumberField {
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
                    Bon.NumberField {
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
                    Bon.NumberField {
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
                    Bon.NumberField {
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
                    Bon.NumberField {
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
                    Bon.NumberField {
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
                    Bon.NumberField {
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
                    Bon.NumberField {
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
                Bon.TextField {
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
