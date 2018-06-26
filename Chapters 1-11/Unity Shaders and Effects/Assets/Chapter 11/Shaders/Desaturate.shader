Shader "CookbookShaders/Chapter11/Desaturate" 
{
	Properties 
	{ 
		_MainTex ("Base (RGB)", 2D) = "white" {} 
		_DesatValue ("Desaturate", Range(0,1)) = 0.5 
	} 

	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200

		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Standard fullforwardshadows

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0


		sampler2D _MainTex;
		fixed _DesatValue; 


		struct Input {
			float2 uv_MainTex;
		};

		// Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
		// See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
		// #pragma instancing_options assumeuniformscaling
		UNITY_INSTANCING_BUFFER_START(Props)
			// put more per-instance properties here
		UNITY_INSTANCING_BUFFER_END(Props)

		void surf (Input IN, inout SurfaceOutputStandard o) 
		{ 
			half4 c = tex2D (_MainTex, IN.uv_MainTex); 
			c.rgb = lerp(c.rgb, Luminance(c.rgb), _DesatValue); 
 
			o.Albedo = c.rgb; 
			o.Alpha = c.a; 
		} 

		ENDCG
	}
	FallBack "Diffuse"
}
