/*
//Enhanced Trading system
//This package improves trading system in G1. It takes care of ore exchange - you don't have care about ore anymore.
//It also allows you to:
// - control what items will trader buy from you
// - selling price / buying prace

const string ENHANCEDTRADING_FONT = "FONT_OLD_20_WHITE.TGA";

func void EnhancedTrading_NotEnoughOre () {
	PrintScreen ("You don't have enough ore!", -1, 45, ENHANCEDTRADING_FONT, _TIME_MESSAGE_LOGENTRY);
};

func void EnhancedTrading_Trader_NotEnoughOre () {
	PrintScreen ("Trader doesn't have enough ore!", -1, 45, ENHANCEDTRADING_FONT, _TIME_MESSAGE_LOGENTRY);
};

func void EnhancedTrading_Trader_NotEnoughOre_Confirm () {
	PrintScreen ("You will loose ore with this trade. Do you really want to accept?", -1, 45, ENHANCEDTRADING_FONT, _TIME_MESSAGE_LOGENTRY);
};

func void Subtitles_ForTrading () {
	AI_Output (self, self, "DIA_Trade_NotInterrested");	//I am not interrested
};

func int C_Npc_WantsToBuyItems (var C_NPC slf, var int itemPtr) {
	if (!Hlp_Is_oCItem (itemPtr)) { return FALSE; };
	var oCItem itm; itm = _^ (itemPtr);

// -->	YOU CAN DEFINE NPC-SPECIFIC RULES HERE

	var string npcInstName; npcInstName = GetSymbolName (Hlp_GetInstanceID (slf));
	var string itmInstName; itmInstName = GetSymbolName (Hlp_GetInstanceID (itm));

	if (Hlp_StrCmp (npcInstName, "ORG_873_CIPHER")) {
		if (!Hlp_StrCmp (itmInstName, "ITMI_PLANTS_SWAMPHERB_01")) {

			//Check how many EV_PLAYANI_NOOVERLAY events we have in AI queue. If none - then play T_NO animation and say that we are not interrested.
			//This will add to Event Manager event: EV_PLAYANI_NOOVERLAY.
			if (NPC_EM_GetEventCountByEventName (slf, "EV_PLAYANI_NOOVERLAY") == 0)
			{
				MEM_PushInstParam (slf);
				MEM_PushInstParam (hero);
				MEM_PushStringParam ("DIA_Trade_NotInterrested");
				MEM_Call (B_SayOverlay);

				AI_PlayAni (slf, "T_NO");
			};

			return FALSE;
		};
	};

// <--

	return TRUE;
};

func int C_Npc_GetSellMultiplierF (var C_NPC slf, var int itemPtr) {
	var int multiplier;

	//Set by default to 30%
	multiplier = (divf (mkf (3), mkf (10)));

	if (!Hlp_Is_oCItem (itemPtr)) { return multiplier; };

	var oCItem itm; itm = _^ (itemPtr);

// -->	YOU CAN DEFINE NPC-SPECIFIC TRADE SELLING MULTIPLIER RULES HERE

	var string npcInstName; npcInstName = GetSymbolName (Hlp_GetInstanceID (slf));
	var string itmInstName; itmInstName = GetSymbolName (Hlp_GetInstanceID (itm));

	//Wolf will trade furs and skins in 1 x 1 ratio
	if (Hlp_StrCmp (npcInstName, "ORG_855_WOLF")) {
		if ((Hlp_StrCmp (itmInstName, "WOLF_SKIN"))
		|| (Hlp_StrCmp (itmInstName, "WARG_SKIN"))
		|| (Hlp_StrCmp (itmInstName, "SHADOWBEAST_SKIN"))
		|| (Hlp_StrCmp (itmInstName, "TROLL_SKIN"))
		|| (Hlp_StrCmp (itmInstName, "BLACKTROLL_SKIN"))
		|| (Hlp_StrCmp (itmInstName, "LURKER_SKIN"))
		|| (Hlp_StrCmp (itmInstName, "SWAMPSHARK_SKIN"))

		|| (Hlp_StrCmp (itmInstName, "ITAT_WOLF_01")))
		{
			multiplier = FLOATONE;
		};
	};

	//Cipher will buy swamp weed in 1 x 1 ratio
	if (Hlp_StrCmp (npcInstName, "ORG_873_CIPHER")) {
		if (Hlp_StrCmp (itmInstName, "ITMI_PLANTS_SWAMPHERB_01"))
		{
			multiplier = FLOATONE;
		};
	};

	//
	if (Hlp_StrCmp (npcInstName, "NOV_1357_FORTUNO")) {
	};

	//ARMOR - set to 100%
	if (itm.mainflag & ITEM_KAT_ARMOR)
	{
		multiplier = FLOATONE;
	};

	//WEAPONS - set to 10%
	if (itm.mainflag & ITEM_KAT_NF)
	|| (itm.mainflag & ITEM_KAT_FF)
	{
		multiplier = (divf (mkf (1), mkf (10)));
	};

// <--

	return multiplier;
};

func int C_Npc_GetBuyMultiplierF (var C_NPC slf, var int itemPtr) {
	var int multiplier;

	//Set by default to 100%
	multiplier = FLOATONE;

	if (!Hlp_Is_oCItem (itemPtr)) { return multiplier; };

	var oCItem itm; itm = _^ (itemPtr);

// -->	YOU CAN DEFINE NPC-SPECIFIC TRADE BUYING MULTIPLIER RULES HERE

// <--

	return multiplier;
};
*/
