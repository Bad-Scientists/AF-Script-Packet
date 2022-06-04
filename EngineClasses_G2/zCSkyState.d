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

//G2A
// sizeof 2Ch
class zCSkyLayerData {
public:
zESkyLayerMode skyMode; // sizeof 04h offset 00h
zCTexture* tex; // sizeof 04h offset 04h
zSTRING texName; // sizeof 14h offset 08h
float texAlpha; // sizeof 04h offset 1Ch
float texScale; // sizeof 04h offset 20h
zVEC2 texSpeed; // sizeof 08h offset 24h

// sizeof 98h
class zCSkyState {
public:
float time; // sizeof 04h offset 00h
zVEC3 polyColor; // sizeof 0Ch offset 04h
zVEC3 fogColor; // sizeof 0Ch offset 10h
zVEC3 domeColor1; // sizeof 0Ch offset 1Ch
zVEC3 domeColor0; // sizeof 0Ch offset 28h
float fogDist; // sizeof 04h offset 34h
int sunOn; // sizeof 04h offset 38h
int cloudShadowOn; // sizeof 04h offset 3Ch
zCSkyLayerData layer[zSKY_NUM_LAYER]; // sizeof 58h offset 40h