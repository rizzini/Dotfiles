#version 130

#define pixel_fill $bar_width
#define pixel_empty $gap_width

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


void mainImage( out vec4 fragColor, in vec2 fragCoord ) {
    int pixel_x= int( fragCoord.x);
    int pixel_y= int( fragCoord.y);

    float h=fragCoord.y/iResolution.y;

    float unit_size=pixel_empty+pixel_fill;

    fragColor=vec4(0,0,0,0);
    if(pixel_x%(pixel_fill+pixel_empty)<pixel_fill) {
        float id=floor(fragCoord.x / unit_size);
        vec3 rgb=getRGB(id*unit_size/iResolution.x);
        vec4 sample1=mean(id*unit_size/iResolution.x,(1.0+id)*unit_size/iResolution.x);
        float max_=sample1.g*.5+sample1.r*.5;
        if(h<=max_)
            fragColor=vec4(rgb*1.,1.);

    }
}
