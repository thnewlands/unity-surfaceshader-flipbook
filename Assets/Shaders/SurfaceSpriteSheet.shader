Shader "Custom/SurfaceSpriteSheet" {
	Properties {
		[Header(General)]
		_Color("Color", Color) = (1,1,1,1)
		_Glossiness("Smoothness", Range(0,1)) = 1
		_Metallic("Metallic", Range(0,1)) = 1
		
		[Header(Textures)]
		_MainTex ("Color Spritesheet", 2D) = "white" {}
		_NormalTex ("Normals Spritesheet", 2D) = "white" {}

		[Header(Spritesheet)]
		_Columns("Columns (int)", int) = 3
		_Rows("Rows (int)", int) = 3
		_FrameNumber ("Frame Number (int)", int) = 0
		_TotalFrames ("Total Number of Frames (int)", int) = 9
		//_FrameScale ("Frame Scale (for testing)", float) = 1
		_Cutoff ("Alpha Cutoff", Range(0,1)) = 1
		_AnimationSpeed ("Animation Speed", float) = 0
	}
	SubShader {
		Tags { "RenderType"="Opaque" "DisableBatching"="True"}
		LOD 200
		
		Cull Off

		CGPROGRAM
		#pragma surface surf Standard fullforwardshadows alphatest:_Cutoff addshadow
		#pragma target 3.0

		sampler2D _MainTex;
		sampler2D _NormalTex;

		struct Input {
			float2 uv_MainTex;
			float4 color : COLOR;
		};

		float4 _Color;
		half _Glossiness;
		half _Metallic;
		int _Columns;
		int _Rows;
		int _FrameNumber;
		int _TotalFrames;
		//float _FrameScale;

		float _AnimationSpeed;

		void surf (Input IN, inout SurfaceOutputStandard o) {

			_FrameNumber += frac(_Time[0] * _AnimationSpeed) * _TotalFrames;

			float frame = clamp(_FrameNumber, 0, _TotalFrames);

			float2 offPerFrame = float2((1 / (float)_Columns), (1 / (float)_Rows));

			float2 spriteSize = IN.uv_MainTex;
			spriteSize.x = (spriteSize.x / _Columns);
			spriteSize.y = (spriteSize.y / _Rows);

			float2 currentSprite = float2(0,  1 - offPerFrame.y);
			currentSprite.x += frame * offPerFrame.x;
			
			float rowIndex;
			float mod = modf(frame / (float)_Columns, rowIndex);
			currentSprite.y -= rowIndex * offPerFrame.y;
			currentSprite.x -= rowIndex * _Columns * offPerFrame.x;
			
			float2 spriteUV = (spriteSize + currentSprite); //* _FrameScale

			fixed4 c = tex2D(_MainTex, spriteUV) * _Color;

			o.Normal = UnpackNormal(tex2D(_NormalTex, spriteUV));
			o.Metallic = _Metallic;
			o.Smoothness = _Glossiness;
			o.Albedo = c.rgb;
			o.Alpha = c.a;
		}
		ENDCG
	}
	FallBack "Transparent/Cutout/Diffuse"
}
