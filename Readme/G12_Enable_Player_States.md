## G12 Enable Player States
 - AI states that you can use on player character are hardcoded in the engine. Following states are used in vanilla:
   * G1: `ZS_ASSESSMAGIC, ZS_ASSESSSTOPMAGIC, ZS_MAGICFREEZE, ZS_SHORTZAPPED, ZS_ZAPPED, ZS_PYRO, ZS_MAGICSLEEP, ZS_MAGICFEAR`
   * G2: `ZS_ASSESSMAGIC, ZS_ASSESSSTOPMAGIC, ZS_MAGICFREEZE, ZS_WHIRLWIND, ZS_SHORTZAPPED, ZS_ZAPPED, ZS_PYRO, ZS_MAGICSLEEP`

 - this feature allows you to enable additional AI states via API function `C_CanPlayerUseAIState`

Init function: `G12_EnablePlayerStates_Init ();`

[API file](../Standalone-Packages/G12-EnablePlayerStates/enablePlayerStates_API.d)
