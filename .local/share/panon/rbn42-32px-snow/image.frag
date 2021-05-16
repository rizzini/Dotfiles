#version 130

#define background_color_and_opacity $background_color_and_opacity
#define max_life_time 100
#define glow_strength $glow_strength
#define bar_color_and_opacity $bar_color_and_opacity
#define particle_strength $particle_strength
#define pixel_fill $bar_width
#define pixel_empty $gap_width
#define height_ratio $height_ratio

vec4 drawSnow(vec2 fragCoord ) {
    vec4 fragColor=vec4(0,0,0,0);
    for(int j=-40; j<40; j++) {
        vec2 fragCoord2=fragCoord;
        fragCoord2.x+=j;
        vec3 rgb=getRGB(fragCoord2.x/iResolution.x);
        for(int i=1; i<min(128.0,iResolution.y); i++) {
            vec4 data= texelFetch(iChannel2,ivec2(fragCoord2.x,i), 0);
            if(data.g*255.>max_life_time )break;
            float dist_y=data.g*(data.r*2+1)/3.;
            float dist_x=data.g*80*(2*data.b-1);
            dist_y=pow(0.000001,dist_y)*iResolution.y*1.4;
            float dist=length(fragCoord-vec2(fragCoord2.x+dist_x,dist_y));
            float alpha= (data.r)*(1-data.g*255./max_life_time)*1.0 /pow(dist,glow_strength ) ;
            fragColor+=  vec4(rgb*alpha,alpha);
        }
    }
    return fragColor;
}

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



float drawBar( vec2 fragCoord ) {

    if(int(fragCoord.x) %(pixel_fill+pixel_empty)<pixel_fill) {
        float id=floor(fragCoord.x/(pixel_fill+pixel_empty));

        vec4 sample1=mean(id*(pixel_fill+pixel_empty)/iResolution.x,
                          (1+id)*(pixel_fill+pixel_empty)/iResolution.x);
        float max_=sample1.g*.5+sample1.r*.5;
        if(fragCoord.y+1<=max_*height_ratio*iResolution.y)
            return 1.0;
    }
    return 0.0;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord ) {
    fragColor=drawSnow(fragCoord)*particle_strength;
    fragColor+=drawBar(fragCoord)*vec4(bar_color_and_opacity.rgb*bar_color_and_opacity.a, bar_color_and_opacity.a );

    fragColor.a=0.0;

    fragColor.rgb+=background_color_and_opacity.rgb*background_color_and_opacity.a;
    fragColor.a+=background_color_and_opacity.a;
}
