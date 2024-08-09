## G12 Fade away
 - Gothic engine has most likely unfinished built-in feature which fades away dead Npcs and removes their bodies
 - this feature uses API function `C_Npc_IsSummoned` to recognize which creatures (I expect mostly summoned) can be faded away
 - you can however use `oCNpc_StartFadeAway(self);` on any Npc that you want to fade away. (for example from `ZS_Dead` state, or from whenever you want :smile:)

    [![G1&2 Fade away](https://img.youtube.com/vi/0MdiT97w59c/0.jpg)](https://www.youtube.com/watch?v=0MdiT97w59c)

:warning: Warning :warning: do not use with `hero` game will crash if you call it with player.

Init function: `G12_FadeAway_Init();`

[API file](../Standalone-Packages/G12-FadeAway/fadeAway_API.d)

You can use these extra functions to work with fade away feature:
```c++
//fadeAwayTimeF is Ikarus float miliseconds mkf(8000) - 8 seconds
void oCNpc_StartFadeAway(var int slfInstance); //Npc will fade away (default engine time 5s)
void oCNpc_StartFadeAway_Ext(var int slfInstance, var int fadeAwayTimeF); //Npc will fade away, but you can specify time by yourself
int oCNpc_IsFadingAway(var int slfInstance); //returns true if Npc is fading away
```
