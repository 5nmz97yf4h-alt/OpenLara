// --- AMBIENT SHADER MODERNIZAT ---
uniform vec4 uLightColor;
uniform vec4 uMaterial;
varying vec4 vDiffuse;
varying vec4 vNormal;

void main() {
    vec4 color = vDiffuse;
    vec3 normalVec = normalize(vNormal.xyz);
    
    // Corecție de iluminare ambientală pentru un plus de adâncime
    vec3 ambientLight = min(uMaterial.yyy, vec3(0.4, 0.4, 0.4));
    
    // Amplificăm intensitatea surselor de lumină locale (ex: torțe, foc)
    vec3 dynamicLight = uLightColor.xyz * 1.5;
    
    vec3 finalLight = ambientLight + dynamicLight;
    color.xyz *= finalLight;
    
    // Corecție Gamma integrată direct în shader-ul de ambient pentru culori bogate
    color.rgb = pow(max(vec3(0.0), color.rgb), vec3(1.0 / 1.2));
    
    gl_FragColor = color;
}
