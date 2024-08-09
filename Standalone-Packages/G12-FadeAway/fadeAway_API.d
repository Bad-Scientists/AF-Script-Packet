/*
 *	Fade away
 *
 *	1. Copy this file outside of script-packet
 *	2. Customize it
 *	3. Link it to Gothic.src
 *	4. Profit
 */

//Should Npc drop weapon?
const int FADEAWAY_DROPWEAPON = FALSE;

//Should Npc drop inventory?
const int FADEAWAY_DROPINVENTORY = TRUE;
const int FADEAWAY_DONTDROPFLAGS = 0;
const int FADEAWAY_DONTDROPMAINFLAG = 0;

const string FADEAWAY_ITEMSLOTNAME = "BIP01";

/*
 *	In this example SummonedByPC_StoneGolem will be faded away
 */
func int C_Npc_IsSummoned(var C_NPC slf) {
	if (Hlp_GetInstanceID(slf) == SummonedByPC_StoneGolem)
	{
		return TRUE;
	};

	return FALSE;
};
