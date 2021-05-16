#version 130

#define pixel_fill $unit_width
#define unit_height $unit_height
#define pixel_empty $gap_width
#define gap_height $gap_height
#define decay $decay
#define blur_radius $blur_radius
#define move_step $move_step

#define from_color $from_color
#define to_color $to_color

vec4 bar(float x) {
    vec4 sample1= texture(iChannel1, vec2(x,0)) ;
    float max_=sample1.g*.5+sample1.r*.5;
    vec3 rgb=from_color.rgb+(to_color.rgb-from_color.rgb)*x; //vec3(1-0,0.5,0).rgb*x;
    return vec4(rgb,max_);
}

vec4 draw_bar(vec2 fragCoord) {
    ivec2 unit_size=ivec2(pixel_empty+pixel_fill,unit_height + gap_height );
    ivec2 id=ivec2(fragCoord / unit_size);
    vec2 _offset=fract(fragCoord/ unit_size);
    vec2 threshold=vec2(pixel_fill,unit_height ) /unit_size;
    if(_offset.x >= threshold.x)
        return vec4(0,0,0,0);
    if(_offset.y >= threshold.y)
        return vec4(0,0,0,0);

    vec2 id_res=(id*unit_size/iResolution.xy);
    vec4 b=bar(id_res.x);
    float max_=b.a;
    vec3 rgb=b.rgb;

    max_=floor(max_*iResolution.y/unit_size.y);

    if(id.y<max_)
        return vec4(rgb,1);//*max_,max_);

    return vec4(0,0,0,0);
}

void mainImage( out vec4 fragColor, in vec2 fragCoord ) {
    fragColor=draw_bar(fragCoord);
    if(fragColor.a<1)
        for(int i1=-blur_radius; i1<1+blur_radius; i1++)
            for(int i2=-blur_radius; i2<1+blur_radius; i2++)
                fragColor+=texelFetch(iChannel2,ivec2(fragCoord+vec2(i1-move_step,i2)), 0)/(1+2*blur_radius)/(1+2*blur_radius)*(1-decay);
//    fragColor.a=1;
}


