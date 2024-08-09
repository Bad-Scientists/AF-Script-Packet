## G12 Torch HotKey

## :construction: :construction_worker: :construction: README UNDER CONSTRUCTION :construction: :construction_worker: :construction:

 - Simple feature for improving torches:
   - Adds hotkey 'keyTorchToggleKey' for putting on and removing torch (`T` key by default).
   - Fixes issue of disappearing torches in G2 NoTR.
   - Compatible with sprint mode. It reapplies overlay HUMANS_SPRINT.MDS when torch is removed & equipped.
   - Rekindles all vobs that were lit by player. List can be maintained in 'torchHotKey_API.d' file in array TORCH_ASC_MODELS [];
   - Ctrl + 'keyTorchToggleKey' will put torch to right hand - you can throw torch away in G1 with Union.

```c++
/*
 *	Torch HotKey
 *		- enables hotkey 'keyTorchToggleKey' equipping torches
 *		- 'keyTorchToggleKey' can be defined either in Gothic.ini file section [KEYS] or mod.ini file section [KEYS] (master is Gothic.ini)
 *		- if 'keyTorchToggleKey' is not defined then by default KEY_T will be used for toggling
 *		- fixes issue of disappearing torches in G2A (by removing DontWriteIntoArchive flag from ItLsTorchBurning)
 *			- number of torches in players inventory will be stored prior game saving
 *			- when game is loaded script will compare number of torches in players inventory, if there is torch missing it will add it back
 *			- if player was carrying torch, script will put it back to hand
 *		- compatible with sprint mode (reapplies overlay HUMANS_SPRINT.MDS when torch is removed/equipped)
 *		- will re-lit all mobs, that were previously lit by player (list can be maintained in file 'torchHotKey_API.d' in array TORCH_ASC_MODELS [];
 *		- Ctrl + 'keyTorchToggleKey' will put torch to right hand (with Union you can throw torch away in G1)
 */
```

Init function: `G12_TorchHotKey_Init ();`
1. Required LeGo flags: `LeGo_HookEngine | LeGo_Gamestate`.
