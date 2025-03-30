/*
 *	zCOption_Load
 */
func int zCOption_Load(var int ptr, var string fileName) {
	//0x0045B240 public: int __thiscall zCOption::Load(class zSTRING)
	const int zCOption__Load_G1 = 4567616;

	//0x004607B0 public: int __thiscall zCOption::Load(class zSTRING)
	const int zCOption__Load_G2 = 4589488;

	if (!ptr) { return 0; };

	var int retVal;
	CALL_PutRetValTo(_@(retVal));
	CALL_StructParam(_@s(fileName), sizeof_zString / 4);
	CALL__thiscall(ptr, MEMINT_SwitchG1G2(zCOption__Load_G1, zCOption__Load_G2));

	return + retVal;
};

/*
 *	zCOption_Save
 */
func int zCOption_Save(var int ptr, var string fileName) {
	//0x0045C1E0 public: int __thiscall zCOption::Save(class zSTRING)
	const int zCOption__Save_G1 = 4571616;

	//0x004616C0 public: int __thiscall zCOption::Save(class zSTRING)
	const int zCOption__Save_G2 = 4593344;

	if (!ptr) { return FALSE; };

	var int retVal;

	CALL_PutRetValTo(_@(retVal));
	CALL_StructParam(_@s(fileName), sizeof_zString / 4);
	CALL__thiscall(ptr, MEMINT_SwitchG1G2(zCOption__Save_G1, zCOption__Save_G2));

	return + retVal;
};

func string zCOption_GetOption(var int ptr, var string searchSecName, var string searchVarName) {
	var zCOption option;
	var zCOptionSection optionSection;
	var zCOptionEntry optionEntry;

	if (!ptr) { return STR_EMPTY; };

	option = _^(ptr);

	repeat(i, option.sectionList_numInArray); var int i;
		ptr = MEM_ReadIntArray(option.sectionList_array, i);
		optionSection = _^(ptr);

		if (Hlp_StrCmp(optionSection.secName, searchSecName)) {
			repeat(j, optionSection.entryList_numInArray); var int j;
				ptr = MEM_ReadIntArray(optionSection.entryList_array, j);
				optionEntry = _^(ptr);

				if (Hlp_StrCmp(optionEntry.varName, searchVarName)) {
					return optionEntry.varValue;
				};
			end;
		};
	end;

	return STR_EMPTY;
};

func void zCOption_SetOption(var int ptr, var string searchSecName, var string searchVarName, var string newValue) {
	var zCOption option;
	var zCOptionSection optionSection;
	var zCOptionEntry optionEntry;

	if (!ptr) { return; };

	option = _^(ptr);

	repeat(i, option.sectionList_numInArray); var int i;
		ptr = MEM_ReadIntArray(option.sectionList_array, i);
		optionSection = _^(ptr);

		if (Hlp_StrCmp(optionSection.secName, searchSecName)) {
			repeat(j, optionSection.entryList_numInArray); var int j;
				ptr = MEM_ReadIntArray(optionSection.entryList_array, j);
				optionEntry = _^(ptr);

				if (Hlp_StrCmp(optionEntry.varName, searchVarName)) {
					optionEntry.varValue = newValue;
					return;
				};
			end;
		};
	end;
};
