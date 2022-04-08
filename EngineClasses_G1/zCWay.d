// sizeof 20h
class zCWay {
	var int _vtbl;
	var int cost;	//int cost;          // sizeof 04h    offset 04h
	var int usedCtr;	//int usedCtr;       // sizeof 04h    offset 08h
	var int chasmDepth;	//float chasmDepth;  // sizeof 04h    offset 0Ch
	var int chasm;	//int chasm;         // sizeof 04h    offset 10h
	var int jump;	//int jump;          // sizeof 04h    offset 14h
	var int left;	//zCWaypoint* left;  // sizeof 04h    offset 18h
	var int right;	//zCWaypoint* right; // sizeof 04h    offset 1Ch
};

instance zCWay@ (zCWay);