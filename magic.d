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
	var string instanceName; instanceName = "";

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
