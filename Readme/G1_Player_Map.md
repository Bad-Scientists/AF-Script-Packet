## G1 Player Map
 - Improves Map handling on key `M`:
   - player's animation will not be reset if he does not have map. This removes exploit in which pressing `M` repeatedly would allow you to jump in air.
   - with API function `PlayerMap_GetMapInstance` you can define which map will be opened (in each world you can open different default map)
		- if `PlayerMap_GetMapInstance` does not specify priority - then we reopen last used map.
		- by default we use vanilla logic - we try to open: `ITWRWORLDMAP_ORC`, then `ITWRWORLDMAP`
		- if none of aboce are in the inventory, first available map in inventory is selected.

Init function: `G1_PlayerMap_Init();`

[API file](../Standalone-Packages/G1-PlayerMap/playerMap_API.d)
