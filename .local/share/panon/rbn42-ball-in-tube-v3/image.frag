#version 130


#define opacity $opacity
#define color_left $color_left
#define color_right $color_right

#define strength3 $strength
#define pow_exp $pow_exp
#define speed $speed
#define camera_speed $camera_speed
#define ball_x $ball_x
#define ball_y $ball_y
#define ball_z $ball_z
#define camera_z $camera_z

#define ball_radius $ball_radius
#define tube_radius $ball_radius

#define layout_w $layout_w
#define layout_h $layout_h

#define pow5(x) pow(x, 5.0)
//设定视角到球心距离是1

//屏幕大小，影响tube的能见范围，和实际的球大小，以及球心和管心

/*
映射到tube的位置
x 是arc， y是depth ，
y=0的位置是当前音频， 和球不是一个位置，而是从视角出发，切过球面触及tube的位置
因为视角到球心是1，所以视角到y=0是tube_radius/ball_radius
*/

/*
 * 旋转球和管，还是旋转视角原点
 * 如果旋转视角，那么球放在0,0,0
 * 不然，视角放在0,0,0
 *
 */

struct Ray
{
    vec3 ori;
    vec3 dir;
};

float sphere(vec3 ray, vec3 dir, vec3 center, float radius)
{
    vec3 rc = ray-center;
    float c = dot(rc, rc) - (radius*radius);
    float b = dot(dir, rc);
    float d = b*b - c;
    float t = -b - sqrt(abs(d));
    float st = step(0.0, min(t,d));
    return mix(-1.0, t, st);
}

const float FRESNEL_BIAS  	   = 0.3;
const float FRESNEL_SCALE 	   = 0.5;
const float FRESNEL_POWER 	   = 0.8;

float fresnel(const in Ray ray, const vec3 normal)
{
    return FRESNEL_BIAS + FRESNEL_SCALE * pow(clamp(1.0 + dot(ray.dir, normal), 0.0, 1.0), FRESNEL_POWER);
}

vec3 tube(vec3 pos2) {
    //if(pos2.y>0)return vec3(0);
    //if(pos2.x>0)return vec3(0);
    float depth=-pos2.z/speed;
    //if(depth<0)return vec3(0);
    vec2 pos=pos2.xy/tube_radius;
    float x=0.5-asin(pos.y)/asin(1.0)/2; // 0~1, 0的位置是最高点
    bool lr=pos.x<0;
    float x2=(2-x)/2;
    x2=lr?x2:(1-x2);
    vec3 color=x2*color_left.rgb+(1-x2)*color_right.rgb;

    color+=getRGB(depth-iFrame/iResolution.y).rgb;
    vec4 s;
    s= texture(iChannel2, vec2( x,depth  ));
    s.r=pow(s.r,pow_exp);
    s.g=pow(s.g,pow_exp);
    s.rgb=color*(lr?s.r:s.g)*strength3;
    s+= texture(iChannel3, vec2( x,fract((depth*speed-iTime)/20)  ));
    return s.rgb;
}


vec3 intersect_tube(vec3 p1,vec3 p2) {

    //ro,rd+ro的延长线，和x*x+y*y=C的交点，就是tube，要解开这个方程式
    vec3 rd=p1-p2;
    vec3 point_tube;
    //X*X+Y*Y=R*R
    float formula_a=rd.x*rd.x+rd.y*rd.y;
    float formula_b=2*(-p2.z*rd.x*rd.x+p2.x*rd.z*rd.x-p2.z*rd.y*rd.y+p2.y*rd.z*rd.y);
    float formula_c= -tube_radius*tube_radius*rd.z*rd.z;
    formula_c+=(-p2.z*rd.x+p2.x*rd.z)*(-p2.z*rd.x+p2.x*rd.z);
    formula_c+=(-p2.z*rd.y+p2.y*rd.z)*(-p2.z*rd.y+p2.y*rd.z);
    //if(formula_b*formula_b-4*formula_a*formula_c<0)
    //    return vec3(0,0,0);

    float z1=(-formula_b-sqrt(formula_b*formula_b-4*formula_a*formula_c))/2/formula_a;
    float z2=(-formula_b+sqrt(formula_b*formula_b-4*formula_a*formula_c))/2/formula_a;
    if((z1-p1.z)*(p2.z-p1.z)>0)
        point_tube.z=z1;
    else
        point_tube.z=z2;
    point_tube.x=p2.x+(point_tube.z-p2.z)/rd.z*rd.x;
    point_tube.y=p2.y+(point_tube.z-p2.z)/rd.z*rd.y;
    return point_tube;

}

const vec3 GROUND_DIR 	       = vec3(0.0, 1.0, 0.0);
const vec3 SKY_DIR    	 	   = vec3(0.0, 1.0, 0.0);

const vec3 SCENE_COLOR    	   = vec3(0.7, 0.5, 0.3);
const vec3 SUN_COLOR      	   = vec3(2.0, 1.6, 1.0);

const float SUN_SCALE          = 0.4;

float iGlobalTime 		  	   = 0.0;

vec3 sky(vec3 rd, vec3 cubemap)
{
    float sky = max(0.0, dot(rd, SKY_DIR));
    return pow5(sky) * cubemap;
}

vec3 sunLight(vec3 rd, vec3 lightDir)
{
    float sunF = max(0.0, dot(rd, lightDir));
    return (pow(sunF, 256.0) + SUN_SCALE * pow5(sunF)) * SUN_COLOR;
}

vec3 sceneColor(vec3 rd,vec3 ro)
{
    vec3   light = normalize(vec3(sin(iGlobalTime), 2.8, cos(iGlobalTime)-30));
    float  ground = max(0.0, dot(rd, -GROUND_DIR));
    vec3   cubemap =vec3(0);// texture(iChannel0, rd).rgb;

    vec3 point_tube=intersect_tube(ro,rd+ro);
    cubemap=tube(point_tube);

    return sunLight(rd, light)*0 + pow5(ground) * cubemap +
           sky(rd, cubemap) * SCENE_COLOR;
}


void mainImage( out vec4 fragColor, in vec2 fragCoord ) {
    vec2 layout_id=floor(fragCoord/iResolution.xy *vec2(layout_w,layout_h));
    vec2 gridRes=iResolution.xy/vec2(layout_w,layout_h);

    fragCoord=fract( fragCoord*vec2(layout_w,layout_h)/iResolution.xy)*gridRes.xy;

    //0,-0.2,0.2
    vec3 ball_center=vec3(ball_x,ball_y,ball_z);

    // -0.5 ~ 0.5
    vec2 uv=(fragCoord*2 - gridRes.xy) / min(gridRes.x,gridRes.y) /2;

    Ray ray;
    //ray origin, camera,相对uv屏幕中心0,0
    //0,0,-1.3
    float cs=camera_speed; //*(1+layout_id.x+layout_id.y*layout_w);
    
    ray.ori=vec3(sin(iTime*cs)/8,cos(iTime*cs)/20,camera_z);

    vec3 ro=ray.ori;
    //rd=vec3(uv,screen)-ro,透过uv到camera的射线
    vec3 lookat = vec3(0,0,0);

    float zoom = 1.;

    //0,0,1
    vec3 f = normalize(lookat-ro);
    //1,0,0
    vec3 r = cross(vec3(0., 1., 0.), f);
    //0,1,0
    vec3 u = cross(f, r);

    //0,0,-0.3
    vec3 c = ro + f*zoom;
    //uv+0,0,-0.3
    vec3 i = c + uv.x*r + uv.y*u;
    //uv+0,0,1
    vec3 rd = i-ro;
    ray.dir=rd;
    //rd=vec3(uv,1);


    float t = sphere(ro, rd, ball_center, ball_radius);
    vec3 point_ball=(ro+rd*t);
    vec3 nml = normalize(ball_center -point_ball );

    Ray reflectRay;
    reflectRay.ori = ray.ori;
    reflectRay.dir = reflect(ray.dir, nml);

    float fresnel = fresnel(reflectRay, nml);

    vec3 bgColor =  sceneColor(ray.dir,ray.ori);
    vec3 reflectionColor = sceneColor(reflectRay.dir,reflectRay.ori);

    vec3 point_tube;
    vec3 refl=reflectRay.dir;
    point_tube=intersect_tube( point_ball,point_ball+refl);

    vec3 reflection = 2.0 * 0.5 * pow(tube(point_tube).rgb, vec3(1.0)) * fresnel;
    reflectionColor += reflection;
    vec3 color = mix(bgColor, reflectionColor, 0.8) ;
    fragColor = vec4(color, 1.0);
    fragColor.a=opacity+ max(max(max(fragColor.r,fragColor.g),fragColor.b),0);
    fragColor.a=opacity;
}
