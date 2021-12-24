pragma Singleton
import QtQuick

QtObject {
    enum Type {
        Caption,
        Icon,
        Item
    }

    function caption({text}={}) {
        return {type: ListTrailing.Type.Caption, text: text}
    }

    function icon({name}={}) {
        return {type: ListTrailing.Type.Icon, name: name}
    }

    function item({component}={}) {
        return {type: ListTrailing.Type.Item, component: component}
    }
}
