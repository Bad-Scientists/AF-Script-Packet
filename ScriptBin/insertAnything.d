/*
 *	Author: szapp (mud-freak)
 *	Original post: https://forum.worldofplayers.de/forum/threads/1495001-Scriptsammlung-ScriptBin/page2?p=25712257&viewfull=1#post25712257
 */

/*
 * Insert Anything
 * Create and insert any kind of object inheriting from the zCVob class in real time.
 *
 *
 * The core function behind this is
 *
 *    func int InsertObject(string class, string objName, string visual, int trafoPtr, int parentVobPtr)
 *
 * However, for the most common object classes there are specific functions with simpler signature for inserting at
 *  - way points                                                           (functions with "WP" postfix)
 *  - exact coordinates with optionally specifying the direction           (functions with "Pos" postfix)
 *  - aligned at a full trafo-matrix                                       (functions without postfix)
 *
 * Additionally, the objects may be inserted as child vobs of other vobs.  (functions with "AsChild" postfix)
 * Objects inheriting from the oCMob class can then be further adjusted with additional functions listed below.
 *
 *    [A] = {Vob,Mob,MobInter,MobLockable,MobContainer,MobDoor,MobFire}
 *
 *    func int  Insert[A]WP         (string objName, string visual, string waypoint)
 *    func int  Insert[A]Pos        (string objName, string visual, int posPtr, int dirPtr)
 *    func int  Insert[A]           (string objName, string visual, int trafoPtr)
 *
 *    func int  Insert[A]AsChildWP  (string objName, string visual, string waypoint,        int parentVobPtr)
 *    func int  Insert[A]AsChildPos (string objName, string visual, int posPtr, int dirPtr, int parentVobPtr)
 *    func int  Insert[A]AsChild    (string objName, string visual, int trafoPtr,           int parentVobPtr)
 *
 *
 *    [B] = {Trigger,TriggerScript,TriggerChangeLevel}
 *
 *    func int  Insert[B]Pos        (string objName, int posPtr, int dirPtr)
 *    func int  Insert[B]           (string objName, int trafoPtr)
 *
 *    func int  InsertMoverPos      (string objName, string visual, int posPtr, int dirPtr)
 *    func int  InsertMover         (string objName, string visual, int trafoPtr)
 *
 *    func int  InsertItemWP        (string scriptInst, int amount, string waypoint)
 *    func int  InsertItemPos       (string scriptInst, int amount, int posPtr, int dirPtr)
 *    func int  InsertItem          (string scriptInst, int amount, int trafoPtr)
 *
 *    func void InsertPileOfVobs    (string objName, string visual, int trafoPtr, int amount, int cm2, int rotate)
 *    func void InsertPileOfItems   (string scriptInst,             int trafoPtr, int amount, int cm2, int rotate)
 *
 *
 *  Additional functions (not all functions are mentioned here)
 *
 *    func void SetVobToFloor       (int vobPtr)
 *    func void SetWPToFloor        (int wpPtr)
 *
 *
 *  Further mob setter-functions
 *
 *    func int  SetMobName          (int mobPtr, string symbolicFocusName)
 *    func void SetMobMisc          (int mobPtr, string triggerTarget, string useWithItem, string onStateFuncName)
 *    func void LockMobLockable     (int mobPtr, string keyInstance, string pickLockStr, int isLocked)
 *    func void FillMobContainer    (int mobPtr, string contents)
 *
 *
 *  Example
 *
 *   // Inserting a locked chest with specific contents
 *
 *   const float pos[3] = { 9458.563477, 589.735718, -4732.891602 }; // World coordinates (use [ALT]+[P] in MARVIN-mode)
 *
 *   var int chestPtr;
 *   chestPtr = InsertMobContainerPos("myNewChest", "CHESTBIG_OCCHESTLARGE.MDS", _@f(pos), 0);
 *
 *   SetMobName(chestPtr,       "MOBNAME_CHEST");                    // Set focus name
 *   LockMobLockable(chestPtr,  "ItKe_Key_01", "LRLR", TRUE);        // A key and/or lock picking string can be set
 *   FillMobContainer(chestPtr, "ItMi_Gold:23,ItKe_Key_01:1 ");      // Whoops, dropped the key inside!
 *
 */


/*
 * Creates an "empty" trafo-matrix
 */
func void NewTrafo(var int trafoPtr) {
    const int zMAT4__s_identity_G1 = 8845416; //0x86F868
    const int zMAT4__s_identity_G2 = 9258472; //0x8D45E8
    const int sizeof_zMAT4         = 64; // Same for G1 and G2

    MEM_CopyBytes(MEMINT_SwitchG1G2(zMAT4__s_identity_G1, zMAT4__s_identity_G2), trafoPtr, sizeof_zMAT4);
};

/*
 * Rotate trafo-matrix around its up-vector (change font-facing direction)
 */
func void RotateTrafoY(var int trafoPtr, var int degrees) {
    const int zMAT4__PostRotateY_G1 = 5274256; //0x507A90
    const int zMAT4__PostRotateY_G2 = 5339008; //0x517780

    const int call = 0;
    if (CALL_Begin(call)) {
        CALL_FloatParam(_@(degrees));
        CALL__thiscall(_@(trafoPtr), MEMINT_SwitchG1G2(zMAT4__PostRotateY_G1, zMAT4__PostRotateY_G2));
        call = CALL_End();
    };
};


/*
 * Store the positional information of a trafo-matrix into a vector
 */
func void TrfToPos(var int trafoPtr, var int posPtr) {
    MEM_WriteIntArray(posPtr, 0, MEM_ReadIntArray(trafoPtr,  3));
    MEM_WriteIntArray(posPtr, 1, MEM_ReadIntArray(trafoPtr,  7));
    MEM_WriteIntArray(posPtr, 2, MEM_ReadIntArray(trafoPtr, 11));
};


/*
 * Store positional and/or directional information into a trafo-matrix
 */
func void PosDirToTrf(var int posPtr, var int dirPtr, var int trafoPtr) {
    if (posPtr) {
        MEM_WriteIntArray(trafoPtr,  3, MEM_ReadIntArray(posPtr, 0));
        MEM_WriteIntArray(trafoPtr,  7, MEM_ReadIntArray(posPtr, 1));
        MEM_WriteIntArray(trafoPtr, 11, MEM_ReadIntArray(posPtr, 2));
    };

    if (dirPtr) {
        MEM_WriteIntArray(trafoPtr,  2, MEM_ReadIntArray(dirPtr, 0));
        MEM_WriteIntArray(trafoPtr,  6, MEM_ReadIntArray(dirPtr, 1));
        MEM_WriteIntArray(trafoPtr, 10, MEM_ReadIntArray(dirPtr, 2));
    };
};


/*
 * Get ground level (y-coordinate) from a position
 */
func int GetGroundLvlPos(var int posPtr) {
    const float dir[3] = { 0.0, -2000.0, 0.0 }; // Check for ground up to 2000 cm below (Gothic does 1000 cm)

    const int zCWorld__TraceRayNearestHit_G1 = 6243008; //0x5F42C0
    const int zCWorld__TraceRayNearestHit_G2 = 6429568; //0x621B80

    const int flags = 33; // 0x21 (zTRACERAY_VOB_IGNORE_NO_CD_DYN | zTRACERAY_STAT_POLY)
    const int ignoreList = 0;
    var int worldPtr; worldPtr = MEM_Game._zCSession_world;
    var int dirPtr; dirPtr = _@f(dir);

    const int call = 0;
    if (CALL_Begin(call)) {
        CALL_IntParam(_@(flags));
        CALL_PtrParam(_@(ignoreList));
        CALL_PtrParam(_@(dirPtr));

        CALL__fastcall(_@(worldPtr), _@(posPtr), MEMINT_SwitchG1G2(zCWorld__TraceRayNearestHit_G1,
                                                                   zCWorld__TraceRayNearestHit_G2));
        call = CALL_End();
    };

    // Check for intersection and return y-position
    if (CALL_RetValAsInt()) && ((MEM_World.foundPoly) || (MEM_World.foundVob)) {
        return MEM_World.foundIntersection[1];
    } else {
        return posPtr;
    };
};


/*
 * Get ground level (y-coordinate) from a trafo-matrix
 */
func int GetGroundLvl(var int trfPtr) {
    var int pos[3];
    TrfToPos(trfPtr, _@(pos));
    return GetGroundLvlPos(_@(pos));
};


/*
 * Search a way point by its name
 */
func int SearchWaypointByName(var string waypoint) {
    const int zCWayNet__GetWaypoint_G1 = 7366448; //0x706730
    const int zCWayNet__GetWaypoint_G2 = 8061744; //0x7B0330

    var int waynetPtr; waynetPtr = MEM_World.wayNet;
    var int wpNamePtr; wpNamePtr = _@s(waypoint);

    const int call = 0;
    if (Call_Begin(call)) {
        CALL__fastcall(_@(waynetPtr), _@(wpNamePtr), MEMINT_SwitchG1G2(zCWayNet__GetWaypoint_G1,
                                                                       zCWayNet__GetWaypoint_G2));
        call = CALL_End();
    };
    return CALL_RetValAsPtr();
};


/*
 * Get trafo-matrix from way point
 */
func void GetTrafoFromWP(var string wpName, var int trafoPtr) {
    var int wpPtr; wpPtr = SearchWaypointByName(wpName);
    if (!wpPtr) {
        MEM_Warn("Way point not found!");
        return;
    };

    var zCWaypoint wp; wp = _^(wpPtr);
    PosDirToTrf(_@(wp.pos), _@(wp.dir), trafoPtr);
};


/*
 * Set way point to correct height above ground level
 */
func void SetWPToFloor(var int wpPtr) {
    const int zCWaypoint__CorrectHeight_G1 = 7365792; //0x7064A0
    const int zCWaypoint__CorrectHeight_G2 = 8061088; //0x7B00A0

    var int worldPtr; worldPtr = MEM_Game._zCSession_world;

    const int call = 0;
    if (CALL_Begin(call)) {
        CALL_PtrParam(_@(worldPtr));

        CALL__thiscall(_@(wpPtr), MEMINT_SwitchG1G2(zCWaypoint__CorrectHeight_G1, zCWaypoint__CorrectHeight_G2));
        call = CALL_End();
    };
};


/*
 * Align a vob to a trafo-matrix
 */
func void AlignVobAt(var int vobPtr, var int trfPtr) {
    if (!vobPtr) || (!trfPtr) {
        return;
    };

    const int zCVob__SetTrafoObjToWorld_G1 = 6219616; //0x5EE760
    const int zCVob__SetTrafoObjToWorld_G2 = 6405248; //0x61BC80

    // Lift collision
    var zCVob vob; vob = _^(vobPtr);
    var int bits; bits = vob.bitfield[0];
    vob.bitfield[0] = vob.bitfield[0] & ~zCVob_bitfield0_collDetectionStatic & ~zCVob_bitfield0_collDetectionDynamic;

    const int call = 0;
    if (CALL_Begin(call)) {
        CALL_PtrParam(_@(trfPtr));
        CALL__thiscall(_@(vobPtr), MEMINT_SwitchG1G2(zCVob__SetTrafoObjToWorld_G1, zCVob__SetTrafoObjToWorld_G2));
        call = CALL_End();
    };

    // Restore bits
    vob.bitfield[0] = bits;
};


/*
 * Set vob to align at ground level
 */
func void SetVobToFloor(var int vobPtr) {
    if (!vobPtr) {
        return;
    };

    // Correct height
    var zCVob vob; vob = _^(vobPtr);
    var int half; half = subf(vob.trafoObjToWorld[7], vob.bbox3D_mins[1]);
    vob.trafoObjToWorld[7] = GetGroundLvl(_@(vob.trafoObjToWorld));
    vob.trafoObjToWorld[7] = addf(vob.trafoObjToWorld[7], half);
    vob.trafoObjToWorld[7] = subf(vob.trafoObjToWorld[7], castToIntf(0.5));

    // Update position
    AlignVobAt(vobPtr, _@(vob.trafoObjToWorld));
};


/*
 * Set a visual of a given vob by string
 */
func void VobSetVisual(var int vobPtr, var String visual) {
    const int zCVob__SetVisual_G1 = 6123424; //0x5D6FA0
    const int zCVob__SetVisual_G2 = 6301312; //0x602680

    if (!vobPtr) {
        return;
    };

    var int strPtr; strPtr = _@s(visual);

    const int call = 0;
    if (CALL_Begin(call)) {
        CALL_PtrParam(_@(strPtr));
        CALL__thiscall(_@(vobPtr), MEMINT_SwitchG1G2(zCVob__SetVisual_G1, zCVob__SetVisual_G2));
        call = CALL_End();
    };
};


/*
 * Retrieve class definition address by string
 */
func int GetClassDefByString(var string classDefName) {
    const int zCClassDef__GetClassDef_G1 = 5809264; //0x58A470
    const int zCClassDef__GetClassDef_G2 = 5939168; //0x5A9FE0

    var int classDefNamePtr; classDefNamePtr = _@s(classDefName);

    const int call = 0;
    if (CALL_Begin(call)) {
        CALL_PtrParam(_@(classDefNamePtr));
        CALL__cdecl(MEMINT_SwitchG1G2(zCClassDef__GetClassDef_G1, zCClassDef__GetClassDef_G2));
        call = CALL_End();
    };
    return CALL_RetValAsPtr();
};


/*
 * Create a new instance by class definition
 */
func int CreateNewInstance(var int classDefAddr) {
    var zCClassDef classDef; classDef = _^(classDefAddr);

    // This is a non-recyclable call, because of varying function address
    CALL__cdecl(classDef.createNewInstance);
    return CALL_RetValAsPtr();
};


/*
 * Create new instance by class definition name
 */
func int CreateNewInstanceByString(var string classDefName) {
    var int classDefAddr; classDefAddr = GetClassDefByString(classDefName);
    if (!classDefAddr) {
        MEM_Warn("ClassDef not found");
        return 0;
    };

    return CreateNewInstance(classDefAddr);
};


/*
 * Create and insert object
 */
func int InsertObject(var string class, var string objName, var string visual, var int trfPtr, var int parentPtr) {
    var int vobPtr; vobPtr = CreateNewInstanceByString(class);
    if (!vobPtr) {
        return 0;
    };

    VobSetVisual(vobPtr, visual);
    MEM_RenameVob(vobPtr, objName);

    // Adjust bits
    var zCVob vob; vob = _^(vobPtr);
    vob.bitfield[0] = vob.bitfield[0] & (-67108865); //0xFBFFFFFF
    vob.bitfield[0] = vob.bitfield[0] & ~zCVob_bitfield0_collDetectionStatic & ~zCVob_bitfield0_collDetectionDynamic;

    // Set positional and rotational information
    AlignVobAt(vobPtr, trfPtr);

    // Get parent vob tree
    var int vobTreePtr;
    if (parentPtr) {
        var zCVob parent; parent = _^(parentPtr);
        vobTreePtr = parent.globalVobTreeNode;
    } else {
        vobTreePtr = _@(MEM_Vobtree); // Global vob tree
    };

    // Insert into world
    const int oCWorld__AddVobAsChild_G1 = 7171232; //0x6D6CA0
    const int oCWorld__AddVobAsChild_G2 = 7863856; //0x77FE30

    var int worldPtr; worldPtr = MEM_Game._zCSession_world;
    const int call = 0;
    if (CALL_Begin(call)) {
        CALL_PtrParam(_@(vobTreePtr));
        CALL_PtrParam(_@(vobPtr));

        CALL_PutRetValTo(0);

        CALL__thiscall(_@(worldPtr), MEMINT_SwitchG1G2(oCWorld__AddVobAsChild_G1, oCWorld__AddVobAsChild_G2));
        call = CALL_End();
    };

    // Set bits
    vob.bitfield[0] = vob.bitfield[0] | zCVob_bitfield0_collDetectionStatic | zCVob_bitfield0_collDetectionDynamic;
    vob.bitfield[2] = vob.bitfield[2] & ~zCVob_bitfield2_sleepingMode; // zCVob::SetSleeping(vobPtr, 1);

    // Decrease reference counter... why is that necessary?
    vob._zCObject_refCtr -= 1;
    if (vob._zCObject_refCtr <= 0) {
        const int _scalar_deleting_destructor_offset = 12; // Same for G1 and G2
        CALL_IntParam(1);
        CALL__thiscall(vobPtr, MEM_ReadInt(vob._vtbl+_scalar_deleting_destructor_offset));
    };

    return vobPtr;
};
func int InsertObjectPos(var string class, var string nm, var string vis, var int pos, var int dir, var int par) {
    var int trafo[16]; NewTrafo(_@(trafo));
    PosDirToTrf(pos, dir, _@(trafo));
    return InsertObject(class, nm, vis, _@(trafo), par);
};
func int InsertObjectWP(var string class, var string nm, var string vis, var string wpName, var int par) {
    var int wpPtr; wpPtr = SearchWaypointByName(wpName);
    if (!wpPtr) {
        MEM_Warn(ConcatStrings("Way point not found: ", wpName));
        return 0;
    };
    var zCWaypoint wp; wp = _^(wpPtr);
    return InsertObjectPos(class, nm, vis, _@(wp.pos), _@(wp.dir), par);
};


/*
 * zCVob/oCVob functions:
 *
 * InsertVobWP        (string objName, string visual, string waypoint)
 * InsertVobPos       (string objName, string visual, int[3] *pos, int[3] *dir)
 * InsertVob          (string objName, string visual, int[16] *trafoMat)
 *
 * InsertVobAsChildWP (string objName, string visual, string waypoint,          int *parentVob)
 * InsertVobAsChildPos(string objName, string visual, int[3] *pos, int[3] *dir, int *parentVob)
 * InsertVobAsChild   (string objName, string visual, int[16] *trafoMat,        int *parentVob)
 */
func int InsertVobAsChild(var string nm, var string vis, var int trf, var int par) {
    return InsertObject("zCVob", nm, vis, trf, par);
};
func int InsertVobAsChildPos(var string nm, var string vis, var int pos, var int dir, var int par) {
    return InsertObjectPos("zCVob", nm, vis, pos, dir, par);
};
func int InsertVobAsChildWP(var string nm, var string vis, var string wp, var int par) {
    return InsertObjectWP("zCVob", nm, vis, wp, par);
};
func int InsertVob(var string nm, var string vis, var int trf) {
    return InsertObject("zCVob", nm, vis, trf, 0);
};
func int InsertVobPos(var string nm, var string vis, var int pos, var int dir) {
    return InsertObjectPos("zCVob", nm, vis, pos, dir, 0);
};
func int InsertVobWP(var string nm, var string vis, var string wp) {
    return InsertObjectWP("zCVob", nm, vis, wp, 0);
};


/*
 * oCMob functions:
 *
 * InsertMobWP        (string objName, string visual, string waypoint)
 * InsertMobPos       (string objName, string visual, int[3] *pos, int[3] *dir)
 * InsertMob          (string objName, string visual, int[16] *trafoMat)
 *
 * InsertMobAsChildWP (string objName, string visual, string waypoint,          int *parentVob)
 * InsertMobAsChildPos(string objName, string visual, int[3] *pos, int[3] *dir, int *parentVob)
 * InsertMobAsChild   (string objName, string visual, int[16] *trafoMat,        int *parentVob)
 */
func int InsertMobAsChild(var string nm, var string vis, var int trf, var int par) {
    return InsertObject("oCMob", nm, vis, trf, par);
};
func int InsertMobAsChildPos(var string nm, var string vis, var int pos, var int dir, var int par) {
    return InsertObjectPos("oCMob", nm, vis, pos, dir, par);
};
func int InsertMobAsChildWP(var string nm, var string vis, var string wp, var int par) {
    return InsertObjectWP("oCMob", nm, vis, wp, par);
};
func int InsertMob(var string nm, var string vis, var int trf) {
    return InsertObject("oCMob", nm, vis, trf, 0);
};
func int InsertMobPos(var string nm, var string vis, var int pos, var int dir) {
    return InsertObjectPos("oCMob", nm, vis, pos, dir, 0);
};
func int InsertMobWP(var string nm, var string vis, var string wp) {
    return InsertObjectWP("oCMob", nm, vis, wp, 0);
};


/*
 * oCMobInter functions:
 *
 * InsertMobInterWP        (string objName, string visual, string waypoint)
 * InsertMobInterPos       (string objName, string visual, int[3] *pos, int[3] *dir)
 * InsertMobInter          (string objName, string visual, int[16] *trafoMat)
 *
 * InsertMobInterAsChildWP (string objName, string visual, string waypoint,          int *parentVob)
 * InsertMobInterAsChildPos(string objName, string visual, int[3] *pos, int[3] *dir, int *parentVob)
 * InsertMobInterAsChild   (string objName, string visual, int[16] *trafoMat,        int *parentVob)
 */
func int InsertMobInterAsChild(var string nm, var string vis, var int trf, var int par) {
    return InsertObject("oCMobInter", nm, vis, trf, par);
};
func int InsertMobInterAsChildPos(var string nm, var string vis, var int pos, var int dir, var int par) {
    return InsertObjectPos("oCMobInter", nm, vis, pos, dir, par);
};
func int InsertMobInterAsChildWP(var string nm, var string vis, var string wp, var int par) {
    return InsertObjectWP("oCMobInter", nm, vis, wp, par);
};
func int InsertMobInter(var string nm, var string vis, var int trf) {
    return InsertObject("oCMobInter", nm, vis, trf, 0);
};
func int InsertMobInterPos(var string nm, var string vis, var int pos, var int dir) {
    return InsertObjectPos("oCMobInter", nm, vis, pos, dir, 0);
};
func int InsertMobInterWP(var string nm, var string vis, var string wp) {
    return InsertObjectWP("oCMobInter", nm, vis, wp, 0);
};


/*
 * oCMobLockable functions:
 *
 * InsertMobLockableWP        (string objName, string visual, string waypoint)
 * InsertMobLockablePos       (string objName, string visual, int[3] *pos, int[3] *dir)
 * InsertMobLockable          (string objName, string visual, int[16] *trafoMat)
 *
 * InsertMobLockableAsChildWP (string objName, string visual, string waypoint,          int *parentVob)
 * InsertMobLockableAsChildPos(string objName, string visual, int[3] *pos, int[3] *dir, int *parentVob)
 * InsertMobLockableAsChild   (string objName, string visual, int[16] *trafoMat,        int *parentVob)
 */
func int InsertMobLockableAsChild(var string nm, var string vis, var int trf, var int par) {
    return InsertObject("oCMobLockable", nm, vis, trf, par);
};
func int InsertMobLockableAsChildPos(var string nm, var string vis, var int pos, var int dir, var int par) {
    return InsertObjectPos("oCMobLockable", nm, vis, pos, dir, par);
};
func int InsertMobLockableAsChildWP(var string nm, var string vis, var string wp, var int par) {
    return InsertObjectWP("oCMobLockable", nm, vis, wp, par);
};
func int InsertMobLockable(var string nm, var string vis, var int trf) {
    return InsertObject("oCMobLockable", nm, vis, trf, 0);
};
func int InsertMobLockablePos(var string nm, var string vis, var int pos, var int dir) {
    return InsertObjectPos("oCMobLockable", nm, vis, pos, dir, 0);
};
func int InsertMobLockableWP(var string nm, var string vis, var string wp) {
    return InsertObjectWP("oCMobLockable", nm, vis, wp, 0);
};


/*
 * oCMobContainer functions:
 *
 * InsertMobContainerWP        (string objName, string visual, string waypoint)
 * InsertMobContainerPos       (string objName, string visual, int[3] *pos, int[3] *dir)
 * InsertMobContainer          (string objName, string visual, int[16] *trafoMat)
 *
 * InsertMobContainerAsChildWP (string objName, string visual, string waypoint,          int *parentVob)
 * InsertMobContainerAsChildPos(string objName, string visual, int[3] *pos, int[3] *dir, int *parentVob)
 * InsertMobContainerAsChild   (string objName, string visual, int[16] *trafoMat,        int *parentVob)
 */
func int InsertMobContainerAsChild(var string nm, var string vis, var int trf, var int par) {
    return InsertObject("oCMobContainer", nm, vis, trf, par);
};
func int InsertMobContainerAsChildPos(var string nm, var string vis, var int pos, var int dir, var int par) {
    return InsertObjectPos("oCMobContainer", nm, vis, pos, dir, par);
};
func int InsertMobContainerAsChildWP(var string nm, var string vis, var string wp, var int par) {
    return InsertObjectWP("oCMobContainer", nm, vis, wp, par);
};
func int InsertMobContainer(var string nm, var string vis, var int trf) {
    return InsertObject("oCMobContainer", nm, vis, trf, 0);
};
func int InsertMobContainerPos(var string nm, var string vis, var int pos, var int dir) {
    return InsertObjectPos("oCMobContainer", nm, vis, pos, dir, 0);
};
func int InsertMobContainerWP(var string nm, var string vis, var string wp) {
    return InsertObjectWP("oCMobContainer", nm, vis, wp, 0);
};


/*
 * oCMobDoor functions:
 *
 * InsertMobDoorWP        (string objName, string visual, string waypoint)
 * InsertMobDoorPos       (string objName, string visual, int[3] *pos, int[3] *dir)
 * InsertMobDoor          (string objName, string visual, int[16] *trafoMat)
 *
 * InsertMobDoorAsChildWP (string objName, string visual, string waypoint,          int *parentVob)
 * InsertMobDoorAsChildPos(string objName, string visual, int[3] *pos, int[3] *dir, int *parentVob)
 * InsertMobDoorAsChild   (string objName, string visual, int[16] *trafoMat,        int *parentVob)
 */
func int InsertMobDoorAsChild(var string nm, var string vis, var int trf, var int par) {
    return InsertObject("oCMobDoor", nm, vis, trf, par);
};
func int InsertMobDoorAsChildPos(var string nm, var string vis, var int pos, var int dir, var int par) {
    return InsertObjectPos("oCMobDoor", nm, vis, pos, dir, par);
};
func int InsertMobDoorAsChildWP(var string nm, var string vis, var string wp, var int par) {
    return InsertObjectWP("oCMobDoor", nm, vis, wp, par);
};
func int InsertMobDoor(var string nm, var string vis, var int trf) {
    return InsertObject("oCMobDoor", nm, vis, trf, 0);
};
func int InsertMobDoorPos(var string nm, var string vis, var int pos, var int dir) {
    return InsertObjectPos("oCMobDoor", nm, vis, pos, dir, 0);
};
func int InsertMobDoorWP(var string nm, var string vis, var string wp) {
    return InsertObjectWP("oCMobDoor", nm, vis, wp, 0);
};


/*
 * oCMobFire functions:
 *
 * InsertMobFireWP        (string objName, string visual, string waypoint)
 * InsertMobFirePos       (string objName, string visual, int[3] *pos, int[3] *dir)
 * InsertMobFire          (string objName, string visual, int[16] *trafoMat)
 *
 * InsertMobFireAsChildWP (string objName, string visual, string waypoint,          int *parentVob)
 * InsertMobFireAsChildPos(string objName, string visual, int[3] *pos, int[3] *dir, int *parentVob)
 * InsertMobFireAsChild   (string objName, string visual, int[16] *trafoMat,        int *parentVob)
 */
func int InsertMobFireAsChild(var string nm, var string vis, var int trf, var int par) {
    return InsertObject("oCMobFire", nm, vis, trf, par);
};
func int InsertMobFireAsChildPos(var string nm, var string vis, var int pos, var int dir, var int par) {
    return InsertObjectPos("oCMobFire", nm, vis, pos, dir, par);
};
func int InsertMobFireAsChildWP(var string nm, var string vis, var string wp, var int par) {
    return InsertObjectWP("oCMobFire", nm, vis, wp, par);
};
func int InsertMobFire(var string nm, var string vis, var int trf) {
    return InsertObject("oCMobFire", nm, vis, trf, 0);
};
func int InsertMobFirePos(var string nm, var string vis, var int pos, var int dir) {
    return InsertObjectPos("oCMobFire", nm, vis, pos, dir, 0);
};
func int InsertMobFireWP(var string nm, var string vis, var string wp) {
    return InsertObjectWP("oCMobFire", nm, vis, wp, 0);
};


/*
 * "Abstract" vob functions:
 *
 * InsertTriggerPos           (string objName,                int[3] *pos, int[3] *dir)
 * InsertTriggerScriptPos     (string objName,                int[3] *pos, int[3] *dir)
 * InsertTriggerChangeLevelPos(string objName,                int[3] *pos, int[3] *dir)
 * InsertMoverPos             (string objName, string visual, int[3] *pos, int[3] *dir)
 *
 * InsertTrigger              (string objName,                int[16] *trafoMat)
 * InsertTriggerScript        (string objName,                int[16] *trafoMat)
 * InsertTriggerChangeLevel   (string objName,                int[16] *trafoMat)
 * InsertMover                (string objName, string visual, int[16] *trafoMat)
 */
func int InsertTrigger(var string nm, var int trf) {
    return InsertObject("zCTrigger", nm, "", trf, 0);
};
func int InsertTriggerPos(var string nm, var int pos, var int dir) {
    return InsertObjectPos("zCTrigger", nm, "", pos, dir, 0);
};
func int InsertTriggerScript(var string nm, var int trf) {
    return InsertObject("oCTriggerScript", nm, "", trf, 0);
};
func int InsertTriggerScriptPos(var string nm, var int pos, var int dir) {
    return InsertObjectPos("oCTriggerScript", nm, "", pos, dir, 0);
};
func int InsertTriggerChangeLevel(var string nm, var int trf) {
    return InsertObject("oCTriggerChangeLevel", nm, "", trf, 0);
};
func int InsertTriggerChangeLevelPos(var string nm, var int pos, var int dir) {
    return InsertObjectPos("oCTriggerChangeLevel", nm, "", pos, dir, 0);
};
func int InsertMover(var string nm, var string vis, var int trf) {
    return InsertObject("zCMover", nm, vis, trf, 0);
};
func int InsertMoverPos(var string nm, var string vis, var int pos, var int dir) {
    return InsertObjectPos("zCMover", nm, vis, pos, dir, 0);
};


/*
 * oCItem functions:
 *
 * InsertItemWP (string itemInstance, int amount, string waypoint)
 * InsertItemPos(string itemInstance, int amount, int* pos, int* dir)
 * InsertItem   (string itemInstance, int amount, int* trafoMat)
 */
func int InsertItemWP(var string itmInst, var int amount, var string wp) {
    Wld_InsertItem(MEM_GetSymbolIndex(itmInst), wp);

    var zCTree newTreeNode; newTreeNode = _^(MEM_World.globalVobTree_firstChild);
    var int itmPtr; itmPtr = newTreeNode.data;

    if (!itmPtr) {
        MEM_Warn(ConcatStrings("Could not insert item: ", itmInst));
        return 0;
    };

    var oCItem itm; itm = _^(itmPtr);
    itm.amount = amount;

    return itmPtr;
};
func int InsertItem(var string itmInst, var int amount, var int trf) {
    var int itmPtr; itmPtr = InsertItemWP(itmInst, amount, MEM_FARFARAWAY);

    AlignVobAt(itmPtr, trf);

    return itmPtr;
};
func int InsertItemPos(var string itmInst, var int amount, var int pos, var int dir) {
    var int trafo[16];
    NewTrafo(_@(trafo));
    PosDirToTrf(pos, dir, _@(trafo));

    var int itmPtr; itmPtr = InsertItem(itmInst, amount, _@(trafo));
    SetVobToFloor(itmPtr);

    return itmPtr;
};


/*
 * PileOf functions:
 *
 * InsertPileOf     (string class, string objName, string visual, int[16]* trafoMat, int amount, int cm2, int rotate)
 * InsertPileOfVobs (              string objName, string visual, int[16]* trafoMat, int amount, int cm2, int rotate)
 * InsertPileOfItems(              string itmInst,                int[16]* trafoMat, int amount, int cm2, int rotate)
 */
func void InsertPileOf(var string cl, var string nm, var string vis, var int trf, var int am, var int cm, var int rot) {
    const int sizeof_zMAT4 = 64; // Same for G1 and G2

    repeat(i, am); var int i;
        // Get new trafo from the original
        var int trafo[16];
        MEM_CopyBytes(trf, _@(trafo), sizeof_zMAT4);

        // Increase height for better piling (will be "dropped")
        trafo[ 7] = addf(trafo[ 7], mkf(200));

        // Shift position (will be distributed over a square not a circle)
        trafo[ 3] = addf(trafo[ 3], mkf(Hlp_Random(cm*2)-cm));
        trafo[11] = addf(trafo[11], mkf(Hlp_Random(cm*2)-cm));

        // Rotate
        if (rot) {
            RotateTrafoY(_@(trafo), mkf(Hlp_Random(360)));
        };

        // Create vob or item
        var int vobPtr;
        if (Hlp_StrCmp(cl, "oCItem")) {
            vobPtr = InsertItem(nm, 1, _@(trafo));
        } else {
            var string name; name = ConcatStrings(nm, IntToString(i+1));
            vobPtr = InsertObject(cl, name, vis, _@(trafo), 0);
        };
        SetVobToFloor(vobPtr);
    end;
};
func void InsertPileOfVobs(var string nm, var string vis, var int trf, var int am, var int cm, var int rot) {
    InsertPileOf("zCVob", nm, vis, trf, am, cm, rot);
};
func void InsertPileOfItems(var string itmInst, var int trf, var int am, var int cm, var int rot) {
    InsertPileOf("oCItem", itmInst, "", trf, am, cm, rot);
};



/*
 * Post-insert functions
 */


/*
 * Set the focus name of a mob (see Text.d)
 */
func int SetMobName(var int mobPtr, var string symbolicFocusName) {
    if (Hlp_Is_oCMob(mobPtr)) {
        var oCMob mob; mob = _^(mobPtr);
        mob.name           = symbolicFocusName;
        mob.focusNameIndex = MEM_GetSymbolIndex(symbolicFocusName);
    };
    return mobPtr;
};


/*
 * Set some miscellaneous properties of mobs
 */
func void SetMobMisc(var int mobPtr, var string triggerTarget, var string useWithItem, var string onStateFuncName) {
    if (!Hlp_Is_oCMobInter(mobPtr)) {
        MEM_Warn("Not a oCMobInter!");
        return;
    };

    var oCMobInter mob; mob = _^(mobPtr);
    mob.triggerTarget   = triggerTarget;
    mob.useWithItem     = useWithItem;
    mob.onStateFuncName = onStateFuncName;
};


/*
 * Lock a oCMobLockable
 */
func void LockMobLockable(var int mobPtr, var string keyInstance, var string pickLockStr, var int locked) {
    if (!Hlp_Is_oCMobLockable(mobPtr)) {
        MEM_Warn("Not a oCMobLocable!");
        return;
    };

    var oCMobLockable mob; mob = _^(mobPtr);
    mob.keyInstance = keyInstance;
    mob.pickLockStr = pickLockStr;

    if (locked) {
        mob.bitfield = mob.bitfield | oCMobLockable_bitfield_locked;
    };
};


/*
 * Create contents of oCMobContainers by string
 */
func void FillMobContainer(var int mobPtr, var string contents) {
    if (!Hlp_Is_oCMobContainer(mobPtr)) {
        MEM_Warn("Not a oCMobContainer!");
        return;
    };

    const int oCMobContainer__CreateContents_G1 = 6832208; //0x684050
    const int oCMobContainer__CreateContents_G2 = 7496080; //0x726190

    var int contentsPtr; contentsPtr = _@s(contents);

    const int call = 0;
    if (CALL_Begin(call)) {
        CALL_PtrParam(_@(contentsPtr));
        CALL__thiscall(_@(mobPtr), MEMINT_SwitchG1G2(oCMobContainer__CreateContents_G1,
                                                     oCMobContainer__CreateContents_G2));
        call = CALL_End();
    };
};