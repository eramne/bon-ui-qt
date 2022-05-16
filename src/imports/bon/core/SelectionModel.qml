import QtQuick
import bon as B

QtObject {
    id: root

    enum SelectionType {
        Clear, //clears the entire selection (e.g. clicking on the background to deselect everything)
        One, //clears selection and selects the specified index (e.g. clicking without modifiers)
        Range, //clears selection and selects everything from the current index until the specified index (e.g. shift clicking)
        AddRange, //adds everything from the current index until the specified index to the selection (e.g. shift+ctrl clicking)
        Toggle //toggles the selection at the current index (e.g. control-clicking)
    }

    property var selectedIndices: []
    property int currentIndex: -1

    function isSelected(index) {
        return selectedIndices.includes(index)
    }

    function select(index, mode = SelectionModel.SelectionType.One) {
        switch (mode) {
        case SelectionModel.SelectionType.Clear:
            selectedIndices = []
            currentIndex = -1
            break
        case SelectionModel.SelectionType.One:
            selectedIndices = [index]
            currentIndex = index
            break
        case SelectionModel.SelectionType.Range:
            if (currentIndex === -1) {
                selectedIndices = [index]
            } else {
                selectedIndices = []
                for (let i = Math.min(currentIndex, index); i <= Math.max(currentIndex, index); i++) {
                    selectedIndices.push(i)
                }
            }
            break
        case SelectionModel.SelectionType.AddRange:
            if (currentIndex === -1) {
                selectedIndices.push(index)
            } else {
                for (let j = Math.min(currentIndex, index); j <= Math.max(currentIndex, index); j++) {
                    selectedIndices.push(j)
                }
            }
            currentIndex = index
            break
        case SelectionModel.SelectionType.Toggle:
            if (root.isSelected(index)) {
                selectedIndices.splice(selectedIndices.indexOf(index),1)
            } else {
                selectedIndices.push(index)
            }

            currentIndex = index
        }
    }
}
