#version 130

#define strength $strength
#define background_opacity $background_opacity 

void mainImage( out vec4 fragColor, in vec2 fragCoord ) {
    float x=fragCoord.x/iResolution.x;
    vec4 sample1= texture(iChannel1, vec2(x,0)) ;

    fragColor.a=(sample1.r+sample1.g)/2.*strength;
    fragColor.rgb=getRGB(x)*fragColor.a;
    fragColor.a+=background_opacity;
}
