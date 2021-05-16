#version 130

void mainImage( out vec4 fragColor, in vec2 fragCoord ) {
    if(fragCoord.y<1){
        fragColor= texture(iChannel1, vec2(fragCoord.x/iResolution.x,0));
    }else{
        fragColor= texelFetch(iChannel2,ivec2(fragCoord.x,fragCoord.y-1) , 0);
    }
}
