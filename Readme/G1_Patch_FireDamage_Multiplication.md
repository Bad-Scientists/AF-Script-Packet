## G1 Patch firedamage multiplication
 - this patch fixes fire damage multiplication exploit:
    - function `oCNpc::OnDamage_Hit` checks for weapon mode
    - if attackers **current** weapon mode is `3`, `4`, `5`, `6` (`NPC_WEAPON_1HS`, `NPC_WEAPON_2HS`, `NPC_WEAPON_BOW`, `NPC_WEAPON_CBOW`)
    - if attackers talent skill for specified weapon > 0, then damage multiplier is multiplied by `DAM_CRITICAL_MULTIPLIER`
    - problem occurs when damage was caused by fire spells - which will create event `EV_DAMAGE_PER_FRAME` with reference to attacker
    - as soon as attacker draws melee weapon for example, this burning event will multiply damage by multiplier `DAM_CRITICAL_MULTIPLIER` causing <ins>exponential</ins> increased of dealt damage

Init function: `G1_PatchFireDamageMultiplication();`
