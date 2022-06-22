import QtQuick
import bon as B

QtObject {
    id: root

    enum SelectionType {
        Clear,
        One,
        Range,
        AddRange,
        Toggle
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
