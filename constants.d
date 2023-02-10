/*
 *	Constants - same values for both G1 & G2A
 */

/*
 *	Script packet version - to better track potential issues
 */
//-- Engine constants

const int NPC_GAME_NORMAL = 0; //When player is taking item
const int NPC_GAME_PLUNDER = 1; //When player is looting Npc
const int NPC_GAME_STEAL = 2; //When player is stealing from Npc (in RM we won't have this situation)

//Log constants
const int LOG_STATUS_INVALID = -1;
//const int LOG_DEFAULT = 0;
//const int LOG_RUNNING = 1;
//const int LOG_SUCCESS = 2;
//const int LOG_FAILED = 3;
//const int LOG_OBSOLETE = 4;

const int LOG_SECTION_INVALID = -1;
//const int LOG_MISSION = 0;
//const int LOG_NOTE = 1;

const int MAX_CTRL_VOBS = 80;

//enum zTAICamMsg {
const int zPLAYER_MOVED_FORWARD = 1 << 1;
const int zPLAYER_MOVED_BACKWARD = 1 << 2;
const int zPLAYER_MOVED_LEFT = 1 << 3;
const int zPLAYER_MOVED_RIGHT = 1 << 4;
const int zPLAYER_MOVED_UP = 1 << 5;
const int zPLAYER_MOVED_DOWN = 1 << 6;
const int zPLAYER_ROTATED_LEFT = 1 << 7;
const int zPLAYER_ROTATED_RIGHT = 1 << 8;
const int zPLAYER_ROTATED_UP = 1 << 9;
const int zPLAYER_ROTATED_DOWN = 1 << 10;
const int zPLAYER_MOVED = 1 << 11;
const int zPLAYER_STAND = 1 << 12;
const int zPLAYER_ROTATED = 1 << 13;
const int zPLAYER_ROT_NONE = 1 << 14;
const int zPLAYER_BEAMED = 1 << 15;
//};


/*
 *	GFA has these constants defined globally - so in order to be compatible - we will not have them defined globally - only use them locally where we need them.
 */

//enum zTTraceRayFlags {
//	const int zTRACERAY_VOB_IGNORE_NO_CD_DYN = 1 << 0;
//	const int zTRACERAY_VOB_IGNORE = 1 << 1;
//	const int zTRACERAY_VOB_BBOX = 1 << 2;
//	const int zTRACERAY_VOB_OBB = 1 << 3;
//	const int zTRACERAY_STAT_IGNORE = 1 << 4;
//	const int zTRACERAY_STAT_POLY = 1 << 5;
//	const int zTRACERAY_STAT_PORTALS = 1 << 6;
//	const int zTRACERAY_POLY_NORMAL = 1 << 7;
//	const int zTRACERAY_POLY_IGNORE_TRANSP = 1 << 8;
//	const int zTRACERAY_POLY_TEST_WATER = 1 << 9;
//	const int zTRACERAY_POLY_2SIDED = 1 << 10;
//	const int zTRACERAY_VOB_IGNORE_CHARACTER = 1 << 11;
//	const int zTRACERAY_FIRSTHIT = 1 << 12;
//	const int zTRACERAY_VOB_TEST_HELPER_VISUALS = 1 << 13;

//G2A only!
//	const int zTRACERAY_VOB_IGNORE_PROJECTILES = 1 << 14;
//};

const int NPC_PERC_MAX = 33;

//const float zMDL_ANI_BLEND_IN_ZERO = float_MAX;
//const float zMDL_ANI_BLEND_OUT_ZERO =-float_MAX;
const int zMDL_ANIEVENT_MAXSTRING = 4;
const int zMAN_VERS = 12;
const int zMDL_MAX_ANIS_PARALLEL = 6;
const int zMDL_MAX_MESHLIBS_PARALLEL = 4;
const int zMDL_VELRING_SIZE = 8;
const int MAX_ANIHISTORY = 16;

// Animation directions
/*
enum zTMdl_AniDir {
	zMDL_ANIDIR_FORWARD,
	zMDL_ANIDIR_REVERSE,
	zMDL_ANIDIR_ENDFASTEST
};
*/
const int ANIDIR_FORWARD = 0;
const int ANIDIR_REVERSE = 1;
const int ANIDIR_ENDFASTEST = 2;

const int ANI_TIME_INFINITE = -915135488; //-1000000.0f;

/*
enum {
	zMDL_STARTANI_DEFAULT,
	zMDL_STARTANI_ISNEXTANI,
	zMDL_STARTANI_FORCE
};
*/
const int STARTANI_DEFAULT = 0;
const int STARTANI_ISNEXTANI = 1;
const int STARTANI_FORCE = 2;

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

const int ALPHA_FUNC_MAT_DEFAULT = 0;
const int ALPHA_FUNC_NONE = 1;
const int ALPHA_FUNC_BLEND = 2;
const int ALPHA_FUNC_ADD = 3;
const int ALPHA_FUNC_SUB = 4;
const int ALPHA_FUNC_MUL = 5;
const int ALPHA_FUNC_MUL2 = 6;
const int ALPHA_FUNC_TEST = 7;


const int MAX_SPL_LEVEL = 20;
const int VFX_MAX_POS_SAMPLES = 10;
const int VFX_NUM_USERSTRINGS = 3;
const float VFX_LIFESPAN_FOREVER = -1;

const int ITM_STATE_MAX = 4;
//const int ITM_TEXT_MAX = 6;
const int ITM_COND_MAX = 3;

const int ITM_FLAG_NFOCUS = 1 << 23;

//Search flags for voblist functions [AFSP specific constants]

const int SEARCHVOBLIST_NOFILTERS = 0; //No special checks
const int SEARCHVOBLIST_CANSEE = 1; //Checks if Npc can see object
const int SEARCHVOBLIST_USEWAYNET = 2; //Uses waynet to calculate nearest object / if this flag is not used then functions uses 'air' distance
const int SEARCHVOBLIST_CHECKPORTALROOMOWNER = 4; //Ignore objects that are in portal room owned by another Npc

/*
 *	Color values [G1 & G2A constants]
 */
var int GFX_RED;
var int GFX_PALEGREEN;
var int GFX_SKY;
var int GFX_BROWN;
var int GFX_DOCHRE;
var int GFX_GREEN;
var int GFX_IVORY;
var int GFX_YELLOW;
var int GFX_PINK;
var int GFX_ORCHID;
var int GFX_DGREEN;
var int GFX_OCHRE;
var int GFX_PURPLE;
var int GFX_ORANGE;
var int GFX_BLACK;
var int GFX_BLUE;
var int GFX_DPINK;
var int GFX_AQUA;
var int GFX_FLESH;
var int GFX_LPINK;
var int GFX_STEEL;
var int GFX_DBLUE;
var int GFX_VIOLET;
var int GFX_DRED;
var int GFX_LBLUE;
var int GFX_WARMGREY;
var int GFX_CYAN;
var int GFX_KHAKI;
var int GFX_INDIGO;
var int GFX_LYELLOW;
var int GFX_COLDGREY;
var int GFX_CARROT;
var int GFX_GOLD;
var int GFX_WHITE;
var int GFX_GREY;
var int GFX_MBLUE;
var int GFX_MAGENTA;
var int GFX_OLIVE;
var int GFX_BEIGE;
var int GFX_LGREY;
var int GFX_DORANGE;

func void G12_ColorConstants_Init () {
	//0x008DC728 struct zCOLOR GFX_RED
	const int GFX_RED_addr_G1 = 9291560;

	//0x00AB39E0 struct zCOLOR GFX_RED
	const int GFX_RED_addr_G2 = 11221472;
	GFX_RED = MEM_ReadInt (MEMINT_SwitchG1G2 (GFX_RED_addr_G1, GFX_RED_addr_G2));

	//0x008DC72C struct zCOLOR GFX_PALEGREEN
	const int GFX_PALEGREEN_addr_G1 = 9291564;

	//0x00AB39E4 struct zCOLOR GFX_PALEGREEN
	const int GFX_PALEGREEN_addr_G2 = 11221476;
	GFX_PALEGREEN = MEM_ReadInt (MEMINT_SwitchG1G2 (GFX_PALEGREEN_addr_G1, GFX_PALEGREEN_addr_G2));

	//0x008DC730 struct zCOLOR GFX_SKY
	const int GFX_SKY_addr_G1 = 9291568;

	//0x00AB39E8 struct zCOLOR GFX_SKY
	const int GFX_SKY_addr_G2 = 11221480;
	GFX_SKY = MEM_ReadInt (MEMINT_SwitchG1G2 (GFX_SKY_addr_G1, GFX_SKY_addr_G2));

	//0x008DC738 struct zCOLOR GFX_BROWN
	const int GFX_BROWN_addr_G1 = 9291576;

	//0x00AB39F0 struct zCOLOR GFX_BROWN
	const int GFX_BROWN_addr_G2 = 11221488;
	GFX_BROWN = MEM_ReadInt (MEMINT_SwitchG1G2 (GFX_BROWN_addr_G1, GFX_BROWN_addr_G2));

	//0x008DC73C struct zCOLOR GFX_DOCHRE
	const int GFX_DOCHRE_addr_G1 = 9291580;

	//0x00AB39F4 struct zCOLOR GFX_DOCHRE
	const int GFX_DOCHRE_addr_G2 = 11221492;
	GFX_DOCHRE = MEM_ReadInt (MEMINT_SwitchG1G2 (GFX_DOCHRE_addr_G1, GFX_DOCHRE_addr_G2));

	//0x008DC740 int * Pal8to24
	//0x00AB39F8 int * Pal8to24

	//0x008DCB40 struct zCOLOR GFX_GREEN
	const int GFX_GREEN_addr_G1 = 9292608;

	//0x00AB3DF8 struct zCOLOR GFX_GREEN
	const int GFX_GREEN_addr_G2 = 11222520;
	GFX_GREEN = MEM_ReadInt (MEMINT_SwitchG1G2 (GFX_GREEN_addr_G1, GFX_GREEN_addr_G2));

	//0x008DCB44 struct zCOLOR GFX_IVORY
	const int GFX_IVORY_addr_G1 = 9292612;

	//0x00AB3DFC struct zCOLOR GFX_IVORY
	const int GFX_IVORY_addr_G2 = 11222524;
	GFX_IVORY = MEM_ReadInt (MEMINT_SwitchG1G2 (GFX_IVORY_addr_G1, GFX_IVORY_addr_G2));

	//0x008DCB48 struct zCOLOR GFX_YELLOW
	const int GFX_YELLOW_addr_G1 = 9292616;

	//0x00AB3E00 struct zCOLOR GFX_YELLOW
	const int GFX_YELLOW_addr_G2 = 11222528;
	GFX_YELLOW = MEM_ReadInt (MEMINT_SwitchG1G2 (GFX_YELLOW_addr_G1, GFX_YELLOW_addr_G2));

	//0x008DCB4C struct zCOLOR GFX_PINK
	const int GFX_PINK_addr_G1 = 9292620;

	//0x00AB3E04 struct zCOLOR GFX_PINK
	const int GFX_PINK_addr_G2 = 11222532;
	GFX_PINK = MEM_ReadInt (MEMINT_SwitchG1G2 (GFX_PINK_addr_G1, GFX_PINK_addr_G2));

	//0x008DCB50 struct zCOLOR GFX_ORCHID
	const int GFX_ORCHID_addr_G1 = 9292624;

	//0x00AB3E08 struct zCOLOR GFX_ORCHID
	const int GFX_ORCHID_addr_G2 = 11222536;
	GFX_ORCHID = MEM_ReadInt (MEMINT_SwitchG1G2 (GFX_ORCHID_addr_G1, GFX_ORCHID_addr_G2));

	//0x008DCB54 unsigned char * Cache
	//0x00AB3E0C unsigned char * Cache

	//0x008DCB58 struct zCOLOR GFX_DGREEN
	const int GFX_DGREEN_addr_G1 = 9292632;

	//0x00AB3E10 struct zCOLOR GFX_DGREEN
	const int GFX_DGREEN_addr_G2 = 11222544;
	GFX_DGREEN = MEM_ReadInt (MEMINT_SwitchG1G2 (GFX_DGREEN_addr_G1, GFX_DGREEN_addr_G2));

	//0x008DCB5C struct zCOLOR GFX_OCHRE
	const int GFX_OCHRE_addr_G1 = 9292636;

	//0x00AB3E14 struct zCOLOR GFX_OCHRE
	const int GFX_OCHRE_addr_G2 = 11222548;
	GFX_OCHRE = MEM_ReadInt (MEMINT_SwitchG1G2 (GFX_OCHRE_addr_G1, GFX_OCHRE_addr_G2));

	//0x008DCB60 struct zCOLOR GFX_PURPLE
	const int GFX_PURPLE_addr_G1 = 9292640;

	//0x00AB3E18 struct zCOLOR GFX_PURPLE
	const int GFX_PURPLE_addr_G2 = 11222552;
	GFX_PURPLE = MEM_ReadInt (MEMINT_SwitchG1G2 (GFX_PURPLE_addr_G1, GFX_PURPLE_addr_G2));

	//0x008DCB64 struct zCOLOR GFX_ORANGE
	const int GFX_ORANGE_addr_G1 = 9292644;

	//0x00AB3E1C struct zCOLOR GFX_ORANGE
	const int GFX_ORANGE_addr_G2 = 11222556;
	GFX_ORANGE = MEM_ReadInt (MEMINT_SwitchG1G2 (GFX_ORANGE_addr_G1, GFX_ORANGE_addr_G2));

	//0x008DCB68 struct zCOLOR GFX_BLACK
	const int GFX_BLACK_addr_G1 = 9292648;

	//0x00AB3E20 struct zCOLOR GFX_BLACK
	const int GFX_BLACK_addr_G2 = 11222560;
	GFX_BLACK = MEM_ReadInt (MEMINT_SwitchG1G2 (GFX_BLACK_addr_G1, GFX_BLACK_addr_G2));

	//0x008DCB6C struct zCOLOR GFX_BLUE
	const int GFX_BLUE_addr_G1 = 9292652;

	//0x00AB3E24 struct zCOLOR GFX_BLUE
	const int GFX_BLUE_addr_G2 = 11222564;
	GFX_BLUE = MEM_ReadInt (MEMINT_SwitchG1G2 (GFX_BLUE_addr_G1, GFX_BLUE_addr_G2));

	//0x008DCB70 struct zCOLOR GFX_DPINK
	const int GFX_DPINK_addr_G1 = 9292656;

	//0x00AB3E28 struct zCOLOR GFX_DPINK
	const int GFX_DPINK_addr_G2 = 11222568;
	GFX_DPINK = MEM_ReadInt (MEMINT_SwitchG1G2 (GFX_DPINK_addr_G1, GFX_DPINK_addr_G2));

	//0x008DCB74 struct zCOLOR GFX_AQUA
	const int GFX_AQUA_addr_G1 = 9292660;

	//0x00AB3E2C struct zCOLOR GFX_AQUA
	const int GFX_AQUA_addr_G2 = 11222572;
	GFX_AQUA = MEM_ReadInt (MEMINT_SwitchG1G2 (GFX_AQUA_addr_G1, GFX_AQUA_addr_G2));

	//0x008DCB78 struct zCOLOR GFX_FLESH
	const int GFX_FLESH_addr_G1 = 9292664;

	//0x00AB3E30 struct zCOLOR GFX_FLESH
	const int GFX_FLESH_addr_G2 = 11222576;
	GFX_FLESH = MEM_ReadInt (MEMINT_SwitchG1G2 (GFX_FLESH_addr_G1, GFX_FLESH_addr_G2));

	//0x008DCB7C struct zCOLOR GFX_LPINK
	const int GFX_LPINK_addr_G1 = 9292668;

	//0x00AB3E34 struct zCOLOR GFX_LPINK
	const int GFX_LPINK_addr_G2 = 11222580;
	GFX_LPINK = MEM_ReadInt (MEMINT_SwitchG1G2 (GFX_LPINK_addr_G1, GFX_LPINK_addr_G2));

	//0x008DCB80 struct zCOLOR GFX_STEEL
	const int GFX_STEEL_addr_G1 = 9292672;

	//0x00AB3E38 struct zCOLOR GFX_STEEL
	const int GFX_STEEL_addr_G2 = 11222584;
	GFX_STEEL = MEM_ReadInt (MEMINT_SwitchG1G2 (GFX_STEEL_addr_G1, GFX_STEEL_addr_G2));

	//0x008DCB84 struct zCOLOR GFX_DBLUE
	const int GFX_DBLUE_addr_G1 = 9292676;

	//0x00AB3E3C struct zCOLOR GFX_DBLUE
	const int GFX_DBLUE_addr_G2 = 11222588;
	GFX_DBLUE = MEM_ReadInt (MEMINT_SwitchG1G2 (GFX_DBLUE_addr_G1, GFX_DBLUE_addr_G2));

	//0x008DCB88 struct zCOLOR GFX_VIOLET
	const int GFX_VIOLET_addr_G1 = 9292680;

	//0x00AB3E40 struct zCOLOR GFX_VIOLET
	const int GFX_VIOLET_addr_G2 = 11222592;
	GFX_VIOLET = MEM_ReadInt (MEMINT_SwitchG1G2 (GFX_VIOLET_addr_G1, GFX_VIOLET_addr_G2));

	//0x008DCB8C struct zCOLOR GFX_DRED
	const int GFX_DRED_addr_G1 = 9292684;

	//0x00AB3E44 struct zCOLOR GFX_DRED
	const int GFX_DRED_addr_G2 = 11222596;
	GFX_DRED = MEM_ReadInt (MEMINT_SwitchG1G2 (GFX_DRED_addr_G1, GFX_DRED_addr_G2));

	//0x008DCB90 struct zCOLOR GFX_LBLUE
	const int GFX_LBLUE_addr_G1 = 9292688;

	//0x00AB3E48 struct zCOLOR GFX_LBLUE
	const int GFX_LBLUE_addr_G2 = 11222600;
	GFX_LBLUE = MEM_ReadInt (MEMINT_SwitchG1G2 (GFX_LBLUE_addr_G1, GFX_LBLUE_addr_G2));

	//0x008DCB94 struct zCOLOR GFX_WARMGREY
	const int GFX_WARMGREY_addr_G1 = 9292692;

	//0x00AB3E4C struct zCOLOR GFX_WARMGREY
	const int GFX_WARMGREY_addr_G2 = 11222604;
	GFX_WARMGREY = MEM_ReadInt (MEMINT_SwitchG1G2 (GFX_WARMGREY_addr_G1, GFX_WARMGREY_addr_G2));

	//0x008DCB98 struct zCOLOR GFX_CYAN
	const int GFX_CYAN_addr_G1 = 9292696;

	//0x00AB3E50 struct zCOLOR GFX_CYAN
	const int GFX_CYAN_addr_G2 = 11222608;
	GFX_CYAN = MEM_ReadInt (MEMINT_SwitchG1G2 (GFX_CYAN_addr_G1, GFX_CYAN_addr_G2));

	//0x008DCB9C struct zCOLOR GFX_KHAKI
	const int GFX_KHAKI_addr_G1 = 9292700;

	//0x00AB3E54 struct zCOLOR GFX_KHAKI
	const int GFX_KHAKI_addr_G2 = 11222612;
	GFX_KHAKI = MEM_ReadInt (MEMINT_SwitchG1G2 (GFX_KHAKI_addr_G1, GFX_KHAKI_addr_G2));

	//0x008DCBA0 struct zCOLOR GFX_INDIGO
	const int GFX_INDIGO_addr_G1 = 9292704;

	//0x00AB3E58 struct zCOLOR GFX_INDIGO
	const int GFX_INDIGO_addr_G2 = 11222616;
	GFX_INDIGO = MEM_ReadInt (MEMINT_SwitchG1G2 (GFX_INDIGO_addr_G1, GFX_INDIGO_addr_G2));

	//0x008DCBA4 struct zCOLOR GFX_LYELLOW
	const int GFX_LYELLOW_addr_G1 = 9292708;

	//0x00AB3E5C struct zCOLOR GFX_LYELLOW
	const int GFX_LYELLOW_addr_G2 = 11222620;
	GFX_LYELLOW = MEM_ReadInt (MEMINT_SwitchG1G2 (GFX_LYELLOW_addr_G1, GFX_LYELLOW_addr_G2));

	//0x008DCBA8 unsigned short * Gfx_Pal8to16
	//0x00AB3E60 unsigned short * Gfx_Pal8to16

	//0x008DCDA8 struct zCOLOR GFX_COLDGREY
	const int GFX_COLDGREY_addr_G1 = 9293224;

	//0x00AB4060 struct zCOLOR GFX_COLDGREY
	const int GFX_COLDGREY_addr_G2 = 11223136;
	GFX_COLDGREY = MEM_ReadInt (MEMINT_SwitchG1G2 (GFX_COLDGREY_addr_G1, GFX_COLDGREY_addr_G2));

	//0x008DCDAC struct zCOLOR GFX_CARROT
	const int GFX_CARROT_addr_G1 = 9293228;

	//0x00AB4064 struct zCOLOR GFX_CARROT
	const int GFX_CARROT_addr_G2 = 11223140;
	GFX_CARROT = MEM_ReadInt (MEMINT_SwitchG1G2 (GFX_CARROT_addr_G1, GFX_CARROT_addr_G2));

	//0x008DCDB0 struct zCOLOR GFX_GOLD
	const int GFX_GOLD_addr_G1 = 9293232;

	//0x00AB4068 struct zCOLOR GFX_GOLD
	const int GFX_GOLD_addr_G2 = 11223144;
	GFX_GOLD = MEM_ReadInt (MEMINT_SwitchG1G2 (GFX_GOLD_addr_G1, GFX_GOLD_addr_G2));

	//0x008DCDB4 unsigned char * CacheC
	//0x00AB406C unsigned char * CacheC

	//0x008DCDB8 struct zCOLOR GFX_WHITE
	const int GFX_WHITE_addr_G1 = 9293240;

	//0x00AB4070 struct zCOLOR GFX_WHITE
	const int GFX_WHITE_addr_G2 = 11223152;
	GFX_WHITE = MEM_ReadInt (MEMINT_SwitchG1G2 (GFX_WHITE_addr_G1, GFX_WHITE_addr_G2));

	//0x008DCDBC struct zCOLOR GFX_GREY
	const int GFX_GREY_addr_G1 = 9293244;

	//0x00AB4074 struct zCOLOR GFX_GREY
	const int GFX_GREY_addr_G2 = 11223156;
	GFX_GREY = MEM_ReadInt (MEMINT_SwitchG1G2 (GFX_GREY_addr_G1, GFX_GREY_addr_G2));

	//0x008DCDC0 struct zCOLOR GFX_MBLUE
	const int GFX_MBLUE_addr_G1 = 9293248;

	//0x00AB4078 struct zCOLOR GFX_MBLUE
	const int GFX_MBLUE_addr_G2 = 11223160;
	GFX_MBLUE = MEM_ReadInt (MEMINT_SwitchG1G2 (GFX_MBLUE_addr_G1, GFX_MBLUE_addr_G2));

	//0x008DCDC4 struct zCOLOR GFX_MAGENTA
	const int GFX_MAGENTA_addr_G1 = 9293252;

	//0x00AB407C struct zCOLOR GFX_MAGENTA
	const int GFX_MAGENTA_addr_G2 = 11223164;
	GFX_MAGENTA = MEM_ReadInt (MEMINT_SwitchG1G2 (GFX_MAGENTA_addr_G1, GFX_MAGENTA_addr_G2));

	//0x008DCDC8 struct zCOLOR GFX_OLIVE
	const int GFX_OLIVE_addr_G1 = 9293256;

	//0x00AB4080 struct zCOLOR GFX_OLIVE
	const int GFX_OLIVE_addr_G2 = 11223168;
	GFX_OLIVE = MEM_ReadInt (MEMINT_SwitchG1G2 (GFX_OLIVE_addr_G1, GFX_OLIVE_addr_G2));

	//0x008DCDCC struct zCOLOR GFX_BEIGE
	const int GFX_BEIGE_addr_G1 = 9293260;

	//0x00AB4084 struct zCOLOR GFX_BEIGE
	const int GFX_BEIGE_addr_G2 = 11223172;
	GFX_BEIGE = MEM_ReadInt (MEMINT_SwitchG1G2 (GFX_BEIGE_addr_G1, GFX_BEIGE_addr_G2));

	//0x008DCDD0 struct zCOLOR GFX_LGREY
	const int GFX_LGREY_addr_G1 = 9293264;

	//0x00AB4088 struct zCOLOR GFX_LGREY
	const int GFX_LGREY_addr_G2 = 11223176;
	GFX_LGREY = MEM_ReadInt (MEMINT_SwitchG1G2 (GFX_LGREY_addr_G1, GFX_LGREY_addr_G2));

	//0x008DCDD4 struct zCOLOR GFX_DORANGE
	const int GFX_DORANGE_addr_G1 = 9293268;

	//0x00AB408C struct zCOLOR GFX_DORANGE
	const int GFX_DORANGE_addr_G2 = 11223180;
	GFX_DORANGE = MEM_ReadInt (MEMINT_SwitchG1G2 (GFX_DORANGE_addr_G1, GFX_DORANGE_addr_G2));
};
