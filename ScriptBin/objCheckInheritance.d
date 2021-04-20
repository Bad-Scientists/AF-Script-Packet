/*
 *	Author: szapp (mud-freak)
 *	Original post: https://forum.worldofplayers.de/forum/threads/1495001-Scriptsammlung-ScriptBin?p=25548652&viewfull=1#post25548652
 */

// Extended functionality for Wld_StopEffect()
// See https://forum.worldofplayers.de/forum/threads/1495001-Scriptsammlung-ScriptBin?p=25548652&viewfull=1#post25548652
// Made by mud-freak (@szapp) 2017-08-05 (modified 2017-08-09)
//
// Compatible with Gothic 1 and Gothic 2
// Requirements: Ikarus 1.2


/*
 * Check the inheritance of a zCObject against a zCClassDef. Emulating zCObject::CheckInheritance() at 0x476E30 in G2.
 * This function is used in Wld_StopEffect_Ext().
 */
func int objCheckInheritance(var int objPtr, var int classDef) {
    if (!objPtr) || (!classDef) {
        return 0;
    };

    const int zCClassDef_baseClassDef_offset = 60;  //0x003C

    // Iterate over base classes
    var int curClassDef; curClassDef = MEM_GetClassDef(objPtr);
    while((curClassDef) && (curClassDef != classDef));
        curClassDef = MEM_ReadInt(curClassDef+zCClassDef_baseClassDef_offset);
    end;

    return (curClassDef == classDef);
};