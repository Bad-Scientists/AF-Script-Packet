/*
 *	Utils
 *	 - miscellanous collection of useful functions
 */
func int max (var int int1, var int int2) {
	if (int1 > int2) { return int1; };
	return int2;
};

func int min (var int int1, var int int2) {
	if (int1 > int2) { return int2; };
	return int1;
};

func int abs (var int i) {
	if (i < 0) { i = 0 - i; };
	return i;
};

func int clamp (var int v, var int min, var int max) {
	if (v < min) { return min; };
	if (v > max) { return max; };
	return v;
};

/*
 *	Credits: mud-freak
 *	Original post: https://forum.worldofplayers.de/forum/threads/1566398-G1-get-date-function
 *	Function returns current date and time in this format: YYYY-MM-DD HH:MM:SS
 */
func string GetLocalDateTimeStamp () {
	//0x0075AE08 _GetLocalTime@4
	const int _GetLocalTime_G1 = 7712264;

	//0x007B4750 _GetLocalTime@4
	const int _GetLocalTime_G2 = 8079184;

	var int SystemTimePtr; SystemTimePtr = MEM_Alloc(16); // SystemTime* 0x10
	CALL_PtrParam (SystemTimePtr);
	CALL__stdcall (MEMINT_SwitchG1G2 (_GetLocalTime_G1, _GetLocalTime_G2));

	var string timeStr; timeStr = IntToString(MEM_ReadInt(SystemTimePtr) & 2047);
	timeStr = ConcatStrings(timeStr, "-");

	var int mm; mm = MEM_ReadInt (SystemTimePtr+2) & 2047;
	if (mm < 10) { timeStr = ConcatStrings(timeStr, "0"); };
	timeStr = ConcatStrings(timeStr, IntToString(mm));
	timeStr = ConcatStrings(timeStr, "-");

	var int dd; dd = MEM_ReadInt(SystemTimePtr+6) & 2047;
	if (dd < 10) { timeStr = ConcatStrings(timeStr, "0"); };
	timeStr = ConcatStrings(timeStr, IntToString(dd));
	timeStr = ConcatStrings(timeStr, " ");

	var int hh; hh = MEM_ReadInt(SystemTimePtr+8) & 2047;
	if (hh < 10) { timeStr = ConcatStrings(timeStr, "0"); };
	timeStr = ConcatStrings(timeStr, IntToString(hh));
	timeStr = ConcatStrings(timeStr, ":");

	var int mi; mi = MEM_ReadInt(SystemTimePtr+10) & 2047;
	if (mi < 10) { timeStr = ConcatStrings(timeStr, "0"); };
	timeStr = ConcatStrings(timeStr, IntToString(mi));
	timeStr = ConcatStrings(timeStr, ":");

	var int ss; ss = MEM_ReadInt(SystemTimePtr+12) & 2047;
	if (ss < 10) { timeStr = ConcatStrings(timeStr, "0"); };
	timeStr = ConcatStrings(timeStr, IntToString(ss));

	MEM_Free(SystemTimePtr);

	return timeStr;
};

/*
 *	Returns YYYY-MM-DD
 */
func string GetLocalDate () {
	var string timeStr; timeStr = GetLocalDateTimeStamp ();
	timeStr = mySTR_Prefix (timeStr, 10);
	return timeStr;
};

/*
 *	Returns MM-DD
 */
func string GetLocalDate_MMDD () {
	var string timeStr; timeStr = GetLocalDateTimeStamp ();
	timeStr = mySTR_SubStr (timeStr, 5, 5);
	return timeStr;
};
