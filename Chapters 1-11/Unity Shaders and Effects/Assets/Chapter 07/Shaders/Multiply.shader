// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "CookbookShaders/Chapter07/Multiply" {
	Properties 
	{
		_Color ("Color", Color) = (1,0,0,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
	}
	SubShader 
	{
		Pass 
		{
			CGPROGRAM

			#pragma vertex vert
			#pragma fragment frag

			half4 _Color;
			sampler2D _MainTex;
			struct vertInput 
			{
				float4 pos : POSITION;
				float2 texcoord : TEXCOORD0;
			};

			struct vertOutput 
			{
				float4 pos : SV_POSITION;
				float2 texcoord : TEXCOORD0;
			};

			vertOutput vert(vertInput input) 
			{
				vertOutput o;
				o.pos = UnityObjectToClipPos(input.pos);
				o.texcoord = input.texcoord;
				return o;
			}

			half4 frag(vertOutput output) : COLOR
			{
				half4 mainColour = tex2D(_MainTex, output.texcoord);
				return mainColour * _Color;
			}
			ENDCG
		}
	}
	FallBack "Diffuse"
}
