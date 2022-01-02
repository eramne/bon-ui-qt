import QtQuick
import QtQuick.Templates as T
import QtQuick.Controls as C
import bon

Dropdown {
    id: root

    default property list<QtObject> actions
    property string title: ""
    property bool showDivider: false

    targetWidth: list.width
    targetHeight: list.height
    property real overlap: -10

    property alias list: list

    onOpened: {
        list.currentIndex = -1
        list.forceActiveFocus()
    }

    onActionsChanged: {
        list.model = _getModel()
    }

    function _collapseAncestors() {
        close()
        if (_parentMenu instanceof Menu) {
            _parentMenu._collapseAncestors();
        }
    }

    onClosed: {
        if (_activeSubMenu instanceof Menu) {
            _activeSubMenu.close()
        }
        list.model = _getModel()
        if (_parentMenu instanceof Menu) {
            _parentMenu.forceActiveFocus()
        }
    }

    Shortcut {
        id: tmpKeySequenceTextHelper
        enabled: false
    }

    property var _activeSubMenu
    property var _parentMenu

    function _getModel() {
        let tmpModel = []
        for (let i = 0; i < actions.length; i++) {
            if (actions[i] instanceof MenuItem) {
                let action = actions[i];
                let shortcutString = "";
                if (action.shortcut) {
                    tmpKeySequenceTextHelper.sequence = action.shortcut
                    shortcutString = tmpKeySequenceTextHelper.nativeText
                }

                tmpModel.push({
                                  name: action.text,
                                  action: action,
                                  enabled: action.enabled,
                                  leading: action.checkable && action.checked ?
                                               ListLeading.icon({name: "check"}) :
                                               ListLeading.icon({name: action.icon.name ? action.icon.name : "blank"}),
                                  trailing: shortcutString ? ListTrailing.caption({text: shortcutString}) : undefined,
                                  showDivider: action.showDivider ?? false
                              })
            } else if (actions[i] instanceof Menu) {
                let submenu = actions[i];
                tmpModel.push({
                                  name: submenu.title,
                                  submenu: submenu,
                                  enabled: submenu.enabled,
                                  leading: ListLeading.icon({name: "blank"}),
                                  trailing: ListTrailing.icon({name: "chevron_right"}),
                                  showDivider: submenu.showDivider ?? false
                              })
            }
        }
        return tmpModel
    }

    List {
        id: list
        width: Math.min(root.maxWidth, Math.max(200, _contentWidth + leftMargin + rightMargin))
        height: Math.min(root.maxHeight, contentHeight + bottomMargin + topMargin)
        leftMargin: 0
        rightMargin: 0

        Keys.onPressed: (event) => {
                            if (event.key === Qt.Key_Left) {
                                if (_parentMenu instanceof Menu) {
                                    root.close()
                                }
                            }
                            if (event.key === Qt.Key_Right) {
                                tryOpenSubmenu(highlightedIndex, true)
                            }
                        }

        property real _contentWidth: {
            displayMarginBeginning = 9999999
            displayMarginEnd = 9999999
            forceLayout()
            let tmpResult = 0;
            for (let i = 0; i < count; i++) {
                if (itemAtIndex(i)) {
                    let itemWidth = itemAtIndex(i)._itemImplicitWidth;
                    tmpResult = Math.max(tmpResult, itemWidth);
                }
            }
            displayMarginBeginning = 0
            displayMarginEnd = 0
            return tmpResult
        }

        onItemActivated: function (index, item) {
            if (model[index]?.action instanceof MenuItem) {
                model[index].action.trigger()
                root._collapseAncestors()
            }
        }

        onHoveredIndexChanged: {
            tryOpenSubmenu(hoveredIndex, false)
        }

        function tryOpenSubmenu(index, keyboard) {
            if (index !== -1) {
                root._activeSubMenu?.close();
                root._activeSubMenu = undefined;
            }
            if (model[index]?.submenu instanceof Menu) {
                root._activeSubMenu = model[index]?.submenu;
                root._activeSubMenu.parent = itemAtIndex(index)
                root._activeSubMenu._parentMenu = root
                root._activeSubMenu.autoAdjustPositionAroundTarget = false
                root._activeSubMenu.x = root.width - root.overlap
                root._activeSubMenu.y = -topMargin
                root._activeSubMenu.open()
                if (keyboard) {
                    root._activeSubMenu.list.currentIndex = root._activeSubMenu.list._firstVisibleIndex
                }
            }
        }

        compact: true
        model: root._getModel()
    }
}
