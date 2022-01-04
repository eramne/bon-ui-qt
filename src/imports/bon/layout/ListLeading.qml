pragma Singleton
import QtQuick

QtObject {
    enum Type {
        Icon,
        Avatar,
        Thumbnail
    }

    function icon({name}={}) {
        return {type: ListLeading.Type.Icon, name: name}
    }

    function avatar({source}={}) {
        return {type: ListLeading.Type.Avatar, source: source}
    }

    function thumbnail({source}={}) {
        return {type: ListLeading.Type.Thumbnail, source: source}
    }
}
