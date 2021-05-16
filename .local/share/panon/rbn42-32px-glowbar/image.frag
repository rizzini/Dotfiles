#version 130

#define pixel_fill $bar_width
#define pixel_empty $gap_width

#define background_color_and_opacity $background_color_and_opacity
#define glow_radius      $glow_radius
#define glow_strength    $glow_strength
#define glow_strength2   $glow_strength2
#define bar_strength     $bar_strength
#define height_ratio     $height_ratio

vec4 mean(float _from,float _to) {

    if(_from>1.0)
        return vec4(0);

    _from=iChannelResolution[1].x*_from;
    _to=iChannelResolution[1].x*_to;

    vec4 v=texelFetch(iChannel1, ivec2(_from,0),0) * (1.0-fract(_from)) ;

    for(float i=ceil(_from); i<floor(_to); i++)
        v+=texelFetch(iChannel1, ivec2(i,0),0) ;

    if(floor(_to)>floor(_from))
        v+=texelFetch(iChannel1,ivec2(_to,0),0)* fract(_to);
    else
        v-=texelFetch(iChannel1,ivec2(_to,0),0)*(1.0- fract(_to));

    return v/(_to-_from);
}


vec4 bar(float id) {
    float unit_size=pixel_empty+pixel_fill;
    vec4 sample1=mean(id*unit_size/iResolution.x,(1.0+id)*unit_size/iResolution.x);
    float max_=sample1.g*.5+sample1.r*.5;
    float x=(id*unit_size/iResolution.x);
    vec3 rgb=getRGB(x);
    return vec4(rgb,max_);
}

vec4 draw_bar(vec2 fragCoord) {
    float unit_size=pixel_empty+pixel_fill;
    float id=floor(fragCoord.x / unit_size);
    float _offset=fract(fragCoord.x / unit_size);
    float threshold=pixel_fill/unit_size;
    if(_offset >= threshold)
        return vec4(0,0,0,0);
    float h=fragCoord.y/iResolution.y;
    vec4 b=bar(id);
    float max_=b.a;
    if(h>max_*height_ratio)
        return vec4(0,0,0,0);
    vec3 rgb=b.rgb;
    return vec4(rgb*max_,max_);
}

float bar_dist(float id,vec2 fragCoord) {
    float unit_size=pixel_empty+pixel_fill;
    vec4 b=bar(id);
    float max_=b.a;
    float h=fragCoord.y/iResolution.y;
    if(h<=max_*height_ratio) {
        if(fragCoord.x< id*unit_size)
            return id*unit_size-fragCoord.x;
        if(fragCoord.x< id*unit_size+pixel_fill )
            return 100000.0;
        else
            return fragCoord.x -id*unit_size-pixel_fill;
    } else {
        if(fragCoord.x< id*unit_size)
            return length(fragCoord- vec2(id*unit_size,max_*iResolution.y*height_ratio));
        if(fragCoord.x< id*unit_size+pixel_fill )
            return fragCoord.y-max_*iResolution.y*height_ratio;
        else
            return length(fragCoord- vec2(id*unit_size+pixel_fill,max_*iResolution.y*height_ratio));
    }

}

vec4 draw_glow(vec2 fragCoord) {
    float unit_size=pixel_empty+pixel_fill;
    float id=floor(fragCoord.x / unit_size);
    vec4 out_=vec4(0,0,0,0);
    for(int id_=-glow_radius; id_<1+glow_radius; id_++) {
        vec4 b=bar(id+id_);
        b.a/= pow(bar_dist(id+id_,fragCoord),glow_strength2 ) ;
        out_+=vec4(b.rgb*b.a,b.a);
    }
    return out_;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord ) {
    fragColor=draw_bar(fragCoord)*bar_strength+draw_glow(fragCoord)*glow_strength;

    fragColor.a=0.0;

    fragColor.rgb+=background_color_and_opacity.rgb*background_color_and_opacity.a;
    fragColor.a+=background_color_and_opacity.a;
}
