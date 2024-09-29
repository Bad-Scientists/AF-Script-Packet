/*
 *	oCNpc_MakeSpellBook
 *	 - creates magbook (if Npc is inserted into the world with ATR_MANA_MAX == 0 - magbook won't be created)
 */
func void oCNpc_MakeSpellBook (var int slfInstance) {
	//0x006B86A0 public: void __thiscall oCNpc::MakeSpellBook(void)
	const int oCNpc__MakeSpellBook_G1 = 7046816;

	//0x0075F040 public: void __thiscall oCNpc::MakeSpellBook(void)
	const int oCNpc__MakeSpellBook_G2 = 7729216;

	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	var int slfPtr; slfPtr = _@ (slf);

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2 (oCNpc__MakeSpellBook_G1, oCNpc__MakeSpellBook_G2));
		call = CALL_End();
	};
};

/*
 *	oCMag_Book_DeRegister
 *	 - deregisters spell from magbook
 */
func void oCMag_Book_DeRegister (var int magBookPtr, var int index) {
	//0x0046F1C0 public: int __thiscall oCMag_Book::DeRegister(int)
	const int oCMag_Book__DeRegister_G1 = 4649408;

	//0x00475DA0 public: int __thiscall oCMag_Book::DeRegister(int)
	const int oCMag_Book__DeRegister_G2 = 4677024;

	if (!magBookPtr) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_IntParam(_@(index));
		CALL__thiscall (_@ (magBookPtr), MEMINT_SwitchG1G2 (oCMag_Book__DeRegister_G1, oCMag_Book__DeRegister_G2));
		call = CALL_End();
	};
};

/*
 *	oCNpc_DestroySpellBook
 *	 - destroys magbook
 */
func void oCNpc_DestroySpellBook (var int slfInstance) {
	//0x006B8730 public: void __thiscall oCNpc::DestroySpellBook(void)
	const int oCNpc__DestroySpellBook_G1 = 7046960;

	//0x0075F0C0 public: void __thiscall oCNpc::DestroySpellBook(void)
	const int oCNpc__DestroySpellBook_G2 = 7729344;

	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	if (!slf.mag_book) { return; };

	//Deregister all spells first
	var oCMag_Book magBook; magBook = _^(slf.mag_book);
	repeat(i, magBook.spellitems_numInArray); var int i;
		oCMag_Book_DeRegister(slf.mag_book, i);
	end;

	var int slfPtr; slfPtr = _@ (slf);

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2 (oCNpc__DestroySpellBook_G1, oCNpc__DestroySpellBook_G2));
		call = CALL_End();
	};
};

/*
 *	oCNpc_GetSpellBook
 *	 - returns magbook
 */
func int oCNpc_GetSpellBook (var int slfInstance) {
	//0x0069B3C0 public: class oCMag_Book * __thiscall oCNpc::GetSpellBook(void)
	const int oCNpc__GetSpellBook_G1 = 6927296;

	//0x0073EA00 public: class oCMag_Book * __thiscall oCNpc::GetSpellBook(void)
	const int oCNpc__GetSpellBook_G2 = 7596544;

	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return 0; };

	var int retVal;
	var int slfPtr; slfPtr = _@ (slf);

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PutRetValTo (_@ (retVal));
		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2 (oCNpc__GetSpellBook_G1, oCNpc__GetSpellBook_G2));
		call = CALL_End();
	};

	return + retVal;
};

/*
 *	oCMag_Book_SetShowHandSymbol
 */
func void oCMag_Book_SetShowHandSymbol (var int magBookPtr, var int show_handsymbol) {
	//0x00472310 public: void __thiscall oCMag_Book::SetShowHandSymbol(int)
	const int oCMag_Book__SetShowHandSymbol_G1 = 4662032;

	//0x00478FD0 public: void __thiscall oCMag_Book::SetShowHandSymbol(int)
	const int oCMag_Book__SetShowHandSymbol_G2 = 4689872;

	if (!magBookPtr) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_IntParam(_@(show_handsymbol));
		CALL__thiscall (_@ (magBookPtr), MEMINT_SwitchG1G2 (oCMag_Book__SetShowHandSymbol_G1, oCMag_Book__SetShowHandSymbol_G2));
		call = CALL_End();
	};
};

/*
 *	oCMag_Book_DoPerFrame
 */
func void oCMag_Book_DoPerFrame (var int magBookPtr) {
	//Do per frame
	//0x00472670 public: void __thiscall oCMag_Book::DoPerFrame(void)
	const int oCMag_Book__DoPerFrame_G1 = 4662896;

	//0x00479330 public: void __thiscall oCMag_Book::DoPerFrame(void)
	const int oCMag_Book__DoPerFrame_G2 = 4690736;

	if (!magBookPtr) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (magBookPtr), MEMINT_SwitchG1G2 (oCMag_Book__DoPerFrame_G1, oCMag_Book__DoPerFrame_G2));
		call = CALL_End();
	};
};

/*
 *	oCMag_Book_GetSelectedSpell
 *	 - returns currently selected spell
 */
func int oCMag_Book_GetSelectedSpell (var int magBookPtr) {
	//0x00470AC0 public: class oCSpell * __thiscall oCMag_Book::GetSelectedSpell(void)
	const int oCMag_Book__GetSelectedSpell_G1 = 4655808;

	//0x00477780 public: class oCSpell * __thiscall oCMag_Book::GetSelectedSpell(void)
	const int oCMag_Book__GetSelectedSpell_G2 = 4683648;

	if (!magBookPtr) { return 0; };

	var int retVal;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PutRetValTo (_@ (retVal));
		CALL__thiscall (_@ (magBookPtr), MEMINT_SwitchG1G2 (oCMag_Book__GetSelectedSpell_G1, oCMag_Book__GetSelectedSpell_G2));
		call = CALL_End();
	};

	return + retVal;
};

/*
 *	oCMag_Book_GetSelectedSpellNr
 */
func int oCMag_Book_GetSelectedSpellNr (var int magBookPtr) {
	//0x00470B10 public: int __thiscall oCMag_Book::GetSelectedSpellNr(void)
	const int oCMag_Book__GetSelectedSpellNr_G1 = 4655888;

	//0x004777D0 public: int __thiscall oCMag_Book::GetSelectedSpellNr(void)
	const int oCMag_Book__GetSelectedSpellNr_G2 = 4683728;

	if (!magBookPtr) { return 0; };

	var int retVal;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PutRetValTo (_@ (retVal));
		CALL__thiscall (_@ (magBookPtr), MEMINT_SwitchG1G2 (oCMag_Book__GetSelectedSpellNr_G1, oCMag_Book__GetSelectedSpellNr_G2));
		call = CALL_End();
	};

	return + retVal;
};

/*
 *	oCSpell_GetSpellID
 */
func int oCSpell_GetSpellID (var int spellPtr) {
	//0x0047E180 public: int __thiscall oCSpell::GetSpellID(void)
	const int oCSpell__GetSpellID_G1 = 4710784;

	//0x00486480 public: int __thiscall oCSpell::GetSpellID(void)
	const int oCSpell__GetSpellID_G2 = 4744320;

	if (!spellPtr) { return -1; };

	var int retVal;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PutRetValTo (_@ (retVal));
		CALL__thiscall (_@ (spellPtr), MEMINT_SwitchG1G2 (oCSpell__GetSpellID_G1, oCSpell__GetSpellID_G2));
		call = CALL_End();
	};

	return + retVal;
};

/*
 *	oCMag_Book_GetSelectedSpellID
 */
func int oCMag_Book_GetSelectedSpellID (var int magBookPtr) {
	var int spellPtr; spellPtr = oCMag_Book_GetSelectedSpell(magBookPtr);
	return + oCSpell_GetSpellID(spellPtr);
};

/*
 *	oCMag_Book_GetSpell_ByIndex
 */
func int oCMag_Book_GetSpell_ByIndex (var int magBookPtr, var int index) {
	//0x00472E00 public: class oCSpell * __thiscall oCMag_Book::GetSpell(int)
	const int oCMag_Book__GetSpell_G1 = 4664832;

	//0x00479BC0 public: class oCSpell * __thiscall oCMag_Book::GetSpell(int)
	const int oCMag_Book__GetSpell_G2 = 4692928;

	if (!magBookPtr) { return 0; };

	var int retVal;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PutRetValTo (_@ (retVal));
		CALL_IntParam(_@(index));
		CALL__thiscall (_@ (magBookPtr), MEMINT_SwitchG1G2 (oCMag_Book__GetSpell_G1, oCMag_Book__GetSpell_G2));
		call = CALL_End();
	};

	return + retVal;
};

/*
 *	oCMag_Book_GetSpellID_ByIndex
 */
func int oCMag_Book_GetSpellID_ByIndex (var int magBookPtr, var int index) {
	var int spellPtr; spellPtr = oCMag_Book_GetSpell_ByIndex(magBookPtr, index);
	return + oCSpell_GetSpellID(spellPtr);
};

/*
 *	oCSpell_GetSpellStatus
 *	 - returns spell status
 */
func int oCSpell_GetSpellStatus (var int spellPtr) {
	//0x0047E390 public: int __thiscall oCSpell::GetSpellStatus(void)
	const int oCSpell__GetSpellStatus_G1 = 4711312;

	//0x00486660 public: int __thiscall oCSpell::GetSpellStatus(void)
	const int oCSpell__GetSpellStatus_G2 = 4744800;

	if (!spellPtr) { return -1; };

	var int retVal;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PutRetValTo (_@ (retVal));
		CALL__thiscall (_@ (spellPtr), MEMINT_SwitchG1G2 (oCSpell__GetSpellStatus_G1, oCSpell__GetSpellStatus_G2));
		call = CALL_End();
	};

	return + retVal;
};

/*
 *	Npc_GetManaInvested
 *	 - returns so far invested mana
 */
func int Npc_GetManaInvested (var int slfInstance) {
	var oCNpc slf; slf = Hlp_GetNpc (slfInstance);

	var int magBookPtr; magBookPtr = oCNpc_GetSpellBook (slf);
	var int spellPtr; spellPtr = oCMag_Book_GetSelectedSpell (magBookPtr);

	if (spellPtr) {
		var oCSpell spell; spell = _^ (spellPtr);
		return slf.spellMana + spell.manaInvested;
	};

	return slf.spellMana;
};

/*
 *	Spell_GetInstanceName
 *	 - function reads spell instance name from array spellFXInstanceNames
 */
func string Spell_GetInstanceName (var int spellID) {
	var string instanceName; instanceName = STR_EMPTY;

	if ((spellID >= 0) && (spellID < MAX_SPELL)) {
		instanceName = MEM_ReadStatStringArr (spellFXInstanceNames, spellID);
	};

	return instanceName;
};

/*
 *	Spell_GetSpellType
 *	 - function returns spellType value based on spellID
 */
func int Spell_GetSpellType (var int spellID) {
	var C_Spell spell;
	var int spellType; spellType = -1;

	var string instanceName;

	instanceName = Spell_GetInstanceName (spellID);
	instanceName = ConcatStrings ("SPELL_", instanceName);

	var int symbID; symbID = MEM_GetSymbolIndex (instanceName);
	if (symbID != -1) {
		//Create instance temporarily
		var int ptr; ptr = create(symbID);

		spell = _^ (ptr);
		spellType = spell.spellType;

		free(ptr, symbID);
	};

	return + spellType;
};

/*
 *	oCMag_Book_Register
 *	 - registers spell
 */
func int oCMag_Book_Register (var int magBookPtr, var int spellNo, var int active) {
	//0x0046F410 public: int __thiscall oCMag_Book::Register(int,int)
	const int oCMag_Book__Register_G1 = 4650000;

	//0x00475FE0 public: int __thiscall oCMag_Book::Register(int,int)
	const int oCMag_Book__Register_G2 = 4677600;

	if (!magBookPtr) { return 0; };

	var int retVal;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PutRetValTo (_@ (retVal));
		CALL_IntParam (_@ (active));
		CALL_IntParam (_@ (spellNo));
		CALL__thiscall (_@ (magBookPtr), MEMINT_SwitchG1G2 (oCMag_Book__Register_G1, oCMag_Book__Register_G2));
		call = CALL_End();
	};

	return + retVal;
};

/*
 *	oCMag_Book_RegisterByItemPtr
 *	 - registers spell using item pointer
 */
func int oCMag_Book_RegisterByItemPtr (var int magBookPtr, var int itemPtr, var int active) {
	//0x0046EFD0 public: int __thiscall oCMag_Book::Register(class oCItem *,int)
	const int oCMag_Book__Register_G1 = 4648912;

	//0x00475BB0 public: int __thiscall oCMag_Book::Register(class oCItem *,int)
	const int oCMag_Book__Register_G2 = 4676528;

	if (!itemPtr) { return 0; };
	if (!magBookPtr) { return 0; };

	var int retVal;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PutRetValTo (_@ (retVal));
		CALL_IntParam (_@ (active));
		CALL_IntParam (_@ (itemPtr));
		CALL__thiscall (_@ (magBookPtr), MEMINT_SwitchG1G2 (oCMag_Book__Register_G1, oCMag_Book__Register_G2));
		call = CALL_End();
	};

	return + retVal;
};

/*
 *	oCMag_Book_RegisterBySpellPtr
 *	 - registers spell using item pointer
 */
func int oCMag_Book_RegisterBySpellPtr (var int magBookPtr, var int spellPtr, var int active) {
	//0x0046EED0 private: int __thiscall oCMag_Book::Register(class oCSpell *,int)
	const int oCMag_Book__Register_G1 = 4648656;

	//0x00475AD0 private: int __thiscall oCMag_Book::Register(class oCSpell *,int)
	const int oCMag_Book__Register_G2 = 4676304;

	if (!spellPtr) { return 0; };
	if (!magBookPtr) { return 0; };

	var int retVal;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PutRetValTo (_@ (retVal));
		CALL_IntParam (_@ (active));
		CALL_IntParam (_@ (spellPtr));
		CALL__thiscall (_@ (magBookPtr), MEMINT_SwitchG1G2 (oCMag_Book__Register_G1, oCMag_Book__Register_G2));
		call = CALL_End();
	};

	return + retVal;
};

/*
 *	oCMag_Book_CreateNewSpell
 *	 - returns magbook
 */
func int oCMag_Book_CreateNewSpell (var int magBookPtr, var int spellID) {
	//0x0046F270 public: class oCSpell * __thiscall oCMag_Book::CreateNewSpell(int)
	const int oCMag_Book__CreateNewSpell_G1 = 4649584;

	//0x00475E50 public: class oCSpell * __thiscall oCMag_Book::CreateNewSpell(int)
	const int oCMag_Book__CreateNewSpell_G2 = 4677200;

	if (!magBookPtr) { return 0; };

	var int retVal;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PutRetValTo (_@ (retVal));
		CALL_IntParam(_@(spellID));
		CALL__thiscall (_@ (magBookPtr), MEMINT_SwitchG1G2 (oCMag_Book__CreateNewSpell_G1, oCMag_Book__CreateNewSpell_G2));
		call = CALL_End();
	};

	return + retVal;
};

/*
 *	oCMag_Book_RegisterByItemPtr_NoHotkey
 *	 - registers spell using item pointer
 *	 - this one is however not limited by available hotkeys - it will allow us to register to mag book as many spells as we want
 */
func int oCMag_Book_RegisterByItemPtr_NoHotkey (var int magBookPtr, var int itemPtr, var int active) {
	if (!itemPtr) { return 0; };
	if (!magBookPtr) { return 0; };

	//Create spell
	var oCItem itm; itm = _^(itemPtr);
	var int spellPtr; spellPtr = oCMag_Book_CreateNewSpell(magBookPtr, itm.spell);

	//Register spell
	if (!oCMag_Book_RegisterBySpellPtr(magBookPtr, spellPtr, 1)) {
		return FALSE;
	};

	//Insert item reference to array
	var oCMag_Book magBook; magBook = _^(magBookPtr);
	MEM_ArrayInsert(_@(magBook.spellitems_array), itemPtr);

	//No hotkey
	var oCSpell spell; spell = _^(spellPtr);
	spell.keyNo = 0;

	return TRUE;
};

/*
 *	oCNpc_GetMagBook
 *	 - returns oCMag_Book (creates one if it does not exist)
 */
func int oCNpc_GetMagBook (var int slfInstance) {
	//Create magbook if it does not exist
	if (!oCNpc_GetSpellBook (slfInstance)) {
		oCNpc_MakeSpellBook (slfInstance);
	};

	return + oCNpc_GetSpellBook (slfInstance);
};

/*
 *	oCSpell_CastSpecificSpell
 *	 - casts specific spells --> this function handles casting of light, control and transformation spells
 *	 - function returns FALSE if successfull ! :)
 */
func int oCSpell_CastSpecificSpell (var int spellPtr) {
	//0x0047EC70 public: int __thiscall oCSpell::CastSpecificSpell(void)
	const int oCSpell__CastSpecificSpell_G1 = 4713584;

	//0x00486960 public: int __thiscall oCSpell::CastSpecificSpell(void)
	const int oCSpell__CastSpecificSpell_G2 = 4745568;

	var int retVal;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PutRetValTo (_@ (retVal));
		CALL__thiscall (_@ (spellPtr), MEMINT_SwitchG1G2 (oCSpell__CastSpecificSpell_G1, oCSpell__CastSpecificSpell_G2));
		call = CALL_End();
	};

	return + retVal;
};

/*
 *	Npc_SpellTransformTo
 */
func int Npc_SpellTransformTo (var int slfInstance, var int instanceID) {
	var oCNpc slf; slf = Hlp_GetNpc (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return FALSE; };

	if (instanceID == -1) { return FALSE; };

	//Wrapper function creates magbook if needed
	if (!oCNpc_GetMagBook (slf)) {
		return FALSE;
	};

	//Transformation spell IDs are hardcoded in engine ...
	//const int SPL_TRF_BLOODFLY = 26; G1
	//const int SPL_TRFSHEEP = 47; G2A

	//Create default transformation spell
	var int spellPtr; spellPtr = oCSpell_Create (MEMINT_SwitchG1G2 (26, 47));
	if (!spellPtr) { return FALSE; };

	//Setup spell
	var oCSpell spell; spell = _^ (spellPtr);
	//Caster is slf
	spell.spellCasterNpc = _@ (slf);
	//spellInfo is npc ID
	spell.spellInfo = instanceID;

	//Play transformation spell effects
	Snd_Play("MFX_TRANSFORM_CAST");
	Wld_PlayEffect ("SPELLFX_TRANSFORM_BLEND", slf, slf, 0, 0, 0, FALSE);

	//Function returns FALSE if spell was casted properly - thus negate
	return !oCSpell_CastSpecificSpell (spellPtr);
};

/*
 *	Npc_HasActiveSpellID
 *	 - function checks if specified spellID is in activeSpells
 */
func int Npc_HasActiveSpellID (var int slfInstance, var int spellID) {
	var oCNpc slf; slf = Hlp_GetNpc(slfInstance);
	if (!Hlp_IsValidNpc(slf)) { return FALSE; };

	var int ptr; ptr = slf.activeSpells_next;

	var zCList l;

	while (ptr);
		l = _^ (ptr);
		if (l.data) {
			var oCSpell spell; spell = _^ (l.data);
			if (spell.spellID == spellID) {
				return TRUE;
			};
		};

		ptr = l.next;
	end;

	return FALSE;
};

/*
 *	oCVisualFX_SetSpellType
 *	 - updates spell ID for vfx effect
 */
func void oCVisualFX_SetSpellType (var int vfxPtr, var int spellID) {
	//0x00482750 public: virtual void __thiscall oCVisualFX::SetSpellType(int)
	const int oCVisualFX__SetSpellType_G1 = 4728656;

	//0x0048A170 public: virtual void __thiscall oCVisualFX::SetSpellType(int)
	const int oCVisualFX__SetSpellType_G2 = 4759920;

	if (!Hlp_Is_oCVisualFX (vfxPtr)) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PtrParam (_@ (spellID));
		CALL__thiscall (_@ (vfxPtr), MEMINT_SwitchG1G2 (oCVisualFX__SetSpellType_G1, oCVisualFX__SetSpellType_G2));
		call = CALL_End();
	};
};

/*
 *	Wld_PlayEffect_Ext
 *	 - same as Wld_PlayEffect ... but it also setups spell ID! Thus B_AssessMagic will be called properly (in G2 NOTR) for Npc 'hit' by played effect
 */
func void Wld_PlayEffect_Ext (var string effectName, var int originPtr, var int targetPtr, var int effectLevel, var int damage, var int damageType, var int bIsProjectile, var int spellID) {
	//Wld_PlayEffect requires instances, thus using pointers in order to be compatible with zCVobs and oCNpcs
	var zCVob originVob; originVob = _^ (originPtr);
	var zCVob targetVob; targetVob = _^ (targetPtr);

	Wld_PlayEffect (effectName, originVob, targetVob, effectLevel, damage, damageType, bIsProjectile);

	var zCTree newTreeNode; newTreeNode = _^ (MEM_World.globalVobTree_firstChild);
	var int vfxPtr; vfxPtr = newTreeNode.data;

	oCVisualFX_SetSpellType (vfxPtr, spellID);
};
