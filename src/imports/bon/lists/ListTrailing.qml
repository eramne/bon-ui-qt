pragma Singleton
import QtQuick

QtObject {
    enum Type {
        Caption,
        Icon
    }

    function caption({text}={}) {
        return {type: ListTrailing.Type.Caption, text: text}
    }

    function icon({name}={}) {
        return {type: ListTrailing.Type.Icon, name: name}
    }
}
