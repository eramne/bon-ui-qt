import QtQuick 2.0

Item {
    id: blend
    property variant source
    anchors.fill: source

    ShaderEffectSource {
        id: windowSource
        sourceItem: __window__
        anchors.fill: parent
        visible: false
        hideSource: false
        recursive: false
    }

    ShaderEffect {
        id: blendShaderEffect
        property variant source: windowSource
        property variant foregroundSource: blendEffectSource
        anchors.fill: blend
        property color background: __window__.color;
        property vector4d objectDimensions: Qt.vector4d(blend.parent.mapToItem(__window__,blend.x,blend.y).x, blend.parent.mapToItem(__window__,blend.x,blend.y).y, width, height);
        property vector2d viewportDimensions: Qt.vector2d(__window__.width, __window__.height);
        visible: false;

        fragmentShader: '../effects/blend.frag.qsb'
    }

    ShaderEffectSource {
        id: blendEffectSource
        sourceItem: blend.source
        anchors.fill: blend
        visible: false
        hideSource: true
    }

    ShaderEffectSource {
        sourceItem: blendShaderEffect
        anchors.fill: blend
        visible: true
        hideSource: true
    }
}
