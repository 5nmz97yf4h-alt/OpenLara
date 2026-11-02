// --- SKY GRADIENT SHADER ---
varying vec4 vViewVec;

void main() {
    // Calculăm direcția privirii pe axa verticală (Y)
    vec3 viewDir = normalize(vViewVec.xyz);
    float horizonFactor = clamp(viewDir.y * 0.5 + 0.5, 0.0, 1.0);
    
    // Culori pentru un cer atmosferic modern
    vec3 spaceMidnight = vec3(0.02, 0.04, 0.12); // Cerul de sus (albastru închis)
    vec3 horizonGlow   = vec3(0.15, 0.25, 0.40); // Lumina de la orizont (albastru deschis)
    
    // Amestecăm culorile în funcție de înălțimea camerei
    vec3 finalSky = mix(horizonGlow, spaceMidnight, horizonFactor);
    
    // Adăugăm o tentă subtilă de strălucire solară la orizont
    float sunGlow = pow(max(0.0, 1.0 - horizonFactor), 4.0);
    finalSky += vec3(0.2, 0.15, 0.1) * sunGlow;
    
    gl_FragColor = vec4(finalSky, 1.0);
}
