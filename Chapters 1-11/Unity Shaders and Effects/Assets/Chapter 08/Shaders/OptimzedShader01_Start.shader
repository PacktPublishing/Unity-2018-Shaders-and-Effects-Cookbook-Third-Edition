Shader "CookbookShaders/Chapter08/OptimzedShader01_Start" {
	Properties 
	{
	  _MainTex ("Base (RGB)", 2D) = "white" {}
	  _NormalMap ("Normal Map", 2D) = "bump" {}
	}
  
	SubShader 
	{
	  Tags { "RenderType"="Opaque" }
	  LOD 200
    
	  CGPROGRAM
	  #pragma surface surf SimpleLambert 

	  sampler2D _MainTex;
	  sampler2D _NormalMap;

	  struct Input 
	  {
		float2 uv_MainTex;
		float2 uv_NormalMap;
	  };
    
	  inline float4 LightingSimpleLambert (SurfaceOutput s, 
	  									float3 lightDir, 
	  									float atten)
	  {
		  float diff = max (0, dot (s.Normal, lightDir));
      
		  float4 c;
		  c.rgb = s.Albedo * _LightColor0.rgb * (diff * atten * 2);
		  c.a = s.Alpha;
		  return c;
	  }


	  void surf (Input IN, inout SurfaceOutput o) 
	  {
		float4 c = tex2D (_MainTex, IN.uv_MainTex);
  
		o.Albedo = c.rgb;
		o.Alpha = c.a;
		o.Normal = UnpackNormal(tex2D(_NormalMap, IN.uv_NormalMap));
	  }
	  ENDCG
	} 
	FallBack "Diffuse"
}
