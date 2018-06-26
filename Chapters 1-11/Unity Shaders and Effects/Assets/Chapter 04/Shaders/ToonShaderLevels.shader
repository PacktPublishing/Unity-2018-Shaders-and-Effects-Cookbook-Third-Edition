Shader "CookbookShaders/Chapter04/ToonShaderLevels" {
	Properties 
	{
		_MainTex("Texture", 2D) = "white" {} 
		_CelShadingLevels("Levels", Range(1,10)) = 5
	}

	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200

		CGPROGRAM
		
		#pragma surface surf CustomLambert

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		sampler2D _MainTex;

		struct Input {
			float2 uv_MainTex;
		};

		// Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
		// See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
		// #pragma instancing_options assumeuniformscaling
		UNITY_INSTANCING_BUFFER_START(Props)
			// put more per-instance properties here
		UNITY_INSTANCING_BUFFER_END(Props)

		void surf(Input IN, inout SurfaceOutput o) { 
		  o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb; 
		} 

		fixed _CelShadingLevels;

		half4 LightingCustomLambert (SurfaceOutput s, half3 lightDir, 
									 half3 viewDir, half atten) 
		{ 
			half NdotL = dot (s.Normal, lightDir);   

			// Snap instead
			half cel = floor(NdotL * _CelShadingLevels) / 
					   (_CelShadingLevels - 0.5); 

			// Next, set what color should be returned
			half4 color; 

			color.rgb = s.Albedo * _LightColor0.rgb * (cel * atten ); 
			color.a = s.Alpha; 

			// Return the calculated color
			return color; 
		} 

		ENDCG
	}
	FallBack "Diffuse"
}
