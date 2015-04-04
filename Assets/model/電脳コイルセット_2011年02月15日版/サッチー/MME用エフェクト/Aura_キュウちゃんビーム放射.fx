//MME_Aura ver1.1
//�������ЂƁF���x���A�i�r�[���}��P�j


//�������@�̐ݒ�
//
//�����������F
//BLENDMODE_SRC SRCALPHA
//BLENDMODE_DEST INVSRCALPHA
//
//���Z�����F
//
//BLENDMODE_SRC SRCALPHA
//BLENDMODE_DEST ONE

#define BLENDMODE_SRC SRCALPHA
#define BLENDMODE_DEST ONE

//�e�N�X�`����
texture Aura_Tex1
<
   string ResourceName = "Aura_�L���E�����r�[������_tex1.png";
>;
texture Aura_Tex2
<
   string ResourceName = "Aura_�L���E�����r�[������_tex2.png";
>;

//�O���T�C�Y�iMMD���Si�~�傫�����\�������傫���j
float OutSize
<
   string UIName = "OutSize";
   string UIWidget = "Numeric";
   bool UIVisible =  true;
   float UIMin = -100.0;
   float UIMax = 100.0;
> = float( 1 );
//�����T�C�Y�i�O���ɑ΂��Ă̊����@0�`1�j
float InSize
<
   string UIName = "InRatio";
   string UIWidget = "Numeric";
   bool UIVisible =  true;
   float UIMin = -100.0;
   float UIMax = 100.0;
> = float( 0 );
//����
float Height
<
   string UIName = "Height";
   string UIWidget = "Numeric";
   bool UIVisible =  true;
   float UIMin = -100.0;
   float UIMax = 100.0;
> = float( -0.15 );

//�����p�x�i360�őS���́j
float SpritRot
<
   string UIName = "SpritRot";
   string UIWidget = "Numeric";
   bool UIVisible =  true;
   float UIMin = 0;
   float UIMax = 360.0;
> = float( 360 );

//�e�N�X�`���X�N���[�����x
float ScrollSpd
<
   string UIName = "UScroll";
   string UIWidget = "Numeric";
   bool UIVisible =  true;
   float UIMin = 0.00;
   float UIMax = -10.00;
> = float( 3 );

//�e�N�X�`���J��Ԃ���
float ScrollNum
<
   string UIName = "UWrapNum";
   string UIWidget = "Numeric";
   bool UIVisible =  true;
   int UIMin = 0.0;
   int UIMax = 100.0;
> = float( 0 );

//�F�ݒ�
float4 Color
<
	string UIName = "Color";
	string UIWidget = "Color";
	bool UIVisible = true;
	float UIMin = 0.0;
	float UIMax = 1.0;
> = float4( 1.00, 0.69, 0.22, 1.0 );

//���邳
float Brightness
<
   string UIName = "Brightness";
   string UIWidget = "Numeric";
   bool UIVisible =  true;
   int UIMin = 0.0;
   int UIMax = 1.0;
> = float( 1 );

//���������x
float DefAlpha
<
   string UIName = "DefAlpha";
   string UIWidget = "Numeric";
   bool UIVisible =  true;
   float UIMin = 0.0;
   float UIMax = 1.0;
> = float( 1 );

//�G�t�F�N�g�^�C�v
#define AURA_WAVE	0
#define AURA_DISC	1
#define AURA_EX		2
#define AURA_NOTYPE 3
int EffectType
<
   string UIName = "EffectType";
   string UIWidget = "Numeric";
   bool UIVisible =  true;
   int UIMin = 0;
   int UIMax = 1;
> = int(1);

//--�悭�킩��Ȃ��l�͂������牺�͂�������Ⴞ��--//

float time_0_X : Time;
//�΂̒l
#define PI 3.1415
//�p�x�����W�A���l�ɕϊ�
#define RAD(x) ((x * PI) / 180.0)

float4x4 WorldViewProjMatrix : WORLDVIEWPROJECTION;

float4   MaterialDiffuse   : DIFFUSE  < string Object = "Geometry"; >;
float3   LightDiffuse      : DIFFUSE   < string Object = "Light"; >;
static float4 DiffuseColor  = MaterialDiffuse  * float4(LightDiffuse, 1.0f);

struct VS_OUTPUT {
   float4 Pos: POSITION;
   float2 texCoord: TEXCOORD0;
   float color: TEXCOORD1;
};

VS_OUTPUT lineSystem_Vertex_Shader_main(float4 Pos: POSITION){
   VS_OUTPUT Out;

   Out.texCoord.y = (Pos.x + 1)/2 - 0.001;
   Out.texCoord.x = Pos.z * ScrollNum;
      
   //Z�l�i0�`�P�j����p�x���v�Z���A���W�A���l�ɕϊ�����
   float rad = RAD(Pos.z * SpritRot);
   
   //--xz���W��ɔz�u����
   
   //x���}�C�i�X=�O��
   if(Pos.x < 0)
   {
   		Out.Pos.x = cos(rad) * OutSize;	
   		Out.Pos.z = sin(rad) * OutSize;
   		//y�l�͍����p�����[�^���̂܂�
   		//WAVE�̏ꍇ��TR�l�ɂ���č����ω�
   		float w = Height;
	    if(EffectType == AURA_WAVE || EffectType == AURA_EX)
		    w = lerp(0,Height,DiffuseColor.a);
   		Out.Pos.y = w;
   }else{
	   //����
	   //DISC�̏ꍇ��TR�l�ɂ���ē����ω�
	    float w = InSize;
	    if(EffectType == AURA_DISC || EffectType == AURA_EX)
		    w = lerp(OutSize,InSize,DiffuseColor.a);
   		Out.Pos.x = cos(rad) * w;		   
   		Out.Pos.z = sin(rad) * w;
   		Out.Pos.y = 0;
   } 
   
   Out.Pos.w = 1;   
   Out.Pos = mul(Out.Pos, WorldViewProjMatrix);
   Out.color = (time_0_X * ScrollSpd) % 1.0;

   return Out;
}

//�e�N�X�`���̐ݒ�
sampler AuraTex1Sampler = sampler_state
{
   //�g�p����e�N�X�`��
   Texture = (Aura_Tex1);
   //�e�N�X�`���͈�0.0�`1.0���I�[�o�[�����ۂ̏���
   //WRAP:���[�v
   ADDRESSU = WRAP;
   ADDRESSV = CLAMP;
   //�e�N�X�`���t�B���^�[
   //LINEAR:���`�t�B���^
   MAGFILTER = LINEAR;
   MINFILTER = LINEAR;
   MIPFILTER = LINEAR;
};
//�e�N�X�`���̐ݒ�
sampler AuraTex2Sampler = sampler_state
{
   //�g�p����e�N�X�`��
   Texture = (Aura_Tex2);
   //�e�N�X�`���͈�0.0�`1.0���I�[�o�[�����ۂ̏���
   //WRAP:���[�v
   ADDRESSU = WRAP;
   ADDRESSV = CLAMP;
   //�e�N�X�`���t�B���^�[
   //LINEAR:���`�t�B���^
   MAGFILTER = LINEAR;
   MINFILTER = LINEAR;
   MIPFILTER = LINEAR;
};
//�s�N�Z���V�F�[�_

//�ʓx�v�Z�p
const float4 calcY = float4( 0.2989f, 0.5866f, 0.1145f, 0.00f );

float4 lineSystem_Pixel_Shader_main(float2 texCoord: TEXCOORD0,float color: TEXCOORD1) : COLOR {
   //���͂��ꂽ�e�N�X�`�����W�ɏ]���ĐF��I������
   
   float2 add = float2(color,0);
   float4 col = float4(tex2D(AuraTex1Sampler,texCoord + add));
   add.x += 0.1;
   float4 col2 = float4(tex2D(AuraTex2Sampler,texCoord - add));
   
   float4 c = col * col2;
   
   float r = c * calcY;
   r *= Brightness;

   c *= Color + r;

   c.a = max(col.a,col2.a) * DiffuseColor.a * DefAlpha;
   
   return c;
}

//�e�N�j�b�N�̒�`
technique lineSystem <
    string Script = 
		//�`��Ώۂ����C����ʂ�
        "RenderColorTarget0=;"
	    "RenderDepthStencilTarget=;"
	    //�p�X�̑I��
	    "Pass=lineSystem;"
    ;
> {
   //���C���p�X
   pass lineSystem
   {
      //Z�l�̍l���F����
      ZENABLE = TRUE;
      //Z�l�̕`��F���Ȃ�
      ZWRITEENABLE = FALSE;
      //�J�����O�I�t�i���ʕ`��
      CULLMODE = NONE;
      //���u�����h���g�p����
      ALPHABLENDENABLE = TRUE;
      //���u�����h�̐ݒ�i�ڂ����͍ŏ��̒萔���Q�Ɓj
      SRCBLEND=BLENDMODE_SRC;
      DESTBLEND=BLENDMODE_DEST;
      //�g�p����V�F�[�_��ݒ�
      VertexShader = compile vs_2_0 lineSystem_Vertex_Shader_main();
      PixelShader = compile ps_2_0 lineSystem_Pixel_Shader_main();
   }
}

