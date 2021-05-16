#version 130

#define pixel_fill $bar_width
#define pixel_empty $gap_width
#define mirror true

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

vec4 drawbar(ivec2 pos,bool left_side){

    float unit_size=pixel_empty+pixel_fill;
    bool draw;

    draw=(pos.x%(pixel_fill+pixel_empty)<pixel_fill);

    if(draw) {
        float id=floor(pos.x / unit_size);
        vec3 rgb=getRGB(id*unit_size/iResolution.x);
        vec4 sample1=mean(id*unit_size/iResolution.x,(1.0+id)*unit_size/iResolution.x);

        float max_=mirror?(left_side?sample1.r:sample1.g):(sample1.g*.5+sample1.r*.5);

        float h=pos.y/iResolution.y;
        if(h<=max_)
            return vec4(rgb*1.,1.);
    }
    return vec4(0.,0.,0.,0.);
}

void mainImage( out vec4 fragColor, in vec2 fragCoord ) {

    if(mirror){
        if(fragCoord.x*2<iResolution.x){
            fragColor=drawbar(ivec2(iResolution.x/2-fragCoord.x-(1+pixel_empty- pixel_empty/2),fragCoord.y),true);
        }
        else{
            fragColor=drawbar(ivec2(fragCoord.x-iResolution.x/2-pixel_empty/2,fragCoord.y),false);
        }
    }else{
        fragColor=drawbar(ivec2(fragCoord),true);
    }

}
