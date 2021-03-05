FUNC VOID ZS_ColorHelper_Hangaround () {
	NPC_PercEnable (self, PERC_ASSESSTALK, B_AssessTalk);
};

FUNC VOID ZS_ColorHelper_Hangaround_Loop () {};

FUNC VOID ZS_ColorHelper_Hangaround_End () {};

instance colorHelpo1 (Npc_Default)
{
	Name[0]		= "Color Helper";
	NPCType		= NPCType_Main;
	Guild		= GIL_NONE;

	Level		= 10;
	Voice		= 15;
	ID		= 0;

	senses 		= SENSE_HEAR | SENSE_SEE | SENSE_SMELL;
	senses_range 	= 3000;

	Mdl_SetVisual (self, "HUMANS.MDS");
	Mdl_SetVisualBody (self, "hum_body_Naked0", 4, 1, "Hum_Head_Pony", 9, 0, -1);

	start_aistate = ZS_ColorHelper_Hangaround;
};

instance DIA_ColorHelper_Exit (C_Info) {
	npc		= colorHelpo1;
	nr		= 999;
	condition	= Always_True;
	information	= Exit_Dialog;
	important	= FALSE;
	permanent	= TRUE;
	description	= DIALOG_ENDE;
};

/*
instance ColorHelper_Important (C_Info) {
	npc		= colorHelpo1;
	condition	= Always_False;
	important	= TRUE;
	permanent	= TRUE;
};
*/
var int colorHelperR;
var int colorHelperG;
var int colorHelperB;

instance DIA_ColorHelper_RED (C_Info) {
	npc		= colorHelpo1;
	nr		= 1;
	condition	= DIA_ColorHelper_RED_Condition;
	information	= DIA_ColorHelper_RED_Info;
	important	= FALSE;
	permanent	= TRUE;
	description	= "dummy";
};

func int DIA_ColorHelper_RED_Condition () {
	//These are in fact Global variables - we can exploit that for this feature - they will retain their value ;-)
	var string lastSpinnerID;

	//What is current InfoManagerSpinnerID ?
	if (Hlp_StrCmp (InfoManagerSpinnerID, "red")) {
		//Setup spinner if spinner ID has changed
		if (!Hlp_StrCmp (InfoManagerSpinnerID, lastSpinnerID)) {
			//Restore value
			InfoManagerSpinnerValue = colorHelperR;
		};

		//Page Up/Down quantity
		InfoManagerSpinnerPageSize = 5;
		
		//Min/Max value (Home/End keys)
		InfoManagerSpinnerValueMin = 0;
		InfoManagerSpinnerValueMax = 255;

		//Update 
		colorHelperR = InfoManagerSpinnerValue;
	};

	lastSpinnerID = InfoManagerSpinnerID;

	var string newDescription; newDescription = "";
	
	//Spinner ID CookMeat
	//newDescription = ConcatStrings (newDescription, "h@");
	newDescription = ConcatStrings (newDescription, "s@red h@");
	
	var string r; r = dec2hex (colorHelperR);
	var string g; g = dec2hex (colorHelperG);
	var string b; b = dec2hex (colorHelperB);
	
	r = STR_TrimL (r, "0");
	g = STR_TrimL (g, "0");
	b = STR_TrimL (b, "0");

	if (STR_Len(r) == 0) { r = "00"; };
	if (STR_Len(g) == 0) { g = "00"; };
	if (STR_Len(b) == 0) { b = "00"; };
	
	if (STR_Len(r) == 1) { r = ConcatStrings ("0", r); };
	if (STR_Len(g) == 1) { g = ConcatStrings ("0", g); };
	if (STR_Len(b) == 1) { b = ConcatStrings ("0", b); };

	newDescription = ConcatStrings (newDescription, r);
	newDescription = ConcatStrings (newDescription, g);
	newDescription = ConcatStrings (newDescription, b);

	newDescription = ConcatStrings (newDescription, " hs@");

	newDescription = ConcatStrings (newDescription, r);
	newDescription = ConcatStrings (newDescription, g);
	newDescription = ConcatStrings (newDescription, b);

	newDescription = ConcatStrings (newDescription, " ");

	newDescription = ConcatStrings (newDescription, r);
	newDescription = ConcatStrings (newDescription, g);
	newDescription = ConcatStrings (newDescription, b);

	newDescription = ConcatStrings (newDescription, " o@ac@:R (");

	newDescription = ConcatStrings (newDescription, IntToString (colorHelperR));
	newDescription = ConcatStrings (newDescription, "/");
	newDescription = ConcatStrings (newDescription, IntToString (255));
	newDescription = ConcatStrings (newDescription, ")~");

	//Update description
	DIA_ColorHelper_RED.description = newDescription;
	
	return TRUE;
};

func void DIA_ColorHelper_RED_Info () {
};

instance DIA_ColorHelper_GREEN (C_Info) {
	npc		= colorHelpo1;
	nr		= 2;
	condition	= DIA_ColorHelper_GREEN_Condition;
	information	= DIA_ColorHelper_GREEN_Info;
	important	= FALSE;
	permanent	= TRUE;
	description	= "dummy";
};

func int DIA_ColorHelper_GREEN_Condition () {
	//These are in fact Global variables - we can exploit that for this feature - they will retain their value ;-)
	var string lastSpinnerID;

	//What is current InfoManagerSpinnerID ?
	if (Hlp_StrCmp (InfoManagerSpinnerID, "green")) {
		//Setup spinner if spinner ID has changed
		if (!Hlp_StrCmp (InfoManagerSpinnerID, lastSpinnerID)) {
			//Restore value
			InfoManagerSpinnerValue = colorHelperG;
		};

		//Page Up/Down quantity
		InfoManagerSpinnerPageSize = 5;
		
		//Min/Max value (Home/End keys)
		InfoManagerSpinnerValueMin = 0;
		InfoManagerSpinnerValueMax = 255;

		//Update 
		colorHelperG = InfoManagerSpinnerValue;
	};

	lastSpinnerID = InfoManagerSpinnerID;

	var string newDescription; newDescription = "";
	
	//Spinner ID CookMeat
	//newDescription = ConcatStrings (newDescription, "h@");
	newDescription = ConcatStrings (newDescription, "s@green h@");
	
	var string r; r = dec2hex (colorHelperR);
	var string g; g = dec2hex (colorHelperG);
	var string b; b = dec2hex (colorHelperB);
	
	r = STR_TrimL (r, "0");
	g = STR_TrimL (g, "0");
	b = STR_TrimL (b, "0");

	if (STR_Len(r) == 0) { r = "00"; };
	if (STR_Len(g) == 0) { g = "00"; };
	if (STR_Len(b) == 0) { b = "00"; };
	
	if (STR_Len(r) == 1) { r = ConcatStrings ("0", r); };
	if (STR_Len(g) == 1) { g = ConcatStrings ("0", g); };
	if (STR_Len(b) == 1) { b = ConcatStrings ("0", b); };

	newDescription = ConcatStrings (newDescription, r);
	newDescription = ConcatStrings (newDescription, g);
	newDescription = ConcatStrings (newDescription, b);

	newDescription = ConcatStrings (newDescription, " hs@");

	newDescription = ConcatStrings (newDescription, r);
	newDescription = ConcatStrings (newDescription, g);
	newDescription = ConcatStrings (newDescription, b);

	newDescription = ConcatStrings (newDescription, " ");

	newDescription = ConcatStrings (newDescription, r);
	newDescription = ConcatStrings (newDescription, g);
	newDescription = ConcatStrings (newDescription, b);

	newDescription = ConcatStrings (newDescription, " o@ac@:G (");

	newDescription = ConcatStrings (newDescription, IntToString (colorHelperG));
	newDescription = ConcatStrings (newDescription, "/");
	newDescription = ConcatStrings (newDescription, IntToString (255));
	newDescription = ConcatStrings (newDescription, ")~");
	
	//Update description
	DIA_ColorHelper_GREEN.description = newDescription;
	
	return TRUE;
};

func void DIA_ColorHelper_GREEN_Info () {
};

instance DIA_ColorHelper_BLUE (C_Info) {
	npc		= colorHelpo1;
	nr		= 3;
	condition	= DIA_ColorHelper_BLUE_Condition;
	information	= DIA_ColorHelper_BLUE_Info;
	important	= FALSE;
	permanent	= TRUE;
	description	= "dummy";
};

func int DIA_ColorHelper_BLUE_Condition () {
	//These are in fact Global variables - we can exploit that for this feature - they will retain their value ;-)
	var string lastSpinnerID;

	//What is current InfoManagerSpinnerID ?
	if (Hlp_StrCmp (InfoManagerSpinnerID, "blue")) {
		//Setup spinner if spinner ID has changed
		if (!Hlp_StrCmp (InfoManagerSpinnerID, lastSpinnerID)) {
			//Restore value
			InfoManagerSpinnerValue = colorHelperB;
		};

		//Page Up/Down quantity
		InfoManagerSpinnerPageSize = 5;
		
		//Min/Max value (Home/End keys)
		InfoManagerSpinnerValueMin = 0;
		InfoManagerSpinnerValueMax = 255;

		//Update 
		colorHelperB = InfoManagerSpinnerValue;
	};

	lastSpinnerID = InfoManagerSpinnerID;

	var string newDescription; newDescription = "";
	
	//Spinner ID CookMeat
	//newDescription = ConcatStrings (newDescription, "h@");
	newDescription = ConcatStrings (newDescription, "s@blue h@");
	
	var string r; r = dec2hex (colorHelperR);
	var string g; g = dec2hex (colorHelperG);
	var string b; b = dec2hex (colorHelperB);
	
	r = STR_TrimL (r, "0");
	g = STR_TrimL (g, "0");
	b = STR_TrimL (b, "0");

	if (STR_Len(r) == 0) { r = "00"; };
	if (STR_Len(g) == 0) { g = "00"; };
	if (STR_Len(b) == 0) { b = "00"; };
	
	if (STR_Len(r) == 1) { r = ConcatStrings ("0", r); };
	if (STR_Len(g) == 1) { g = ConcatStrings ("0", g); };
	if (STR_Len(b) == 1) { b = ConcatStrings ("0", b); };

	newDescription = ConcatStrings (newDescription, r);
	newDescription = ConcatStrings (newDescription, g);
	newDescription = ConcatStrings (newDescription, b);

	newDescription = ConcatStrings (newDescription, " hs@");

	newDescription = ConcatStrings (newDescription, r);
	newDescription = ConcatStrings (newDescription, g);
	newDescription = ConcatStrings (newDescription, b);

	newDescription = ConcatStrings (newDescription, " ");

	newDescription = ConcatStrings (newDescription, r);
	newDescription = ConcatStrings (newDescription, g);
	newDescription = ConcatStrings (newDescription, b);

	newDescription = ConcatStrings (newDescription, " o@ac@:B (");

	newDescription = ConcatStrings (newDescription, IntToString (colorHelperB));
	newDescription = ConcatStrings (newDescription, "/");
	newDescription = ConcatStrings (newDescription, IntToString (255));
	newDescription = ConcatStrings (newDescription, ")~");
	
	//Update description
	DIA_ColorHelper_BLUE.description = newDescription;
	
	return TRUE;
};

func void DIA_ColorHelper_BLUE_Info () {
};
