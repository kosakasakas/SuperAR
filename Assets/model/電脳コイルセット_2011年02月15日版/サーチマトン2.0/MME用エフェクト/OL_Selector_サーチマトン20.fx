////////////////////////////////////////////////////////////////////////////////////////////////
//
// Material Selector for ObjectLuminous.fx
// �d�]�R�C���Z�b�g�u�T�[�`�}�g��2.0�v Edition
//
////////////////////////////////////////////////////////////////////////////////////////////////
// ���[�U�[�p�����[�^

//�ΏۂƂ���f�ނ̃T�u�Z�b�g�ԍ�
#define TargetSubset1 "4"
#define TargetSubset2 "5"
#define TargetSubset3 "6"

//���ˌ��ŕ����Ȃ��f��
#define BlockSubset ""

//�����F (RGBA�e�v�f 0.0�`1.0)
float4 Emittion_Color1
<
   string UIName = "Emittion Color1";
   string UIWidget = "Color";
   bool UIVisible =  true;
   float UIMin = 0.0; float UIMax = 1.0;
> = float4( 0.1, 0.1, 1, 1 );

float4 Emittion_Color2
<
   string UIName = "Emittion Color2";
   string UIWidget = "Color";
   bool UIVisible =  true;
   float UIMin = 0.0; float UIMax = 1.0;
> = float4( 0.3, 0.3, 1, 1 );

float4 Emittion_Color3
<
   string UIName = "Emittion Color3";
   string UIWidget = "Color";
   bool UIVisible =  true;
   float UIMin = 0.0; float UIMax = 1.0;
> = float4( 1, 0.3, 0.2, 1 );

//�Q�C��
float Gain1
<
   string UIName = "Gain 1";
   string UIWidget = "Slider";
   bool UIVisible =  true;
   float UIMin = 0.0; float UIMax = 5.0;
> = float( 0.7 );

float Gain2
<
   string UIName = "Gain 1";
   string UIWidget = "Slider";
   bool UIVisible =  true;
   float UIMin = 0.0; float UIMax = 5.0;
> = float( 1 );

float Gain3
<
   string UIName = "Gain 1";
   string UIWidget = "Slider";
   bool UIVisible =  true;
   float UIMin = 0.0; float UIMax = 5.0;
> = float( 0.3 );


//�e�N�X�`���p�L�[�J���[
float4 KeyTexColor3
<
   string UIName = "KeyTexColor3";
   string UIWidget = "Color";
   bool UIVisible =  true;
   float UIMin = 0.0; float UIMax = 1.0;
> = float4( 0, 0, 0, 0 );

//�L�[�J���[�F��臒l
float KeyThreshold
<
   string UIName = "Key Threshold";
   string UIWidget = "Slider";
   bool UIVisible =  true;
   float UIMin = 0.0; float UIMax = 1.0;
> = float( 0.35 );

////////////////////////////////////////////////////////////////////////////////////////////////

float4 MaterialDiffuse : DIFFUSE  < string Object = "Geometry"; >;
static float alpha1 = MaterialDiffuse.a;

bool use_texture;  //�e�N�X�`���̗L��

// �I�u�W�F�N�g�̃e�N�X�`��
texture ObjectTexture: MATERIALTEXTURE;
sampler ObjTexSampler = sampler_state
{
    texture = <ObjectTexture>;
    MINFILTER = LINEAR;
    MAGFILTER = LINEAR;
};

// MMD�{����sampler���㏑�����Ȃ����߂̋L�q
sampler MMDSamp0 : register(s0);
sampler MMDSamp1 : register(s1);
sampler MMDSamp2 : register(s2);

////////////////////////////////////////////////////////////////////////////////////////////////

bool ColorMuch(float4 color1, float4 key){
    float4 s = color1 - key;
    return (length(s.rgb) <= KeyThreshold);
}

////////////////////////////////////////////////////////////////////////////////////////////////
//�s�N�Z���V�F�[�_

float4 PS_Selected1(float2 Tex : TEXCOORD1) : COLOR {
    float4 color = Emittion_Color1;
    float alpha = alpha1;
    if ( use_texture ) alpha *= tex2D( ObjTexSampler, Tex ).a;
    color.rgb *= (Gain1 * alpha);
    return color;
}
float4 PS_Selected2(float2 Tex : TEXCOORD1) : COLOR {
    float4 color = Emittion_Color2;
    float alpha = alpha1;
    if ( use_texture ) alpha *= tex2D( ObjTexSampler, Tex ).a;
    color.rgb *= (Gain2 * alpha);
    return color;
}
float4 PS_Selected3(float2 Tex : TEXCOORD1) : COLOR {
    float4 color = Emittion_Color3;
    float4 texcolor;
    float alpha = alpha1;
    if ( use_texture ){
        texcolor = tex2D( ObjTexSampler, Tex );
        alpha *= texcolor.a;
        
        if(KeyTexColor3.a > 0.1){
            if(!(ColorMuch(texcolor, KeyTexColor3))) color.rgb = 0;
        }
    }
    color.rgb *= (Gain3 * alpha);
    return color;
}

float4 PS_Block() : COLOR {
    return float4(0.0, 0.0, 0.0, 0.2);
}
float4 PS_Black(float2 Tex : TEXCOORD1) : COLOR {
    float alpha = alpha1;
    if ( use_texture ) alpha *= tex2D( ObjTexSampler, Tex ).a;
    return float4(0.0, 0.0, 0.0, alpha);
}

////////////////////////////////////////////////////////////////////////////////////////////////
//�e�N�j�b�N

//�Z���t�V���h�E�Ȃ�
technique Select1 < string Subset = TargetSubset1; > {
    pass Single_Pass {
        AlphaBlendEnable = FALSE;
        PixelShader = compile ps_2_0 PS_Selected1();
    }
}
technique Select2 < string Subset = TargetSubset2; > {
    pass Single_Pass {
        AlphaBlendEnable = FALSE;
        PixelShader = compile ps_2_0 PS_Selected2();
    }
}
technique Select3 < string Subset = TargetSubset3; > {
    pass Single_Pass {
        AlphaBlendEnable = FALSE;
        PixelShader = compile ps_2_0 PS_Selected3();
    }
}

technique  Block < string Subset = BlockSubset; > {
    pass Single_Pass {
        AlphaBlendEnable = FALSE;
        PixelShader = compile ps_2_0 PS_Block();
    }
}
technique Mask {
    pass Single_Pass { PixelShader = compile ps_2_0 PS_Black(); }
}

//�Z���t�V���h�E����
technique Select1SS < string MMDPass = "object_ss"; string Subset = TargetSubset1; > {
    pass Single_Pass {
        AlphaBlendEnable = FALSE;
        PixelShader = compile ps_2_0 PS_Selected1();
    }
}
technique Select2SS < string MMDPass = "object_ss"; string Subset = TargetSubset2; > {
    pass Single_Pass {
        AlphaBlendEnable = FALSE;
        PixelShader = compile ps_2_0 PS_Selected2();
    }
}
technique Select3SS < string MMDPass = "object_ss"; string Subset = TargetSubset3; > {
    pass Single_Pass {
        AlphaBlendEnable = FALSE;
        PixelShader = compile ps_2_0 PS_Selected3();
    }
}

technique  BlockSS < string MMDPass = "object_ss"; string Subset = BlockSubset; > {
    pass Single_Pass {
        AlphaBlendEnable = FALSE;
        PixelShader = compile ps_2_0 PS_Block();
    }
}
technique MaskSS < string MMDPass = "object_ss"; > {
    pass Single_Pass { PixelShader = compile ps_2_0 PS_Black(); }
}

//�e��֊s�͕`�悵�Ȃ�
technique EdgeTec < string MMDPass = "edge"; > { }
technique ShadowTec < string MMDPass = "shadow"; > { }
technique ZplotTec < string MMDPass = "zplot"; > { }

