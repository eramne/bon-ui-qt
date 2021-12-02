import QtQuick
import QtQuick.Window

Item {
    id: root
    property variant source
    anchors.fill: source

    ShaderEffectSource {
        id: windowSource
        sourceItem: Window.window
        anchors.fill: parent
        visible: false
        hideSource: false
        recursive: false
    }

    ShaderEffect {
        id: blendShaderEffect
        property variant source: windowSource
        property variant foregroundSource: blendEffectSource
        anchors.fill: root
        property color background: Window.window.color;
        property vector4d objectDimensions: Qt.vector4d(root.parent.mapToItem(__window__,root.x,root.y).x, root.parent.mapToItem(__window__,root.x,root.y).y, width, height);
        property vector2d viewportDimensions: Qt.vector2d(__window__.width, __window__.height);
        visible: false;

        fragmentShader: '../effects/blend.frag.qsb'
    }

    ShaderEffectSource {
        id: blendEffectSource
        sourceItem: root.source
        anchors.fill: root
        visible: false
        hideSource: true
    }

    ShaderEffectSource {
        sourceItem: blendShaderEffect
        anchors.fill: root
        visible: true
        hideSource: true
    }
}
