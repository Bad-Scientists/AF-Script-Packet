
# Amazing Features Script Packet (status: WIP)

Authors: [Auronen](https://github.com/auronen) & [Fawkes](https://github.com/Fawkes-dev)

This script packet aims to consolidate as many useful functions as possible with the main goal being giving modders extensive feature set that they can enable by calling a single 'init' function. Future plans include adding wiki with examples explaining all the features.

<details><summary>Credits</summary>
We are using a collection of many scripts from the entire Gothic community.

None of this would be possible without Ikarus & LeGo and without modders willing to share their amazing works & ideas.

<ins>Thank you</ins>: **Sektenspinner**, **Lehona**, **Gottfried**, **mud-freak**(Szapp), **Neconspictor**, **OrcWarrior**, **Dalai Zoll**, **Cryp18Struct**, **L-Titan** (Gelaos), **Damianut**, **Neocromicon**, **rezu93** (we will try to keep list up to date :smile: )
Special thanks goes to: **helpo1** :crown: & **Kaiser**, who endlessly debugged many features :sparkles:
</details>

## Requirements:

1. [Ikarus](https://github.com/Lehona/Ikarus) (1.2.3)
1. [LeGo](https://github.com/Lehona/LeGo) (2.9.0)

<details><summary>AFSP Initialization</summary>

1. Make sure both **Ikarus** & **LeGo** are parsed from your `Gothic.src` file.
1. Copy all files from this repository to your Gothic work folder `_work\data\Scripts\Content\AF-Script-Packet`.
1. **G1** users will have to add function `Init_Global();` into their Startup.d file (as it is not there by default). Call `Init_Global ();` from all `INIT_*()` functions (don't call it from `INIT_SUB_*()` functions).

1. Update file `_work\data\Scripts\Content\Gothic.src` - add new line **after** parsed **LeGo**:
    * G1: `AF-Script-Packet\_headers_G1_All.src`
    * G2 NoTR: `AF-Script-Packet\_headers_G2_All.src`

1. **Important note:** in case of both G1 & G2 NoTR - each feature has to be initialized by calling respective `*_Init` function from your `Init_Global();` function in `Startup.d` file.
</details>

## API files:

[API file logic](Readme/API.md)

## Features:

[G1 Weapon stacking / splitting](Readme/G1_Weapon_Stacking.md)

[G1 Ever looming barrier](Readme/G1_Ever_Looming_Barrier.md)

[G1 Enhanced trading](Readme/G1_Enhanced_Trading.md)

[G1 Enhanced picklocking](Readme/G1_Enhanced_PickLocking.md)

[G1 Player map](Readme/G1_Player_Map.md)

[G1 Better inventory controls](Readme/G1_Better_Inventory_Controls.md)

[G1 Enhanced pickpocketing](Readme/G1_Enhanced_PickPocketing.md)

---

[G12 Enhanced information manager](Readme/G12_Enhanced_Information_Manager.md)

[G12 Enhanced oCTriggerScript](Readme/G12_Enhanced_oCTriggerScript.md)

[G12 Enable player states](Readme/G12_Enable_Player_States.md)

[G12 Picklock helper](Readme/G12_PickLock_Helper.md)

[G12 Prevent looting](Readme/G12_Prevent_Looting.md)

[G12 Sprint mode](Readme/G12_Sprint_Mode.md)

[G12 Torch hotkey](Readme/G12_Torch_HotKey.md)

[G12 No ammo print](Readme/G12_No_Ammo_Print.md)

[G12 Vob transport](Readme/G12_Vob_Transport.md)

[G12 Focus](Readme/G12_Focus.md)

[G12 Inventory item preview](Readme/G12_Inventory_Item_Preview.md)

[G12 Better bars](Readme/G12_Better_Bars.md)

[G12 Log dialogues](Readme/G12_Log_Dialogues.md)

[G12 Spacer spawn](Readme/G12_Spacer_Spawn.md)

[G12 Fade away](Readme/G12_Fade_Away.md)

[G12 Despawn only if empty](Readme/G12_Despawn_Only_If_Empty.md)

[G12 Rain control](Readme/G12_Rain_Control.md)

[G12 Add perceptions](Readme/G12_Add_Perceptions.md)

[G12 Moon phases](Readme/G12_Moon_Phases.md)

[G12 Equip control](Readme/G12_Equip_Control.md)

[G12 Multi-teleport](Readme/G12_Multi_Teleport.md)

## Patches:

[G12 Set display dialogue distance](Readme/G12_Set_Display_Dialogue_Distance.md)

[G12 Set display dialogue time](Readme/G12_Set_Display_Dialogue_Time.md)

[G12 Set player turn speed](Readme/G12_Set_Player_Turn_Speed.md)

[G12 Set rain through vobs](Readme/G12_Set_Rain_Through_Vobs.md)

[G12 Mag book turn time](Readme/G12_Set_Mag_Book_Turn_Time.md)

---

[G1 Patch firedamage multiplication](Readme/G1_Patch_FireDamage_Multiplication.md)

---

[G12 Patch fight combos](Readme/G12_Patch_Fight_Combos.md)

## Debugging:

[G12 Debugging](Readme/G12_Debugging.md)

## Powered by AFSP:
*Features that are not included in script packet*

[G12 Custom item description](Readme/G12_CustomItemDescription.md)
