func void zCLineCache_Line3D (var int fromPosPtr, var int toPosPtr, var int color, var int useZBuffer) {
	//0x004FBA10 public: void __thiscall zCLineCache::Line3D(class zVEC3 const &,class zVEC3 const &,struct zCOLOR,int)
	const int zCLineCache__Line3D_G1 = 5224976;

	//0x0050B450 public: void __thiscall zCLineCache::Line3D(class zVEC3 const &,class zVEC3 const &,struct zCOLOR,int)
	const int zCLineCache__Line3D_G2 = 5289040;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_IntParam(_@(useZBuffer));
		CALL_IntParam(_@(color));   // zCOLOR
		CALL_PtrParam(_@(toPosPtr)); // zVEC3*
		CALL_PtrParam(_@(fromPosPtr)); // zVEC3*
		CALL__thiscall(_@(zlineCache), MEMINT_SwitchG1G2 (zCLineCache__Line3D_G1, zCLineCache__Line3D_G2));
		call = CALL_End();
	};
};
