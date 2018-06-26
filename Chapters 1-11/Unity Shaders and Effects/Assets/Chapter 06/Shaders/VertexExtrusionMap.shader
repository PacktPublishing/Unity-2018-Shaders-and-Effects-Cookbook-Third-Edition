Shader "CookbookShaders/Chapter06/Normal Extrusion Map" {
	Properties{
		_MainTex("Texture", 2D) = "white" {}
		_ExtrusionTex("Extrusion map", 2D) = "white" {}
	_Amount("Extrusion Amount", Range(-0.0001,0.0001)) = 0
	}
		SubShader{
		Tags{ "RenderType" = "Opaque" }
		CGPROGRAM
#pragma surface surf Standard vertex:vert
	struct Input {
		float2 uv_MainTex;
	};
	float _Amount;
	sampler2D _ExtrusionTex;
	void vert(inout appdata_full v) {
		float4 tex = tex2Dlod (_ExtrusionTex, float4(v.texcoord.xy,0,0));
		float extrusion = tex.r * 2 - 1;
		v.vertex.xyz += v.normal * _Amount * extrusion;
	}
	sampler2D _MainTex;
	void surf(Input IN, inout SurfaceOutputStandard o) {

		float4 tex = tex2D(_ExtrusionTex, IN.uv_MainTex);
		float extrusion = abs(tex.r * 2 - 1);

		o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;
		o.Albedo = lerp(o.Albedo.rgb, float3(0, 0,0), extrusion * _Amount / 0.0001 *1.1);
	}
	ENDCG
	}
		Fallback "Diffuse"
}