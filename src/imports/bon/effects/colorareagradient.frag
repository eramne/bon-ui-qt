#version 440

layout(location = 0) in vec2 qt_TexCoord0;
layout(location = 0) out vec4 fragColor;

layout(std140, binding = 0) uniform buf {
    // qt_Matrix and qt_Opacity must always be both present
    // if the built-in vertex shader is used.
    mat4 qt_Matrix;
    float qt_Opacity;
    float hue;
} ubuf;

layout(binding=1) uniform sampler2D source;

vec3 hsv2rgb(vec3 c)
{
    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
    return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}

void main()
{
    vec4 tex = texture(source, qt_TexCoord0);
    vec3 hsv = hsv2rgb(vec3(ubuf.hue,qt_TexCoord0.x,1-qt_TexCoord0.y));
    fragColor = vec4(hsv.r, hsv.g, hsv.b, tex.a)*ubuf.qt_Opacity;
}
