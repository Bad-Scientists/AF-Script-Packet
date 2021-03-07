/*
	typedef enum oEIndexDamage {
	oEDamageIndex_Barrier,
	oEDamageIndex_Blunt,
	oEDamageIndex_Edge,
	oEDamageIndex_Fire,
	oEDamageIndex_Fly,
	oEDamageIndex_Magic,
	oEDamageIndex_Point,
	oEDamageIndex_Fall,
	oEDamageIndex_MAX
	} oEDamageIndex, oEProtectionIndex; 
*/

/*
	typedef enum oEFlagsDamageDescriptor {
	oEDamageDescFlag_Attacker        = 1,
	oEDamageDescFlag_Npc             = 2,
	oEDamageDescFlag_Inflictor       = 4,
	oEDamageDescFlag_Weapon          = 8,
	oEDamageDescFlag_VisualFX        = 16,
	oEDamageDescFlag_SpellID         = 32,
	oEDamageDescFlag_SpellLevel      = 64,
	oEDamageDescFlag_DamageType      = 128,
	oEDamageDescFlag_WeaponType      = 256,
	oEDamageDescFlag_Damage          = 512,
	oEDamageDescFlag_HitLocation     = 1024,
	oEDamageDescFlag_FlyDirection    = 2048,
	oEDamageDescFlag_OverlayActivate = 4096,
	oEDamageDescFlag_OverlayInterval = 8192,
	oEDamageDescFlag_OverlayDuration = 16384,
	oEDamageDescFlag_OverlayDamage   = 32768,
	oEDamageDescFlag_ForceDWORD      = 0xffffffff
	} oEDescDamageFlags, oEFlagsDamageDesc;
*/

class oSDamageDescriptor {
	var int validFields; 		//unsigned long dwFieldsValid;
	
	var int attackerVob; 		//zCVob* pVobAttacker;
	var int attackerNpc; 		//oCNpc* pNpcAttacker;
	var int hitVob; 		//zCVob* pVobHit;
	var int hitPfx;			//oCVisualFX* pFXHit;
	var int itemWeapon; 		//oCItem* pItemWeapon;

	var int spellID;		//unsigned long nSpellID;
	var int spellCat; 		//unsigned long nSpellCat;
	var int spellLevel;		//unsigned long nSpellLevel;
	
	var int dmgMode;		//unsigned long enuModeDamage;
	var int weaponMode;		//unsigned long enuModeWeapon;
	
	var int dmgArray[8];	 	//unsigned long aryDamage[oEDamageIndex_MAX];
	var int dmgTotal;		//float fDamageTotal;
	var int dmgMultiplier;		//float fDamageMultiplier;
	
	var int locationHit[3]; 	//zVEC3 vecLocationHit;
	var int directionFly[3];	//zVEC3 vecDirectionFly;
	
	var string visualFXStr;		//zSTRING strVisualFX;
	
	var int duration;		//float fTimeDuration;
	var int interval; 		//float fTimeInterval;
	var int dmgPerInterval;		//float fDamagePerInterval;
	var int dmgDontKill;		//int bDamageDontKill;
	
	var int bitfield; // 1 -> Once, 2 -> finished, 4 -> isDead, 8 -> isUnconscious
	//group {
	//unsigned long bOnce          : 1;
	//unsigned long bFinished      : 1;
	//unsigned long bIsDead        : 1;
	//unsigned long bIsUnconscious : 1;
	//unsigned long lReserved      : 28;
	//};

	var int azimuth;		//float fAzimuth;
	var int elevation;		//float fElevation;
	var int timeCurrent;		//float fTimeCurrent;
	var int dmgReal;		//float fDamageReal;
	var int dmgEffective;		//float fDamageEffective;
	var int dmgArrayEffective[8];	//unsigned long aryDamageEffective[oEDamageIndex_MAX];
	var int vobParticleFX;		//zCVob* pVobParticleFX;
	var int particleFX;		//zCParticleFX* pParticleFX;
	var int visualFX;		//oCVisualFX* pVisualFX; 
};