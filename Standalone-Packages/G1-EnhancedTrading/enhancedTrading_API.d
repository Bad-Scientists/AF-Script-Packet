/*
 *	Enhanced Trading system
 *
 *	1. Copy this file outside of script-packet
 *	2. Customize it (translate to your own language, define your own rules for traders)
 *	3. Link it to Gothic.src
 *	4. Profit
 */

const string ENHANCEDTRADING_FONT = "FONT_OLD_20_WHITE.TGA";

//API function
//Called when you don't have enough ore
func void EnhancedTrading_NotEnoughOre() {
	PrintScreen("You don't have enough ore!", -1, 45, ENHANCEDTRADING_FONT, _TIME_MESSAGE_LOGENTRY);
};

//API function
//Called when trader does not have enough ore (First warning)
func void EnhancedTrading_Trader_NotEnoughOre() {
	PrintScreen("Trader doesn't have enough ore!", -1, 45, ENHANCEDTRADING_FONT, _TIME_MESSAGE_LOGENTRY);
};

//API function
//Called when trader does not have enough ore (Second warning - if you confirm trade - it will go through)
func void EnhancedTrading_Trader_NotEnoughOre_Confirm() {
	PrintScreen("You will loose ore with this trade. Do you really want to accept?", -1, 45, ENHANCEDTRADING_FONT, _TIME_MESSAGE_LOGENTRY);
};

/*
 *	Example #1
 *	Cipher will buy only ItMi_Plants_SwampHerb_01
 */
func void Subtitles_ForTrading() {
	AI_Output (self, self, "DIA_Trade_NotInterrested");	//I am not interrested.
};

//API function
//This is where you can define Npc&Item-specific rules for traders buying only specific items
func int C_Npc_WantsToBuyItems(var C_NPC slf, var int itemPtr) {
	if (!Hlp_Is_oCItem(itemPtr)) { return FALSE; };
	var oCItem itm; itm = _^(itemPtr);

	//Using symbol names to be compatible with your compilation (you might not have same Npcs or items in your mod)
	var string npcInstName; npcInstName = GetSymbolName(Hlp_GetInstanceID(slf));
	var string itmInstName; itmInstName = GetSymbolName(Hlp_GetInstanceID(itm));

	if (Hlp_StrCmp(npcInstName, "ORG_873_CIPHER")) {
		if (!Hlp_StrCmp(itmInstName, "ITMI_PLANTS_SWAMPHERB_01")) {
			if (!Npc_HasAni(slf, "T_NO"))
			{
				var C_NPC nullInstance; nullInstance = Hlp_GetNpc(-1);
				MEM_PushInstParam(slf);
				MEM_PushInstParam(nullInstance);
				MEM_PushStringParam("DIA_Trade_NotInterrested");
				MEM_Call(B_SayOverlay);

				AI_PlayAni(slf, "T_NO");
			};

			//Trader does not want to buy this
			return FALSE;
		};
	};

	//Trade accepts the offer
	return TRUE;
};

/*
 *	Example #2
 *	Default selling multiplier is 0.3 (30% of their price)
 *	Cipher will buy ItMi_Plants_SwampHerb_01 with multiplier 1.0 (100% full price)
 *	Wolf will buy all furs and skins with multiplier 1.0
 *	Armor will be sold with multiplier 1.0
 *	Weapons will be sold with multiplier 0.1 (10% of their price)
 */

//API function
//This is where you can define selling multiplier
func int C_Npc_GetSellMultiplierF(var C_NPC slf, var int itemPtr) {
	//Set by default to 30%
	var int multiplierF; multiplierF = (divf(mkf(3), mkf(10)));
	if (!Hlp_Is_oCItem(itemPtr)) { return multiplierF; };

	var oCItem itm; itm = _^(itemPtr);

	//Using symbol names to be compatible with your compilation (you might not have same Npcs or items in your mod)
	var string npcInstName; npcInstName = GetSymbolName(Hlp_GetInstanceID(slf));
	var string itmInstName; itmInstName = GetSymbolName(Hlp_GetInstanceID(itm));

	//Cipher will buy swamp weed in 1:1 ratio - full price
	if (Hlp_StrCmp(npcInstName, "ORG_873_CIPHER")) {
		if (Hlp_StrCmp(itmInstName, "ITMI_PLANTS_SWAMPHERB_01")) {
			multiplierF = FLOATONE;
		};
	};

	//Wolf will trade furs and skins in 1 x 1 ratio
	if (Hlp_StrCmp(npcInstName, "ORG_855_WOLF")) {
		if ((Hlp_StrCmp(itmInstName, "ITAT_WOLF_01"))
		|| (Hlp_StrCmp(itmInstName, "ITAT_WOLF_02"))
		|| (Hlp_StrCmp(itmInstName, "ITAT_SHADOW_01"))
		|| (Hlp_StrCmp(itmInstName, "ITAT_TROLL_01"))
		|| (Hlp_StrCmp(itmInstName, "ITAT_BLACKTROLL_01"))
		|| (Hlp_StrCmp(itmInstName, "ITAT_LURKER_02"))
		|| (Hlp_StrCmp(itmInstName, "ITAT_SWAMPSHARK_01")))
		{
			multiplierF = FLOATONE;
		};
	};

	//ARMOR - set to 100%
	if (itm.mainflag & ITEM_KAT_ARMOR) {
		multiplierF = FLOATONE;
	};

	//WEAPONS - set to 10%
	if (itm.mainflag & ITEM_KAT_NF)
	|| (itm.mainflag & ITEM_KAT_FF)
	{
		multiplierF = (divf(mkf(1), mkf(10)));
	};

	return multiplierF;
};

/*
 *	Example #3
 *	If player belongs to Guards in the Old camp - all Old camp traders will sell items with multiplier 0.5 (50% of their price)
 */

//API function
//This is where you can define buying multiplier
func int C_Npc_GetBuyMultiplierF(var C_NPC slf, var int itemPtr) {
	//Set by default to 100%
	var int multiplierF; multiplierF = FLOATONE;
	if (!Hlp_Is_oCItem(itemPtr)) { return multiplierF; };

	var oCItem itm; itm = _^(itemPtr);

	//Using symbol names to be compatible with your compilation (you might not have same Npcs or items in your mod)
	var string npcInstName; npcInstName = GetSymbolName(Hlp_GetInstanceID(slf));
	var string itmInstName; itmInstName = GetSymbolName(Hlp_GetInstanceID(itm));

	//Redefining locally to be compatible with G2 NoTR
	const int GIL_GRD = 2;

	//Consider these folks Old Camp traders
	if (Hlp_StrCmp(npcInstName, "EBR_106_BARTHOLO"))
	|| (Hlp_StrCmp(npcInstName, "GRD_211_SKIP"))
	|| (Hlp_StrCmp(npcInstName, "STT_300_ALBERTO"))
	|| (Hlp_StrCmp(npcInstName, "STT_302_VIPER"))
	|| (Hlp_StrCmp(npcInstName, "STT_311_FISK"))
	|| (Hlp_StrCmp(npcInstName, "STT_329_DEXTER"))
	|| (Hlp_StrCmp(npcInstName, "STT_335_SANTINO"))
	|| (Hlp_StrCmp(npcInstName, "STT_336_CAVALORN"))
	|| (Hlp_StrCmp(npcInstName, "VLK_538_HUNO"))
	|| (Hlp_StrCmp(npcInstName, "VLK_573_GRAHAM"))
	{
		//50%
		multiplierF = (divf(mkf(5), mkf(10)));
	};

	return multiplierF;
};
