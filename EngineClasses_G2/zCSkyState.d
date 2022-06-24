/*
const int zSKY_NUM_LAYER = 2;
const int NUM_PLANETS = 2;
const int zEFFECT_BOX_SIDES = 2500;
const int zEFFECT_BOX_HEIGHT = 1000;
const int zMAX_FLY_PARTICLE = 1024;
const int zMAX_IMPACT_PARTICLE = 1024;
const int zCACHE_SIZE = 512;

enum zESkyLayerMode {
zSKY_MODE_POLY,
zSKY_MODE_BOX
};

enum zTSkyStateEffect {
zSKY_STATE_EFFECT_SUN,
zSKY_STATE_EFFECT_CLOUDSHADOW
};
*/

// sizeof 98h
class zCSkyState {
	var int time; //float  // sizeof 04h offset 00h
	var int polyColor[3]; //zVEC3  // sizeof 0Ch offset 04h
	var int fogColor[3]; //zVEC3  // sizeof 0Ch offset 10h
	var int domeColor1[3]; //zVEC3  // sizeof 0Ch offset 1Ch
	var int domeColor0[3]; //zVEC3  // sizeof 0Ch offset 28h
	var int fogDist; //float  // sizeof 04h offset 34h
	var int sunOn; //int  // sizeof 04h offset 38h
	var int cloudShadowOn; //int  // sizeof 04h offset 3Ch

	var int layer0_skyMode; //zESkyLayerMode  // sizeof 04h offset 00h
	var int layer0_tex; //zCTexture*  // sizeof 04h offset 04h
	var string layer0_texName; //zSTRING  // sizeof 14h offset 08h
	var int layer0_texAlpha; //float  // sizeof 04h offset 1Ch
	var int layer0_texScale; //float  // sizeof 04h offset 20h
	var int layer0_texSpeed[2]; //zVEC2  // sizeof 08h offset 24h

	var int layer1_skyMode; //zESkyLayerMode  // sizeof 04h offset 00h
	var int layer1_tex; //zCTexture*  // sizeof 04h offset 04h
	var string layer1_texName; //zSTRING  // sizeof 14h offset 08h
	var int layer1_texAlpha; //float  // sizeof 04h offset 1Ch
	var int layer1_texScale; //float  // sizeof 04h offset 20h
	var int layer1_texSpeed[2]; //zVEC2  // sizeof 08h offset 24h
};
