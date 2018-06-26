Shader "CookbookShaders/Chapter09/Grayscale" 
{
	Properties 
	{
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_Luminosity("Luminosity", Range(0.0, 1)) = 1.0
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
			fixed _Luminosity;

			fixed4 frag(v2f_img i) : COLOR
			{
				//Get the colors from the RenderTexture and the uv's
				//from the v2f_img struct
				fixed4 renderTex = tex2D(_MainTex, i.uv);
				
				//Apply the Luminosity values to our render texture
				float luminosity = 0.299 * renderTex.r + 0.587 * renderTex.g + 0.114 * renderTex.b;
				fixed4 finalColor = lerp(renderTex, luminosity, _Luminosity);

				renderTex.rgb = finalColor;
				
				return renderTex;
			}
		
		ENDCG
		}
	}
	FallBack off
}
