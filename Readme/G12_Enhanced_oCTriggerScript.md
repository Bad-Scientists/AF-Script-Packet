## G12 Enhanced oCTriggerScript
 - Package adds new options for `oCTriggerScript` objects:
   - `zCTrigger_bitfield_callEventFuncs` flag will call additional event functions `oCTriggerScript.scriptFunc` + `_OnTouch`, `_OnTrigger`, `_OnContact`, `_OnUnTouch`.
   - `zCTrigger_bitfield_reactToOnContact` flag introduces `_OnContact` event. It repeatedly fires as long as there is any object in `oCTriggerScript._zCVob_touchVobList_numInArray`.

`_OnTouch`, `_OnUnTouch` events

[example_FirePlaceSavingPolicy.d](../Standalone-Packages/G12-EnhancedoCTriggerScript/example_FirePlaceSavingPolicy.d)
 - demonstrates how you can add `oCTriggerScript` objects to all fireplaces in your world which will allow you to only save game near a fireplace:

    [![G1&2 Enhanced oCTriggerScript](https://img.youtube.com/vi/U9IVhqSixW0/0.jpg)](https://www.youtube.com/watch?v=U9IVhqSixW0)

`_OnContact` event

[example_FirePlaceFireDamage.d](../Standalone-Packages/G12-EnhancedoCTriggerScript/example_FirePlaceFireDamage.d)
 - demonstrates how you can add `oCTriggerScript` objects to all fireplaces in your world that will burn every Npc that is **in contact** with such fireplace:

    [![G1&2 Enhanced oCTriggerScript](https://img.youtube.com/vi/7KYLjUITbi4/0.jpg)](https://www.youtube.com/watch?v=7KYLjUITbi4)

Init function: `G12_EnhancedoCTriggerScript_Init ();`
