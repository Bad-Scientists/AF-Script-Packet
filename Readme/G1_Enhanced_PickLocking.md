## G1 Enhanced Pick Locking
 - Package emulates G2 NoTR behavior for PickLocking:

   - If `oCMobLockable` requires special key that is not in hero's inventory, he cannot interact with locked doors or chests. This interaction won't break any picklocks.
   - If players `NPC_TALENT_PICKLOCK` level > 0 BUT does not have pickLocks, he will not be able to interact with locked doors/chests.
   - Hero will say whether he needs to learn skill, get picklocks, or specific key.
   - The pickLock failrate (breaking) is based on players' dexterity. Higher the stat, lower the chance to break picklocks.
   - Customizable minimal failrate.
   - Customizable option to prevent player from picklocking if players talent `NPC_TALENT_PICKLOCK` level is 0.
		- If player has key that can open doors/chests, he can interact with the object without talent `NPC_TALENT_PICKLOCK`.
   - Customizable option that allows player to open any lock with `ItKe_MasterKey`

Init function: `G1_EnhancedPickLocking_Init();`

[API file](../Standalone-Packages/G1-EnhancedPickLocking/enhancedPickLocking_API.d)
