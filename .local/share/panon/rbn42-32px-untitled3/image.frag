#version 130

#define bcolor $background_color_and_opacity

#define min_arc $min_arc
#define max_arc $max_arc
#define strength1 $strength
#define laser_width $laser_width

#define dual_channel $dual_channel

#define N1 $N1

void mainImage( out vec4 fragColor, in vec2 fragCoord ) {
    //fragCoord.y+=1;
    if(dual_channel)
        fragCoord.y-=iResolution.y/2;
    bool updown=(fragCoord.y>=0);
    if(updown)
        fragColor.y+=2;
    else
        fragColor.y-=2;

    fragColor.rgb=bcolor.rgb*bcolor.a;
    fragColor.a=bcolor.a;

    if(abs(fragCoord.y)<1)return;

    ivec2 p1;
    int max_radius=dual_channel? int(iResolution.y/2):int(iResolution.y);
    max_radius= min(256,max_radius);
    for(int x=-max_radius;x<max_radius+1;x++){
        p1.x=int(fragCoord.x)+x;
        int y=int(pow(fragCoord.y*fragCoord.y+x*x,0.5));
        for(p1.y=y-3;p1.y<y+4;p1.y++){
            if(p1.y>iResolution.y)continue;
            vec4 samplev= texelFetch(iChannel2,ivec2(p1.x,p1.y*p1.y/iResolution.y), 0);
            float arc=((max_arc-min_arc)*fract(-p1.x/N1)+min_arc)/180*3.14;
            float samplef;
            if(dual_channel)
                samplef=updown?samplev.r:samplev.g;
            else
                samplef=(samplev.r+samplev.g)/2;
            vec2 p2=vec2(p1.x,0)+(updown?1:-1)*p1.y*vec2(cos(arc),sin(arc));

            float dist=length(fragCoord-p2);
            float alpha=dist<(laser_width/2.0-0.5)?1:(dist<(laser_width/2.0+0.5)?(laser_width/2.0+0.5-dist):0);
            alpha= samplef *strength1* alpha;
            if(alpha>fragColor.a){
                fragColor.rgb=getRGB(p1.x/iResolution.x)*alpha; 
                fragColor.a=alpha;
            }
        }

    }
}
