// --- WATER CAUSTICS SHADER MODIFICAT ---
uniform vec4 uParam; // uParam.x reprezinta timpul (time) pentru animatie
varying vec3 vCoord;
varying vec4 vNormal;

float generateWaves(vec2 uv, float speed) {
    // Matematica pentru valuri procedurale suprapuse
    float time = uParam.x * speed;
    float w1 = sin(uv.x * 0.05 + time) * cos(uv.y * 0.05 + time);
    float w2 = sin(uv.y * 0.1 - time) * cos(uv.x * 0.08 + time * 1.5);
    return (w1 + w2) * 0.5 + 0.5;
}

void main() {
    vec2 waterUV = vCoord.xz * 0.005; // Scalarea texturii de apa
    
    // Generam doua straturi de valuri care se intersecteaza pentru realism
    float waveLayer1 = generateWaves(waterUV, 2.0);
    float waveLayer2 = generateWaves(waterUV * 1.8 + vec2(0.5), 1.3);
    
    float finalCaustic = mix(waveLayer1, waveLayer2, 0.5);
    
    // Definim o culoare de apa moderna, un turcoaz profund cristalin
    vec3 waterCyan = vec3(0.05, 0.50, 0.75);
    vec3 causticBright = vec3(0.8, 0.95, 1.0) * finalCaustic * 0.4;
    
    vec3 finalWaterColor = waterCyan + causticBright;
    
    gl_FragColor = vec4(finalWaterColor, 0.55); // 0.55 este transparenta apei (mai curata)
}
