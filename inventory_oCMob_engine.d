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
	//0x00683EB0 public: virtual void __thiscall oCMobContainer::Remove(class oCItem *)
	const int oCMobContainer__Remove_G1 = 6831792;

	//0x00725FF0 public: virtual void __thiscall oCMobContainer::Remove(class oCItem *)
	const int oCMobContainer__Remove_G2 = 7495664;

	if (!Hlp_Is_oCMobContainer (mobPtr)) { return; };
	if (!Hlp_Is_oCItem (itmPtr)) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PtrParam (_@ (itmPtr));
		CALL__thiscall (_@ (mobPtr), MEMINT_SwitchG1G2 (oCMobContainer__Remove_G1, oCMobContainer__Remove_G2));
		call = CALL_End();
	};
};

/*
 *	I was hoping this one removes item from oCMobContainer without dicarding it - but returned pointer is 0
 *

func int oCMobContainer_GetRemoved (var int mobPtr, var int itmPtr, var int amount){
	//0x00683F40 public: virtual class oCItem * __thiscall oCMobContainer::Remove(class oCItem *,int)
	const int oCMobContainer__Remove_G1 = 6831936;

	//0x00726080 public: virtual class oCItem * __thiscall oCMobContainer::Remove(class oCItem *,int)
	const int oCMobContainer__Remove_G2 = 7495808;

	if (!Hlp_Is_oCMobContainer (mobPtr)) { return 0; };
	if (!Hlp_Is_oCItem (itmPtr)) { return 0; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_IntParam (_@ (amount));
		CALL_PtrParam (_@ (itmPtr));
		CALL__thiscall (_@ (mobPtr), MEMINT_SwitchG1G2 (oCMobContainer__Remove_G1, oCMobContainer__Remove_G2));
		call = CALL_End();
	};

	var int retVal; retVal = CALL_RetValAsPtr ();

	B_Msg_Add (IntToString (retVal));

	return retVal;
};
*/

func void oCMobContainer_Insert (var int mobPtr, var int itmPtr){
	//0x00683E80 public: virtual void __thiscall oCMobContainer::Insert(class oCItem *)
	const int oCMobContainer__Insert_G1 = 6831744;

	//0x00725FC0 public: virtual void __thiscall oCMobContainer::Insert(class oCItem *)
	const int oCMobContainer__Insert_G2 = 7495616;

	if (!Hlp_Is_oCMobContainer (mobPtr)) { return; };
	if (!Hlp_Is_oCItem (itmPtr)) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PtrParam (_@ (itmPtr));
		CALL__thiscall (_@ (mobPtr), MEMINT_SwitchG1G2 (oCMobContainer__Insert_G1, oCMobContainer__Insert_G2));
		call = CALL_End();
	};
};

//0x00726190 public: virtual void __thiscall oCMobContainer::CreateContents(class zSTRING const &)
