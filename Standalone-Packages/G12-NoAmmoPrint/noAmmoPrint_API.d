/*
 *	1. Copy this file outside of script-packet
 *	2. Customize it (translate to your own language and add new ammo types if you need them)
 *	3. Link it to Gothic.src
 *	4. Profit
 */

//API function
func void NoAmmoPrint_AmmoMissing(var string instName) {
	if (Hlp_StrCmp(instName, "ITAMARROW") || Hlp_StrCmp(instName, "ITRW_ARROW")) {
		PrintS("You're out of arrows!");
		return;
	};

	if (Hlp_StrCmp(instName, "ITRW_ADDON_MAGICARROW")) {
		PrintS("You're out of magical arrows!");
		return;
	};

	if (Hlp_StrCmp(instName, "ITRW_ADDON_FIREARROW")) {
		PrintS("You're out of fire arrows!");
		return;
	};

	if (Hlp_StrCmp(instName, "ITAMBOLT") || Hlp_StrCmp(instName, "ITRW_BOLT")) {
		PrintS("You're out of bolts!");
		return;
	};

	if (Hlp_StrCmp(instName, "ITRW_ADDON_MAGICBOLT")) {
		PrintS("You're out of magical bolts!");
		return;
	};

	PrintS("You're out of ammo!");
};
