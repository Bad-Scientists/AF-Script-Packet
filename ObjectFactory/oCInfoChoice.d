/*
 *	Create object
 */
func int oCInfoChoice_New () {
	//Does not work with oCInfoChoice
	//var int ptr; ptr = CreateNewInstanceByString ("oCInfoChoice");

	//Same for G1 & G2A
	const int sizeof_oCInfoChoice = 24;

	var int ptr; ptr = MEM_Alloc (sizeof_oCInfoChoice);
	return ptr;
};

/*
 *	Wrapper function for initialization
 */
func int oCInfoChoice_Create (var string text, var int funcID) {
	var int ptr; ptr = oCInfoChoice_New ();

	if (!ptr) { return 0; };

	var oCInfoChoice infoChoice;
	infoChoice = _^ (ptr);

	infoChoice.text = text;
	infoChoice.Function = funcID;

	return ptr;
};
