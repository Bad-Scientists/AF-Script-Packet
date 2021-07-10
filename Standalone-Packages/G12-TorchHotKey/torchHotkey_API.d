const int TORCH_ASC_MODELS_MAX		= 11;

const string TORCH_ASC_MODELS [TORCH_ASC_MODELS_MAX] = {
	"FIREPLACE_GROUND.ASC",		//Ohniste
	"FIREPLACE_GROUND2.ASC",	//Ohniste s kotlikom
	"FIREPLACE_GROUND_USE.ASC",	//?
	"FIREPLACE_HIGH.ASC",		//Louc kovova
	"FIREPLACE_HIGH2.ASC",		//Louc drevena
	"FIREPLACE_NCSTONE.ASC",	//Louc v Novom tabore
	"FIREPLACE_NCSTONE2.ASC",	//Louc v Novom tabore (?)
	"FIREPLACE_PCHIGH.ASC",		//?
	"FIREPLACE_PCHIGH2.ASC",	//Louc v Tabore v bazinach - kovova
	"FIREPLACE_MIDDLE.ASC",		//Louc na stene
	"FIREPLACE_ORCSTAND.ASC"	//
};

//We need to make sure these overlays are re-applied when removing torch
const int PC_TORCHHOTKEY_REAPPLYOVERLAYS_MAX = 2;

const string PC_TORCHHOTKEY_REAPPLYOVERLAYS [PC_TORCHHOTKEY_REAPPLYOVERLAYS_MAX] = {
	"HUMANS_SPRINT.MDS",
	"DUMMY"
};
