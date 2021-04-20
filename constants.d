//const float zMDL_ANI_BLEND_IN_ZERO   = float_MAX;
//const float zMDL_ANI_BLEND_OUT_ZERO  =-float_MAX;
const int zMDL_ANIEVENT_MAXSTRING    = 4;
const int zMAN_VERS                  = 12;
const int zMDL_MAX_ANIS_PARALLEL     = 6;
const int zMDL_MAX_MESHLIBS_PARALLEL = 4;
const int zMDL_VELRING_SIZE          = 8;
const int MAX_ANIHISTORY             = 16;
  
// Animation directions
/*
enum zTMdl_AniDir {
	zMDL_ANIDIR_FORWARD,
	zMDL_ANIDIR_REVERSE,
	zMDL_ANIDIR_ENDFASTEST
};
*/
const int AniDir_Forward	= 0;
const int AniDir_Reverse	= 1;
const int AniDir_EndFastest	= 2;

/*
enum zTRnd_AlphaBlendFunc {
	zRND_ALPHA_FUNC_MAT_DEFAULT,
	zRND_ALPHA_FUNC_NONE,
	zRND_ALPHA_FUNC_BLEND,
	zRND_ALPHA_FUNC_ADD,
	zRND_ALPHA_FUNC_SUB,
	zRND_ALPHA_FUNC_MUL,
	zRND_ALPHA_FUNC_MUL2,
	zRND_ALPHA_FUNC_TEST
}; 
*/

const int ALPHA_FUNC_MAT_DEFAULT	= 0;
const int ALPHA_FUNC_NONE		= 1;
const int ALPHA_FUNC_BLEND		= 2;
const int ALPHA_FUNC_ADD		= 3;
const int ALPHA_FUNC_SUB		= 4;
const int ALPHA_FUNC_MUL		= 5;
const int ALPHA_FUNC_MUL2		= 6;
const int ALPHA_FUNC_TEST		= 7;
