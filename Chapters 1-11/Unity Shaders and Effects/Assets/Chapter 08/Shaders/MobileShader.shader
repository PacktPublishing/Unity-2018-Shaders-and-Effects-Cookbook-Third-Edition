Shader "CookbookShaders/Chapter08/MobileShader" {
	Properties 
	{
		_Diffuse ("Base (RGB) Specular Amount (A)", 2D) = "white" {}
		_SpecIntensity ("Specular Width", Range(0.01, 1)) = 0.5
		_NormalMap ("Normal Map", 2D) = "bump"{}
	}

	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200

		CGPROGRAM
		#pragma surface surf MobileBlinnPhong exclude_path:prepass nolightmap noforwardadd halfasview

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		sampler2D _Diffuse;
		sampler2D _NormalMap;
		fixed _SpecIntensity;

		struct Input 
		{
			half2 uv_Diffuse;
		};

		// Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
		// See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
		// #pragma instancing_options assumeuniformscaling
		UNITY_INSTANCING_BUFFER_START(Props)
			// put more per-instance properties here
		UNITY_INSTANCING_BUFFER_END(Props)

		inline fixed4 LightingMobileBlinnPhong (SurfaceOutput s, fixed3 lightDir, fixed3 halfDir, fixed atten)
		{
			fixed diff = max (0, dot (s.Normal, lightDir));
			fixed nh = max (0, dot (s.Normal, halfDir));
			fixed spec = pow (nh, s.Specular*128) * s.Gloss;
			
			fixed4 c;
			c.rgb = (s.Albedo * _LightColor0.rgb * diff + _LightColor0.rgb * spec) * (atten*2);
			c.a = 0.0;
			return c;
		}


		void surf (Input IN, inout SurfaceOutput o) 
		{
			fixed4 diffuseTex = tex2D (_Diffuse, IN.uv_Diffuse);
			o.Albedo = diffuseTex.rgb;
			o.Gloss = diffuseTex.a;
			o.Alpha = 0.0;
			o.Specular = _SpecIntensity;
			o.Normal = UnpackNormal(tex2D(_NormalMap, IN.uv_Diffuse));
		}
		ENDCG
	}
	FallBack "Diffuse"
}
