#ifndef MY_CG_INCLUDE 
#define MY_CG_INCLUDE 

fixed4 _MyColor; 
 
inline fixed4 LightingHalfLambert(SurfaceOutput s, fixed3 lightDir, fixed atten) 
{ 
    fixed diff = max(0, dot(s.Normal, lightDir)); 
    diff = (diff + 0.5)*0.5; 
 
    fixed4 c; 
    c.rgb = s.Albedo * _LightColor0.rgb* ((diff * _MyColor.rgb) * atten); 
    c.a = s.Alpha; 
    return c; 
} 
#endif 