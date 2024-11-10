varying mediump vec2 var_texcoord0;
varying mediump vec4 var_position;

uniform lowp sampler2D texture_sampler;
uniform lowp vec4 time;
uniform lowp vec4 fire_params;
uniform lowp vec4 rect_params;


#define M_PI 3.1415926535897932384626433832795
#define M_TWO_PI (2.0 * M_PI)

float rand(vec2 n) {
    return fract(sin(dot(n, vec2(12.9898,12.1414))) * 83758.5453);
}

float noise(vec2 n) {
    const vec2 d = vec2(0.0, 1.0);
    vec2 b = floor(n);
    vec2 f = smoothstep(vec2(0.0), vec2(1.0), fract(n));
    return mix(mix(rand(b), rand(b + d.yx), f.x), mix(rand(b + d.xy), rand(b + d.yy), f.x), f.y);
}

vec3 ramp(float t) {
    return t <= .5 ? 
        vec3(1. - t * 1.4 * fire_params.z, .2, 1.05 * fire_params.w) / t : 
        vec3(.3 * (1. - t) * 2. * fire_params.z, .2, 1.05 * fire_params.w) / t;
}

vec2 polarMap(vec2 uv, float shift, float inner) {
    uv = vec2(0.5) - uv;

    float px = 1.0 - fract(atan(uv.y, uv.x) / 6.28 + 0.25) + shift;

    vec2 rect_size = vec2(rect_params.x, rect_params.y);
    vec2 d = abs(uv) - rect_size;
    float corner_radius = rect_params.z;
    float rect = length(max(d, 0.0)) + min(max(d.x, d.y), 0.0) - corner_radius;

    float py = (rect * (1.0 + inner * 2.0) - inner) * 2.0;

    return vec2(px, py);
}

float fire(vec2 n) {
    return noise(n) + noise(n * 2.1) * .6 + noise(n * 5.4) * .42;
}

float shade(vec2 uv, float t) {
    uv.x += uv.y < .5 ? 23.0 + t * .035 : -11.0 + t * .03;    
    uv.y = abs(uv.y - .5);
    uv.x *= 35.0 * fire_params.y;

    float q = fire(uv - t * .013) / 2.0;
    vec2 r = vec2(fire(uv + q / 2.0 + t - uv.x - uv.y), fire(uv + q - t));

    return pow((r.y + r.y) * max(.0, uv.y) + .1, 4.0);
}

vec3 color(float grad) {
    float m2 = 1.15;
    grad = sqrt(grad);
    vec3 color = vec3(1.0 / (pow(vec3(0.5, 0.0, .1) + 2.61, vec3(2.0))));
    vec3 color2 = color;
    color = ramp(grad);
    color /= (m2 + max(vec3(0), color));

    return color;
}

void main() {
    float m1 = 3.6;

    float t = time.x;
    vec2 uv = var_texcoord0;
    float ff = 1.0 - uv.y;

    vec2 uv2 = uv;
    uv2.y = 1.0 - uv2.y;
    uv = polarMap(uv, 1.3, m1 * fire_params.x);
    uv2 = polarMap(uv2, 1.9, m1 * fire_params.x);
    vec3 c1 = color(shade(uv, t)) * ff;
    vec3 c2 = color(shade(uv2, t)) * (1.0 - ff);

    float alpha = (c1.r + c1.g + c1.b + c2.r + c2.g + c2.b) / 6.0;
    alpha = smoothstep(0.1, 0.2, alpha);

    gl_FragColor = vec4(c1 + c2, alpha);
}