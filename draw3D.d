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

func void zTBBox3D_Draw (var int bboxPtr, var int color) {
	//0x00531E90 public: void __thiscall zTBBox3D::Draw(struct zCOLOR const &)const
	const int zTBBox3D__Draw_G1 = 5447312;

	//0x00545EE0 public: void __thiscall zTBBox3D::Draw(struct zCOLOR const &)const
	const int zTBBox3D__Draw_G2 = 5529312;

	const int colorPtr = 0;

	if (!colorPtr) {
		colorPtr = MEM_Alloc (4);
	};

	MEM_WriteInt (colorPtr, color);

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PtrParam(_@(colorPtr));
		CALL__thiscall(_@(bboxPtr), MEMINT_SwitchG1G2 (zTBBox3D__Draw_G1, zTBBox3D__Draw_G2));
		call = CALL_End();
	};
};
