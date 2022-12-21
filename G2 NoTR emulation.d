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
