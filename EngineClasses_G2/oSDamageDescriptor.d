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
const int oEDamageDescFlag_Attacker = 1;
const int oEDamageDescFlag_Npc = 2;
const int oEDamageDescFlag_Inflictor = 4;
const int oEDamageDescFlag_Weapon = 8;
const int oEDamageDescFlag_VisualFX = 16;
const int oEDamageDescFlag_SpellID = 32;
const int oEDamageDescFlag_SpellLevel = 64;
const int oEDamageDescFlag_DamageType = 128;
const int oEDamageDescFlag_WeaponType = 256;
const int oEDamageDescFlag_Damage = 512;
const int oEDamageDescFlag_HitLocation = 1024;
const int oEDamageDescFlag_FlyDirection = 2048;
const int oEDamageDescFlag_OverlayActivate = 4096;
const int oEDamageDescFlag_OverlayInterval = 8192;
const int oEDamageDescFlag_OverlayDuration = 16384;
const int oEDamageDescFlag_OverlayDamage = 32768;

//const int oEDamageDescFlag_ForceDWORD			= 0xffffffff

const int bitfield_oSDamageDescriptor_bOnce = 1;
const int bitfield_oSDamageDescriptor_bFinished = 2;
const int bitfield_oSDamageDescriptor_bIsDead = 4;
const int bitfield_oSDamageDescriptor_bIsUnconscious = 8;

class oSDamageDescriptor {
	var int validFields; 		//0 unsigned long dwFieldsValid;

	var int attackerVob; 		//4 zCVob* pVobAttacker;
	var int attackerNpc; 		//8 oCNpc* pNpcAttacker;
	var int hitVob; 		//12 zCVob* pVobHit;
	var int hitPfx;			//16 oCVisualFX* pFXHit;
	var int itemWeapon; 		//20 oCItem* pItemWeapon;

	var int spellID;		//24 unsigned long nSpellID;
	var int spellCat; 		//28 unsigned long nSpellCat;
	var int spellLevel;		//32 unsigned long nSpellLevel;

	var int dmgMode;		//36 unsigned long enuModeDamage;
	var int weaponMode;		//40 unsigned long enuModeWeapon;

	var int dmgArray[8];	 	//44 unsigned long aryDamage[oEDamageIndex_MAX];
	var int dmgTotal;		//76 float fDamageTotal;
	var int dmgMultiplier;		//80 float fDamageMultiplier;

	var int locationHit[3]; 	//84 zVEC3 vecLocationHit;
	var int directionFly[3];	//96 zVEC3 vecDirectionFly;

	var string visualFXStr;		//108 zSTRING strVisualFX;

	var int duration;		//128 float fTimeDuration;
	var int interval; 		//132 float fTimeInterval;
	var int dmgPerInterval;		//136 float fDamagePerInterval;
	var int dmgDontKill;		//140 int bDamageDontKill;

	var int bitfield; //144 1 -> Once, 2 -> finished, 4 -> isDead, 8 -> isUnconscious
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