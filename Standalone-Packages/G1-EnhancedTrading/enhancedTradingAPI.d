/*
 *	Enhanced Trading system
 *
 *	This package improves trading system in G1. It takes care of ore exchange - you don't have care about ore anymore.
 *
 *	It also allows you to:
 *		control what items will trader buy from you
 *		selling price / buying prace
 *
 */

//const string TEXT_TRADE_BUYER_NOTENOUGHORE		= "You don't have enough ore!";
const string TEXT_TRADE_BUYER_NOTENOUGHORE		= "Nemáš dost rudy!";
const int POSY_TRADE_BUYER_NOTENOUGHORE			= _YPOS_MESSAGE_LOGENTRY;

//const string TEXT_TRADE_TRADER_NOTENOUGHORE		= "Trader doesn't have enough ore!";
const string TEXT_TRADE_TRADER_NOTENOUGHORE		= "Obchodník nemá dost rudy!";
const int POSY_TRADE_TRADER_NOTENOUGHORE		= _YPOS_MESSAGE_LOGENTRY;

//const string TEXT_TRADE_TRADER_NOTENOUGHORE_CONFIRM	= "You will loose ore with this trade. Do you really want to accept?";
const string TEXT_TRADE_TRADER_NOTENOUGHORE_CONFIRM	= "Na tomhle obchodu proděláš. Opravdu uskutečnit obchod ?";
const int POSY_TRADE_TRADER_NOTENOUGHORE_CONFIRM	= _YPOS_MESSAGE_XPGAINED;

func void _additionalSubtitlesForTrading () {
	//AI_Output (self, self, "DIA_Trade_NotInterrested");	//I am not interrested
	AI_Output (self, self, "DIA_Trade_NotInterrested");	//Tohle nechci.
};

func string GetText_TradeGiveOre (var int amount) {
	//var string s; s = "x ore taken.";
	var string s; s = "x ruda předána.";
	s = ConcatStrings (IntToString (amount), s);
	return s;
};

func string GetText_ReceiveGiveOre (var int amount) {
	//var string s; s = "x ore given.";
	var string s; s = "x ruda přijata.";
	s = ConcatStrings (IntToString (amount), s);
	return s;
};

func int NPC_WantsToBuyItems (var int slfinstance, var int itemPtr) {
	if (!Hlp_Is_oCItem (itemPtr)) { return FALSE; };

	var oCNPC slf; slf = Hlp_GetNPC (slfinstance);
	if (!Hlp_IsValidNPC (slf)) { return FALSE; };

	var oCItem itm; itm = _^ (itemPtr);

// -->	YOU CAN DEFINE NPC-SPECIFIC RULES HERE

	if (Hlp_GetinstanceID (slf) == ORG_873_Cipher) {
		if (Hlp_GetinstanceID (itm) != ItMi_Plants_Swampherb_01) {

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

func int NPC_GetSellMultiplierF (var int slfinstance, var int itemPtr) {
	var int multiplier;

	//Set by default to 30%
	multiplier = (divf (mkf (3), mkf (10)));

	if (!Hlp_Is_oCItem (itemPtr)) { return multiplier; };

	var oCNPC slf; slf = Hlp_GetNPC (slfinstance);
	if (!Hlp_IsValidNPC (slf)) { return multiplier; };

	var oCItem itm; itm = _^ (itemPtr);

// -->	YOU CAN DEFINE NPC-SPECIFIC TRADE SELLING MULTIPLIER RULES HERE

	//Wolf will trade furs and skins in 1 x 1 ratio
	if (Hlp_GetinstanceID (slf) == ORG_855_Wolf) {
		if (Hlp_GetinstanceID (itm) == Wolf_Skin)
		|| (Hlp_GetinstanceID (itm) == Warg_Skin)
		|| (Hlp_GetinstanceID (itm) == ShadowBeast_Skin)
		|| (Hlp_GetinstanceID (itm) == Troll_Skin)
		|| (Hlp_GetinstanceID (itm) == BlackTroll_Skin)
		|| (Hlp_GetinstanceID (itm) == Lurker_Skin)
		|| (Hlp_GetinstanceID (itm) == Swampshark_Skin)
		{
			multiplier = FLOATONE;
		};
	};

	//Cipher will buy swamp weed in 1 x 1 ratio
	if (Hlp_GetinstanceID (slf) == ORG_873_Cipher) {
		if (Hlp_GetinstanceID (itm) == ItMi_Plants_Swampherb_01)
		{
			multiplier = FLOATONE;
		};
	};

	//
	if (Hlp_GetinstanceID (slf) == NOV_1357_Fortuno) {
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

func int NPC_GetBuyMultiplierF (var int slfinstance, var int itemPtr) {
	var int multiplier;

	//Set by default to 100%
	multiplier = FLOATONE;

	if (!Hlp_Is_oCItem (itemPtr)) { return multiplier; };

	var oCNPC slf; slf = Hlp_GetNPC (slfinstance);
	if (!Hlp_IsValidNPC (slf)) { return multiplier; };


	var oCItem itm; itm = _^ (itemPtr);

// -->	YOU CAN DEFINE NPC-SPECIFIC TRADE BUYING MULTIPLIER RULES HERE

// <--

	return multiplier;
};
