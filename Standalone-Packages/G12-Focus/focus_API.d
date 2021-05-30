const string MOBNAME_CRATE_EMPTY = "Empty box";
const string MOBNAME_CHEST_EMPTY = "Empty chest";

//--
const int PC_ChangeFocus_Lockable		= 1;
const int PC_ChangeFocus_NpcAttitude		= 2;
const int PC_ChangeFocus_RenameEmptyChests	= 4;

const int PC_ChangeFocus_Flags			= PC_ChangeFocus_Lockable | PC_ChangeFocus_RenameEmptyChests;
//--

func int ColorDefault__Focus () { return + RGBA (255, 255, 255, 255); };		//White

func int ColorLockedKey__Focus () { return + RGBA (255, 128, 0, 255); };		//Orange

func int ColorLockedPickLocks__Focus () { return + RGBA (255, 255, 0, 255); };		//Yellow

func int ColorLockedKeyPickLocks__Focus () { return + RGBA (255, 255, 0, 255); };	//Yellow

func int ColorLockedHasKey__Focus () { return + RGBA (255, 255, 0, 255); };		//Yellow

//--

func int ColorFriendly__Focus () { return + RGBA (102, 255, 178, 255); };		//Green

func int ColorNeutral__Focus () { return + RGBA (255, 255, 255, 255); };		//White

func int ColorAngry__Focus () { return + RGBA (255, 128, 000, 255); };			//Orange

func int ColorHostile__Focus () { return + RGBA (255, 070, 070, 255); };		//Red
