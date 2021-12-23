pragma Singleton
import QtQuick

QtObject {
    enum Type {
        Icon
    }

    function icon({name}={}) {
        return {type: ListLeading.Type.Icon, name: name}
    }
}
