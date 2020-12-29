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

func int zCVob_GetDistanceToVob(var string zCVob_Name, var string zCVob_Name2)
{
	/*var int zCVob_camera;
	zCVob_camera = MEM_Camera.connectedVob;
	
	var zCVob camVob;
    camVob = MEM_PtrToInst (MEM_Camera.connectedVob);
	*/
	var int zCVob_;
	zCVob_ = MEM_SearchAllVobsByName(zCVob_Name);
	var int zCVob2;
	zCVob2 = MEM_SearchAllVobsByName(zCVob_Name2);
	
	var zCVob camVob;
    camVob = MEM_PtrToInst (MEM_Camera.connectedVob);
	MEM_Info(PV("camVob",camVob));
	
	MEM_Info(PV("zCVob_",zCVob_));
	MEM_Info(PV("zCVob2",zCVob2));
	
    //005EE400  .text     Debug data           ?GetDistanceToVob@zCVob@@QAEMAAV1@@Z
    const int zCVob_GetDistanceToVob_G1 = 6218752;
	   
	//0061B910 public: float __thiscall zCVob::GetDistanceToVob(class zCVob &)
    const int zCVob_GetDistanceToVob_G2 = 6404368;
    
    CALL_IntParam(zCVob_); 
    CALL__thiscall (zCVob2, MEMINT_SwitchG1G2 (zCVob_GetDistanceToVob_G1, zCVob_GetDistanceToVob_G2));
	
    return CALL_RetValAsFloat ();
};


































