#version 130
// From https://www.shadertoy.com/view/3dsGzs
// By fish

// property ShaderEffect iChannel3: ShaderEffect { source: "Shadertoy_SimpleBufferA.frag" }

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
	vec2 uv = fragCoord.xy / iResolution.xy;
    vec4 col = texture(iChannel3, uv);
    fragColor = vec4(col.rgb, 1.);
}
