/*
const int zSKY_NUM_LAYER = 2;
const int NUM_PLANETS = 2;

enum zESkyLayerMode {
zSKY_MODE_POLY,
zSKY_MODE_BOX
};

enum zTSkyStateEffect {
zSKY_STATE_EFFECT_SUN,
zSKY_STATE_EFFECT_CLOUDSHADOW
};
*/

// sizeof C0h
class zCSkyState {
	var int time; //float // sizeof 04h offset 00h
	var int polyColor[3]; //zVEC3 // sizeof 0Ch offset 04h
	var int fogColor[3]; //zVEC3 // sizeof 0Ch offset 10h
	var int domeColor1[3]; //zVEC3 // sizeof 0Ch offset 1Ch
	var int domeColor0[3]; //zVEC3 // sizeof 0Ch offset 28h
	var int fogDist; //float // sizeof 04h offset 34h
	var int sunOn; //int // sizeof 04h offset 38h
	var int cloudShadowOn; //int // sizeof 04h offset 3Ch

	//zCSkyLayerData layer[zSKY_NUM_LAYER]; // sizeof 80h offset 40h
	//class zCSkyLayerData {
	var int layer0_skyMode; //64 zESkyLayerMode // sizeof 04h offset 00h
	var int layer0_texBox[5]; //68 zCTexture* // sizeof 14h offset 04h 48h
	var int layer0_tex; //88 zCTexture* // sizeof 04h offset 18h
	var string layer0_texName; //92 zSTRING // sizeof 14h offset 1Ch
	var int layer0_texAlpha; //112 float // sizeof 04h offset 30h
	var int layer0_texScale; //116 float // sizeof 04h offset 34h
	var int layer0_texSpeed[2]; //120 zVEC2 // sizeof 08h offset 38h

	var int layer1_skyMode; //128 zESkyLayerMode // sizeof 04h offset 00h
	var int layer1_texBox[5]; //132 zCTexture* // sizeof 14h offset 04h
	var int layer1_tex; //152 zCTexture* // sizeof 04h offset 18h
	var string layer1_texName; //156 zSTRING // sizeof 14h offset 1Ch
	var int layer1_texAlpha; //176 float // sizeof 04h offset 30h
	var int layer1_texScale; //180 float // sizeof 04h offset 34h
	var int layer1_texSpeed[2]; //184 zVEC2 // sizeof 08h offset 38h
};
