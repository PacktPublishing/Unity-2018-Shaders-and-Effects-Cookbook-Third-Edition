// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "CookbookShaders/Chapter07/GrabShader" {

	SubShader 
	{
		Tags{ "Queue" = "Transparent" }

		//GrabPass{ "_GrabTexture" }	// For a shared texture
		GrabPass{  }					// For a new pass every time
		
		Pass 
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"
			sampler2D _GrabTexture;

			struct vertInput 
			{
				float4 vertex : POSITION;
			};

			struct vertOutput 
			{
				float4 vertex : POSITION;
				float4 uvgrab : TEXCOORD1;
			};

			// Vertex function
			vertOutput vert(vertInput v) 
			{
				vertOutput o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uvgrab = ComputeGrabScreenPos(o.vertex);
				return o;
			}

			// Fragment function
			half4 frag(vertOutput i) : COLOR 
			{
				fixed4 col = tex2Dproj(_GrabTexture, UNITY_PROJ_COORD(i.uvgrab));
				
				// Add a bit of red to the color given
				return col + half4(0.5,0,0,0);
			}
			ENDCG
		}

	}
	FallBack "Diffuse"
}
