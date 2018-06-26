Shader "CookbookShaders/Chapter09/Grayscale" 
{
	Properties 
	{
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_DepthPower("Depth Power", Range(0, 1)) = 0.2
	}

	SubShader 
	{
		Pass
		{
			CGPROGRAM
			#pragma vertex vert_img
			#pragma fragment frag
			#pragma fragmentoption ARB_precision_hint_fastest
			#include "UnityCG.cginc"

			uniform sampler2D _MainTex;
			fixed _DepthPower;
			sampler2D _CameraDepthTexture;

			fixed4 frag(v2f_img i) : COLOR
			{
				//Get the colors from the RenderTexture and the uv's
				//from the v2f_img struct
				float depth = UNITY_SAMPLE_DEPTH(tex2D(_CameraDepthTexture, i.uv.xy));
				depth = pow(Linear01Depth(depth), _DepthPower);

				return depth;
			}
		
		ENDCG
		}
	}
	FallBack off
}
