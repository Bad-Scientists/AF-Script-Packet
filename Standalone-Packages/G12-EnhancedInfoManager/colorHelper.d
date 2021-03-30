FUNC VOID ZS_ColorHelper_Hangaround () {
	NPC_PercEnable (self, PERC_ASSESSTALK, B_AssessTalk);
};

FUNC VOID ZS_ColorHelper_Hangaround_Loop () {};

FUNC VOID ZS_ColorHelper_Hangaround_End () {};

var int colorHelperR;
var int colorHelperG;
var int colorHelperB;
var int colorHelperA;

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

	// reset
	colorHelperR = 255;
	colorHelperG = 255;
	colorHelperB = 255;
	colorHelperA = 255;

	start_aistate = ZS_ColorHelper_Hangaround;
};

instance DIA_ColorHelper_Exit (C_Info) {
	npc		= colorHelpo1;
	nr		= 999;
	condition	= DIA_ColorHelper_Exit_Condition;
	information	= DIA_ColorHelper_Exit_Info;
	important	= FALSE;
	permanent	= TRUE;
	description	= DIALOG_ENDE;
};

func int DIA_ColorHelper_Exit_Condition () {
	return TRUE;
};

func void DIA_ColorHelper_Exit_Info () {
	AI_StopProcessInfos (self);
};

func string DIA_ColorHelper_BuildHexColor (var int r, var int g, var int b, var int a) {
	var string _r; _r = dec2hex (r);
	var string _g; _g = dec2hex (g);
	var string _b; _b = dec2hex (b);
	var string _a; _a = dec2hex (a);
	
	_r = STR_TrimL (_r, "0");
	_g = STR_TrimL (_g, "0");
	_b = STR_TrimL (_b, "0");
	_a = STR_TrimL (_a, "0");

	if (STR_Len(_r) == 0) { _r = "00"; };
	if (STR_Len(_g) == 0) { _g = "00"; };
	if (STR_Len(_b) == 0) { _b = "00"; };
	if (STR_Len(_a) == 0) { _a = "00"; };
	
	if (STR_Len(_r) == 1) { _r = ConcatStrings ("0", _r); };
	if (STR_Len(_g) == 1) { _g = ConcatStrings ("0", _g); };
	if (STR_Len(_b) == 1) { _b = ConcatStrings ("0", _b); };
	if (STR_Len(_a) == 1) { _a = ConcatStrings ("0", _a); };

	var string s; s = "";

	s = ConcatStrings (s, _r);
	s = ConcatStrings (s, _g);
	s = ConcatStrings (s, _b);
	s = ConcatStrings (s, _a);

	s = ConcatStrings (s, " hs@");

	s = ConcatStrings (s, _r);
	s = ConcatStrings (s, _g);
	s = ConcatStrings (s, _b);
	s = ConcatStrings (s, _a);

	s = ConcatStrings (s, " ");

	s = ConcatStrings (s, _r);
	s = ConcatStrings (s, _g);
	s = ConcatStrings (s, _b);
	s = ConcatStrings (s, _a);

	return s;
};

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

	newDescription = ConcatStrings (newDescription, DIA_ColorHelper_BuildHexColor (colorHelperR, colorHelperG, colorHelperB, colorHelperA));
	
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
	
	newDescription = ConcatStrings (newDescription, DIA_ColorHelper_BuildHexColor (colorHelperR, colorHelperG, colorHelperB, colorHelperA));

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
	
	newDescription = ConcatStrings (newDescription, DIA_ColorHelper_BuildHexColor (colorHelperR, colorHelperG, colorHelperB, colorHelperA));

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

instance DIA_ColorHelper_ALPHA (C_Info) {
	npc		= colorHelpo1;
	nr		= 4;
	condition	= DIA_ColorHelper_ALPHA_Condition;
	information	= DIA_ColorHelper_ALPHA_Info;
	important	= FALSE;
	permanent	= TRUE;
	description	= "dummy";
};

func int DIA_ColorHelper_ALPHA_Condition () {
	//These are in fact Global variables - we can exploit that for this feature - they will retain their value ;-)
	var string lastSpinnerID;

	//What is current InfoManagerSpinnerID ?
	if (Hlp_StrCmp (InfoManagerSpinnerID, "alpha")) {
		//Setup spinner if spinner ID has changed
		if (!Hlp_StrCmp (InfoManagerSpinnerID, lastSpinnerID)) {
			//Restore value
			InfoManagerSpinnerValue = colorHelperA;
		};

		//Page Up/Down quantity
		InfoManagerSpinnerPageSize = 5;
		
		//Min/Max value (Home/End keys)
		InfoManagerSpinnerValueMin = 0;
		InfoManagerSpinnerValueMax = 255;

		//Update 
		colorHelperA = InfoManagerSpinnerValue;
	};

	lastSpinnerID = InfoManagerSpinnerID;

	var string newDescription; newDescription = "";
	
	//Spinner ID CookMeat
	//newDescription = ConcatStrings (newDescription, "h@");
	newDescription = ConcatStrings (newDescription, "s@alpha h@");
	
	newDescription = ConcatStrings (newDescription, DIA_ColorHelper_BuildHexColor (colorHelperR, colorHelperG, colorHelperB, colorHelperA));

	newDescription = ConcatStrings (newDescription, " o@ac@:A (");

	newDescription = ConcatStrings (newDescription, IntToString (colorHelperA));
	newDescription = ConcatStrings (newDescription, "/");
	newDescription = ConcatStrings (newDescription, IntToString (255));
	newDescription = ConcatStrings (newDescription, ")~");
	
	//Update description
	DIA_ColorHelper_ALPHA.description = newDescription;
	
	return TRUE;
};

func void DIA_ColorHelper_ALPHA_Info () {
};
