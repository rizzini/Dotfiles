#version 130

#define immune_radius $immune_radius
#define immune_frame $immune_frame
#define threshold1 $threshold1
#define threshold2 $threshold2
#define threshold3 $threshold3

float rand(vec2 co) {
    return fract(sin(dot(co.xy,vec2(12.9898,78.233))) * 43758.5453);
}

void mainImage( out vec4 fragColor, in vec2 fragCoord ) {
    //不指望alpha能记录数据
    fragColor.a=1;

    //新数据
    vec4 new = texture(iChannel1, vec2(fragCoord.x/iResolution.x,0));
    //历史数据
    vec4 t=texelFetch(iChannel2,ivec2(fragCoord.x,0), 0);

    float new_energy= (new.r+new.g)/2.0  ;
    //积累energy
    float acc_energy= t.r+ new_energy/immune_frame /2. ;

    float rand_threshold=rand(vec2(fragCoord.x/1000.0,fract(iFrame/10000.0)));

    bool newSignal=(new_energy>threshold1)
                   || (acc_energy>1) && (new_energy>threshold2) && (rand_threshold>0.5)
                   || (acc_energy>1) && (new_energy>threshold3) && (rand_threshold>0.9)  ;

    if(newSignal)
        for(int offset_x=-immune_radius ; offset_x<immune_radius+1; offset_x++) {
            if(offset_x==0)continue;
            vec4 neighbour= texture(iChannel1, vec2((fragCoord.x+offset_x)/iResolution.x,0));
            float neighbour_energy=(neighbour.r+neighbour.g)/2.;
            //必须用等号,不然会出现同时达到最高值的
            if(new_energy<=neighbour_energy) {
                newSignal=false;
                break;
            }
        }
    if(newSignal)
        for(int offset_x=-immune_radius ; offset_x<immune_radius+1; offset_x++) {
            vec4 hist_neighbour=texelFetch(iChannel2,ivec2(fragCoord.x+offset_x,1), 0);
            if(hist_neighbour.g*255.0<immune_frame) {
                newSignal=false;
                break;
            }
        }

    if(fragCoord.y<1) {
        //历史数据更新
        fragColor.r= newSignal ? 0: acc_energy;
        return;
    }
    if(fragCoord.y<2)
        if(newSignal) {
            //强度
            fragColor.r=new_energy;
            //生命
            fragColor.g=0;
            //随机数
            fragColor.b=rand(2+vec2(fragCoord.x/1000.0,fract(iFrame/10000.0)));
            return;
        }
    //位移
    if(newSignal) {
        fragColor= texelFetch(iChannel2,ivec2(fragCoord.x,fragCoord.y-1), 0);
    } else {
        fragColor= texelFetch(iChannel2,ivec2(fragCoord.x,fragCoord.y), 0);
    }
    fragColor.g+=1/255.0;
}
