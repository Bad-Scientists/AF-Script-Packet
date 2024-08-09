## Patch fight combos
 - with this patch Npcs can now use combos! :smile:

1H example

 [![G1&2 Patch fight combos 1H](https://img.youtube.com/vi/HCvjVH-VwQE/0.jpg)](https://www.youtube.com/watch?v=HCvjVH-VwQE)

2H example

 [![G1&2 Patch fight combos 2H](https://img.youtube.com/vi/kAyYs_UJVfQ/0.jpg)](https://www.youtube.com/watch?v=kAyYs_UJVfQ)

Init function: `G12_PatchFightCombos ();`

 - G1 FAI uses combos - defined FAI_HUMAN_MASTER.D - but they were not working ...
 - G2 NOTR **DOES NOT USE** combos by default - you will have to update your Fight AI logic

```
MOVE_MASTERATTACK is the one that performs combo:
Fight AI entries:
MOVE_SIDEATTACK			Left --> Right
MOVE_FRONTATTACK		Left --> Foward
or				Foward --> Right

MOVE_TRIPLEATTACK		Foward --> Right -->Left
or				Left --> Right --> Foward

MOVE_WHIRLATTACK		Left --> Right --> Left --> Right
MOVE_MASTERATTACK		Left --> Right --> [Foward --> Foward --> Foward --> Foward] == combo
```
