/*
 *	Author: szapp (mud-freak)
 *	Original post:
 *	https://forum.worldofplayers.de/forum/threads/1495001-Scriptsammlung-ScriptBin/page3?p=25717007&viewfull=1#post25717007
 *
 *	Small change in case of SearchVobsByVisual function visual is checked with function Vob_GetVisualName (in order to be able to work with oCMob objects
 */

/*
 * searchVobs.d
 *
 * Search vobs by different criteria
 *
 * - Requires Ikarus, objCheckInheritance.d, insertAnything.d
 * - Compatible with Gothic 1 and Gothic 2
 *
 * The function argument vobListPtr may always be zero, or the pointer to a previously created array.
 * The return value is the number of found vobs.
 *
 *
 *  func int SearchVobsByClass     (string className,        int vobListPtr)
 *  func int SearchVobsByVisual    (string visual,           int vobListPtr)
 *  func int SearchVobsByProximity (int posPtr, int maxDist, int vobListPtr)
 *  func int SearchVobsByRemoteness(int posPtr, int minDist, int vobListPtr)
 */


/*
 * Search all or given vobs by base class
 */
func int SearchVobsByClass(var string className, var int vobListPtr) {
    const int zCWorld__SearchVobListByBaseClass_G1 = 6250016; //0x5F5E20
    const int zCWorld__SearchVobListByBaseClass_G2 = 6439712; //0x624320

    var zCArray vobList; vobList = _^(vobListPtr);
    if (!vobList.numInArray) {
        var int vobTreePtr; vobTreePtr = _@(MEM_Vobtree);
        var int worldPtr;   worldPtr   = _@(MEM_World);
        var int classDef;   classDef   = GetClassDefByString(className);

        const int call = 0;
        if (CALL_Begin(call)) {
            CALL_PtrParam(_@(vobTreePtr));
            CALL_PtrParam(_@(vobListPtr));
            CALL_PtrParam(_@(classDef));
            CALL__thiscall(_@(worldPtr), MEMINT_SwitchG1G2(zCWorld__SearchVobListByBaseClass_G1,
                                                           zCWorld__SearchVobListByBaseClass_G2));
            call = CALL_End();
        };
    } else {
        // Iterate over all vobs and remove the ones not matching the criteria
        var int i; i = 0;
        while(i < vobList.numInArray);
            var int vobPtr; vobPtr = MEM_ArrayRead(vobListPtr, i);
            if (objCheckInheritance(vobPtr, classDef)) {
                // Keep vob
                i += 1;
            } else {
                // Otherwise remove vob from array
                MEM_ArrayRemoveIndex(vobListPtr, i);
            };
        end;
    };

    return vobList.numInArray;
};


/*
 * Search all or given vobs by visual
 */
func int SearchVobsByVisual(var string visual, var int vobListPtr) {
    // Create vob list if empty
    var zCArray vobList; vobList = _^(vobListPtr);
    if (!vobList.numInArray) {
        if (!SearchVobsByClass("zCVob", vobListPtr)) {
            return 0;
        };
    };

    // Iterate over all vobs and remove the ones not matching the criteria
    var int i; i = 0;
    while(i < vobList.numInArray);
        var int vobPtr; vobPtr = MEM_ArrayRead(vobListPtr, i);
        if (vobPtr) {
	    /*
            // Check for visual
            var zCVob vob; vob = _^(vobPtr);
            if (vob.visual) {
                // Compare visual
                var zCObject visualObj; visualObj = _^(vob.visual);
                if (Hlp_StrCmp(visualObj.objectname, visual)) {
                    // Keep vob
                    i += 1;
                    continue;
                };
            };
	    */
	    
	    if (Hlp_StrCmp (Vob_GetVisualName (vobPtr), visual)) {
                    // Keep vob
                    i += 1;
                    continue;
	    };
        };

        // Otherwise remove vob from array
        MEM_ArrayRemoveIndex(vobListPtr, i);
    end;

    return vobList.numInArray;
};


/*
 * Search all or given vobs by proximity
 */
func int SearchVobsByProximity(var int posPtr, var int maxDist, var int vobListPtr) {
    // Create vob list if empty
    var zCArray vobList; vobList = _^(vobListPtr);
    if (!vobList.numInArray) {
        if (!SearchVobsByClass("zCVob", vobListPtr)) {
            return 0;
        };
    };

    var int pos[3];
    MEM_CopyWords(posPtr, _@(pos), 3);

    // Iterate over all vobs and remove the ones not matching the criteria
    var int i; i = 0;
    while(i < vobList.numInArray);
        var int vobPtr; vobPtr = MEM_ArrayRead(vobListPtr, i);
        if (vobPtr) {
            // Check distance
            var zCVob vob; vob = _^(vobPtr);

            // Compute distance between vob and position
            var int dist[3];
            dist[0] = subf(vob.trafoObjToWorld[ 3], pos[0]);
            dist[1] = subf(vob.trafoObjToWorld[ 7], pos[1]);
            dist[2] = subf(vob.trafoObjToWorld[11], pos[2]);
            var int distance;
            distance = sqrtf(addf(addf(sqrf(dist[0]), sqrf(dist[1])), sqrf(dist[2])));

            // Check if distance is with in maxDist
            if (lef(distance, maxDist)) {
                // Keep vob
                i += 1;
                continue;
            };
        };

        // Otherwise remove vob from array
        MEM_ArrayRemoveIndex(vobListPtr, i);
    end;

    return vobList.numInArray;
};


/*
 * Search all or given vobs by remoteness
 */
func int SearchVobsByRemoteness(var int posPtr, var int minDist, var int vobListPtr) {
    // Create vob list if empty
    var zCArray vobList; vobList = _^(vobListPtr);
    if (!vobList.numInArray) {
        if (!SearchVobsByClass("zCVob", vobListPtr)) {
            return 0;
        };
    };

    var int pos[3];
    MEM_CopyWords(posPtr, _@(pos), 3);

    // Iterate over all vobs and remove the ones not matching the criteria
    var int i; i = 0;
    while(i < vobList.numInArray);
        var int vobPtr; vobPtr = MEM_ArrayRead(vobListPtr, i);
        if (vobPtr) {
            // Check distance
            var zCVob vob; vob = _^(vobPtr);

            // Compute distance between vob and position
            var int dist[3];
            dist[0] = subf(vob.trafoObjToWorld[ 3], pos[0]);
            dist[1] = subf(vob.trafoObjToWorld[ 7], pos[1]);
            dist[2] = subf(vob.trafoObjToWorld[11], pos[2]);
            var int distance;
            distance = sqrtf(addf(addf(sqrf(dist[0]), sqrf(dist[1])), sqrf(dist[2])));

            // Check if distance is beyond minDist
            if (gf(distance, minDist)) {
                // Keep vob
                i += 1;
                continue;
            };
        };

        // Otherwise remove vob from array
        MEM_ArrayRemoveIndex(vobListPtr, i);
    end;

    return vobList.numInArray;
};