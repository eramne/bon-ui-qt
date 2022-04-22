import QtQuick
import bon as B

Item {
    id: root
    width: 400
    height: layout.implicitHeight

    property var model: []
    property var selection: []

    Rectangle {
        anchors.fill: parent
        color: "transparent"
        border.width: 2
        border.color: B.Theme.palette.background_1
        radius: 8
    }

    Column {
        id: layout
        width: root.width
        height: childrenRect.implicitHeight
        spacing: 10
        padding: 10

        B.ComboBox {
            id: combobox
            model: root.model
            width: parent.width - parent.padding*2

            field.onEditingFinished: {
                let index = root.selection.findIndex((element) => { return element.name === value });
                if (index < 0) {
                    selection.push(root.model[selectedIndex]);
                    chipset.chips.push(chipComponent.createObject(chipset._layout, {text: value}));
                }
            }
        }

        B.ChipSet {
            id: chipset
            variant: B.Chip.Type.Input
            width: parent.width - parent.padding*2
            overflow: false
        }

        Component {
            id: chipComponent

            Chip {
                variant: B.Chip.Type.Input

                onClosed: {
                    let indexToRemove = root.selection.findIndex((element) => { return element.name === text });
                    if (indexToRemove > -1) {
                        root.selection.splice(indexToRemove, 1);
                    }
                }
            }
        }
    }
}
