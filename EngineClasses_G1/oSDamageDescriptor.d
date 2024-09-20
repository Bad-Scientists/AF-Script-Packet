const int oEDamageIndex_Barrier = 0;
const int oEDamageIndex_Blunt = 1;
const int oEDamageIndex_Edge = 2;
const int oEDamageIndex_Fire = 3;
const int oEDamageIndex_Fly = 4;
const int oEDamageIndex_Magic = 5;
const int oEDamageIndex_Point = 6;
const int oEDamageIndex_Fall = 7;
const int oEDamageIndex_MAX = 8;

const int oEDamageType_Unknown = 0;
const int oEDamageType_Barrier = 1;
const int oEDamageType_Blunt = 2;
const int oEDamageType_Edge = 4;
const int oEDamageType_Fire = 8;
const int oEDamageType_Fly = 16;
const int oEDamageType_Magic = 32;
const int oEDamageType_Point = 64;
const int oEDamageType_Fall = 128;

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
	var int validFields; //0 unsigned long dwFieldsValid;

	var int attackerVob; //4 zCVob* pVobAttacker;
	var int attackerNpc; //8 oCNpc* pNpcAttacker;
	var int hitVob; //12 zCVob* pVobHit;
	var int hitPfx; //16 oCVisualFX* pFXHit;
	var int itemWeapon; //20 oCItem* pItemWeapon;

	var int spellID; //24 unsigned long nSpellID;
	var int spellLevel; //28 unsigned long nSpellLevel;

	var int dmgMode; //32 unsigned long enuModeDamage;
	var int weaponMode; //36 unsigned long enuModeWeapon;

	var int dmgArray[8]; //40 unsigned long aryDamage[oEDamageIndex_MAX];
	var int dmgTotal; //72 float fDamageTotal;
	var int dmgMultiplier; //76 float fDamageMultiplier;

	var int locationHit[3]; //80 zVEC3 vecLocationHit;
	var int directionFly[3]; //92 zVEC3 vecDirectionFly;

	var string visualFXStr; //104 zSTRING strVisualFX;

	var int duration; //124 float fTimeDuration;
	var int interval; //128 float fTimeInterval;
	var int dmgPerInterval; //132 float fDamagePerInterval;

	var int bitfield; //136 1 -> Once, 2 -> finished, 4 -> isDead, 8 -> isUnconscious
	//group {
	//unsigned long bOnce : 1;
	//unsigned long bFinished : 1;
	//unsigned long bIsDead : 1;
	//unsigned long bIsUnconscious : 1;
	//unsigned long lReserved : 28;
	//};

	var int azimuth; //140 float fAzimuth;
	var int elevation; //144 float fElevation;
	var int timeCurrent; //148 float fTimeCurrent;
	var int dmgReal; //152 float fDamageReal;
	var int dmgEffective; //156 float fDamageEffective;
	var int dmgArrayEffective[8]; //160 unsigned long aryDamageEffective[oEDamageIndex_MAX];
	var int vobParticleFX; //192 zCVob* pVobParticleFX;
	var int particleFX; //196 zCParticleFX* pParticleFX;
	var int visualFX; //200 oCVisualFX* pVisualFX;
};
