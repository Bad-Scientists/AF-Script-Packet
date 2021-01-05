/*
 *	func void oCMobContainer_Remove (var int mobPtr, var int itmPtr){
 */

/*
 *	Removes Item from oCMobContainer
 *		mobPtr			pointer to oCMobContainer
 *		itmPtr			pointer to oCItem in oCMobContainer
 *	Usage:
 *		oCMobContainer_Remove(mobPtr, itmPtr);
 */
func void oCMobContainer_Remove (var int mobPtr, var int itmPtr){
	if (!mobPtr) { return; };
	if (!itmPtr) { return; };

	//00683EB0  .text     Debug data           ?Remove@oCMobContainer@@UAEXPAVoCItem@@@Z
	const int oCMobContainer__Remove_G1 = 6831792;
	
	//0x00725FF0 public: virtual void __thiscall oCMobContainer::Remove(class oCItem *)
	const int oCMobContainer__Remove_G2 = 7495664;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PtrParam (_@ (itmPtr));
		CALL__thiscall (_@ (mobPtr), MEMINT_SwitchG1G2 (oCMobContainer__Remove_G1, oCMobContainer__Remove_G2));
		call = CALL_End();
	};
};