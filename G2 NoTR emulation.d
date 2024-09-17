/*
 *	G1 does not have all functions that G2 NoTR has ...
 *	 - so here we will try to emulate some of them - as they are useful
 */

/*
 *	Function checks if Active spell is scroll (all scrolls should have ITEM_MULTI flag)
 *	G1 does not have this function.
 */
func int Npc_GetActiveSpellIsScroll_G1 (var int slfInstance) {
	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);

	if (!Hlp_IsValidNPC (slf)) { return FALSE; };

	if (slf.fMode != FMODE_MAGIC) { return FALSE; };

	if (!slf.mag_book) { return FALSE; };

	var oCMag_Book magBook;
	magBook = _^ (slf.mag_book);

	if (!magBook.spellitems_array) { return FALSE; };

	var int selectedSpell; selectedSpell = MEM_ReadIntArray (magBook.spellitems_array, magBook.spellnr);

	var oCItem spell; spell = _^ (selectedSpell);

	return (spell.flags & ITEM_MULTI);
};

/*
 *	Function returns TRUE if it is raining
 */
func int Wld_IsRaining_G1 () {
	//this should work :) (for both G1 & G2A)
	return (gf (MEM_SkyController.rainFX_outdoorRainFXWeight, FLOATNULL));
};

/*
 *	Function stops animation + deletes any event message that is still queued in EM
 */
func void Npc_StopAni_G1 (var int slfInstance, var string aniName) {
	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	aniName = STR_Upper (aniName);

	NPC_StopAni_ByAniName (slf, aniName);

	var int eMgr; eMgr = zCVob_GetEM (_@ (slf));

	if (!Hlp_Is_zCEventManager (eMgr)) { return; };

	var int eventTotal; eventTotal = zCEventManager_GetNumMessages (eMgr);

	if (eventTotal == 0) { return; };

	var int eMsg;

	//Loop through Event Messages
	var int i; i = 0;

	while (i < eventTotal);
		eMsg = zCEventManager_GetEventMessage (eMgr, i);

		if (Hlp_Is_oCMsgConversation (eMsg)) {
			if (zCEventMessage_GetSubType (eMsg) == EV_PLAYANI_NOOVERLAY) {
				var oCMsgConversation msg; msg = _^ (eMsg);

				if (Hlp_StrCmp (msg.name, aniName)) {
					zCEventManager_Delete(eMgr, eMsg);
					continue;
				};
			};
		};

		i += 1;
	end;
};
