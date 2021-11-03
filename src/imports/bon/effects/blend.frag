#version 440

layout(location = 0) in vec2 qt_TexCoord0;
layout(location = 0) out vec4 fragColor;

layout(std140, binding = 0) uniform buf {
    // qt_Matrix and qt_Opacity must always be both present
    // if the built-in vertex shader is used.
    mat4 qt_Matrix;
    float qt_Opacity;
    vec4 background;
    vec4 objectDimensions;
    vec2 viewportDimensions;
} ubuf;

layout(binding=1) uniform sampler2D source;
layout(binding=2) uniform sampler2D foregroundSource;

float linearstep(float e0, float e1, float x)
{
    return clamp((x - e0) / (e1 - e0), 0.0, 1.0);
}

void main()
{
    float ox = ubuf.objectDimensions.x; //dimensions of the object
    float oy = ubuf.objectDimensions.y;
    float ow = ubuf.objectDimensions.z;
    float oh = ubuf.objectDimensions.w;
    float vw = ubuf.viewportDimensions.x; //dimensions of the window (x and y = 0)
    float vh = ubuf.viewportDimensions.y;

    vec2 viewportCoords = vec2(qt_TexCoord0.x*(ow/vw)+(ox)/vw, qt_TexCoord0.y*(oh/vh)+(oy)/vh);
    //vec2 viewportCoords = vec2(qt_TexCoord0.x, qt_TexCoord0.y);
    vec4 backgroundColor = texture(source, viewportCoords);
    if (backgroundColor.a + backgroundColor.r + backgroundColor.g + backgroundColor.b == 0.0) {
        backgroundColor = ubuf.background;
    }
    backgroundColor.a = 1;

    vec4 foregroundColor = texture(foregroundSource, qt_TexCoord0);
    fragColor.r = backgroundColor.r * foregroundColor.r;
    fragColor.g = backgroundColor.g * foregroundColor.g;
    fragColor.b = backgroundColor.b * foregroundColor.b;
    fragColor.a = backgroundColor.a * foregroundColor.a;
}
