## G12 Focus
 - Slightly improved version of LeGo focusnames feature:
   - color of focus is changed:
      * to orange if chest/mob is locked by special key, cannot be picklocked and player does not have key
      * to yellow if chest/mob is locked by special key and player does not have key but it can be picklocked
      * to yellow if chest/mob can be picklocked
      * to green if chest/mob is unlocked and not empty

   - renames chests from `MOBNAME_CHEST` to `MOBNAME_CHEST_EMPTY` and crates from `MOBNAME_CRATE` to `MOBNAME_CRATE_EMPTY` when they are empty and vice versa.

Init function: `G12_Focus_Init();`

<ins>Should not be used together with LeGo flag</ins> `LeGo_Focusnames`.

[API file](../Standalone-Packages/G12-Focus/focus_API.d)
