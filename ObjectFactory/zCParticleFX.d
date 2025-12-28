/*
 *	Create object
 */
func int zCParticleFX_New() {
	var int ptr; ptr = CreateNewInstanceByString("zCParticleFX");
	return ptr;
};

func int zCParticleFX_Create(var string emitterName) {
	var int ptr; ptr = zCParticleFX_New();

	if (!ptr) { return 0; };

	//0x0058D1D0 public: __thiscall zCParticleFX::zCParticleFX(void)
	const int zCParticleFX__zCParticleFX_G1 = 5820880;

	//0x005ACF70 public: __thiscall zCParticleFX::zCParticleFX(void)
	const int zCParticleFX__zCParticleFX_G2 = 5951344;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall(_@(ptr), MEMINT_SwitchG1G2(zCParticleFX__zCParticleFX_G1, zCParticleFX__zCParticleFX_G2));
		call = CALL_End();
	};

	//0x0058ED00 public: int __thiscall zCParticleFX::SetAndStartEmitter(class zSTRING const &,int)
	const int zCParticleFX__SetAndStartEmitter_G1 = 5827840;

	//0x005AED40 public: int __thiscall zCParticleFX::SetAndStartEmitter(class zSTRING const &,int)
	const int zCParticleFX__SetAndStartEmitter_G2 = 5958976;

	var int retVal;

	var int createCopy; createCopy = TRUE;

	CALL_PutRetValTo(_@(retVal));
	CALL_IntParam(createCopy);
	CALL_zStringPtrParam(emitterName);
	CALL__thiscall(ptr, MEMINT_SwitchG1G2(zCParticleFX__SetAndStartEmitter_G1, zCParticleFX__SetAndStartEmitter_G2));

	const int bitfield_zCParticleFX_dontKillPFXWhenDone = 2;

	var zCParticleFX pfx; pfx = _^(ptr);
	pfx.bitfield = pfx.bitfield | bitfield_zCParticleFX_dontKillPFXWhenDone;

/*
	//0x0058EDB0 public: static class zCParticleFX * __cdecl zCParticleFX::Load(class zSTRING const &)
	CALL_PutRetValTo(_@(ptr));
	const int zCParticleFX__Load_G1 = 5828016;

	CALL_zStringPtrParam(emitterName);
	CALL__cdecl(MEMINT_SwitchG1G2(zCParticleFX__Load_G1, 0));
*/

	return +ptr;
};
