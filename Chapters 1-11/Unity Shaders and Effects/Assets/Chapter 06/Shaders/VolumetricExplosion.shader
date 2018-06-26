Shader "CookbookShaders/Chapter06/VolumetricExplosion" {
	Properties 
	{
		_RampTex("Color Ramp", 2D) = "white" {}
		_RampOffset("Ramp offset", Range(-0.5,0.5))= 0
		
		_NoiseTex("Noise Texture", 2D) = "gray" {}
		_Period("Period", Range(0,1)) = 0.5
		
		_Amount("_Amount", Range(0, 1.0)) = 0.1
		_ClipRange("ClipRange", Range(0,1)) = 1
	}

	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200

		CGPROGRAM
		#pragma surface surf Lambert vertex:vert nolightmap

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		struct Input 
		{
			float2 uv_NoiseTex;
		};

		sampler2D _RampTex;
		half _RampOffset;

		sampler2D _NoiseTex;
		float _Period;

		half _Amount;
		half _ClipRange;

		void vert(inout appdata_full v) 
		{
			float3 disp = tex2Dlod(_NoiseTex, float4(v.texcoord.xy,0,0));
			float time = sin(_Time[3] *_Period + disp.r*10);
			v.vertex.xyz += v.normal * disp.r * _Amount * time;
		}

		// Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
		// See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
		// #pragma instancing_options assumeuniformscaling
		UNITY_INSTANCING_BUFFER_START(Props)
			// put more per-instance properties here
		UNITY_INSTANCING_BUFFER_END(Props)

		void surf(Input IN, inout SurfaceOutput o) 
		{
			float3 noise = tex2D(_NoiseTex, IN.uv_NoiseTex);

			float n = saturate(noise.r + _RampOffset);

			clip(_ClipRange - n);

			half4 c = tex2D(_RampTex, float2(n,0.5));

			o.Albedo = c.rgb;
			o.Emission = c.rgb*c.a;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
