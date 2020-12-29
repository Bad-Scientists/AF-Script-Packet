/*func string Print3Int(var int x1, var int x2, var int x3)
{
	var int s0; s0 = SB_New();
	SBi(x1);
	SB(", ");
	SBi(x2);
	SB(", ");
	SBi(x3);
	SB_Use(s0);
	var string str; str = SB_ToString();
	SB_Destroy();
	return str;
};
*/
/*
	v 0.01
	Authors: Auronen & Fawkes
	Useful print functions
	Powered by Ikarus and LeGo  // <3
	
	Usage:
	
	// for var int
	MEM_Info(PV("myVar",myVar));
	
	// for var string
	MEM_Info(PVs("myVar",myVar));
*/

func string PV(var string varName, var int value){
	var int s0; s0 = SB_New();
	var string output;
	SB(varName);
	SB(" = ");
	SBi(value);
	SB_Use(s0);
	output = SB_ToString();
	SB_Destroy();
	return output;
};

func string PVs(var string varName, var string value){
	var int s0; s0 = SB_New();
	var string output;
	SB(varName);
	SB(" = ");
	SB(value);
	SB_Use(s0);
	output = SB_ToString();
	SB_Destroy();
	return output;
};