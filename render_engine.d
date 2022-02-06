// Render functions

/*

0x0061B910 public: float __thiscall zCVob::GetDistanceToVob(class zCVob &)
0x0061B970 public: float __thiscall zCVob::GetDistanceToVobApprox(class zCVob &)
0x0061BA40 public: float __thiscall zCVob::GetDistanceToVob2(class zCVob &)


0x004BE400 public: static class zCVob * __cdecl zCCSCamera::GetPlayerVob(void)


*/

/*
https://github.com/ataulien/GD3D11/blob/master/D3D11Engine/zTypes.h
struct zTRenderContext
{
	int ClipFlags;			//clip flags - No idea
	zCVob *Vob;				// zCVob ptr - Vob that we want to render??
	zCWorld* world;			// zCWorld ptr -
	zCCamera* cam;			// zCCamera ptr -
	float distVobToCam;		// distance to camera, so the vob renders at the correct size??

	// More not needed stuff here
};
*/

FUNC INT zcVob_Render (var int vobPtr, var int renderContext)
{
	//005D6090  .text     Debug data           ?Render@zCVob@@UAIHAAUzTRenderContext@@@Z
	const int zcVob__Render_G1 = 6119568;

	//0x006015D0 public: virtual int __fastcall zCVob::Render(struct zTRenderContext &)
	const int zcVob__Render_G2 = 6297040;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__fastcall(_@(vobPtr), _@(renderContext), MEMINT_SwitchG1G2 (zcVob__Render_G1, zcVob__Render_G2));
		call = CALL_End();
	};

	return CALL_RetValAsInt();
};
