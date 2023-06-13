/*
Copy this function outside of the script packet - define your own logic if required.

Aivars are variables - they are unpredictable and thus modder should NEVER expect them to be same across all Gothic scripts
In Replay Mod - I am using my own logic for aivars (using getter & setter methods, using bitmask to store multiple true/false 'aivars' in one variable ...)

func void Hero_SetInvincible (var int value) {
	hero.aivar [AIV_Invincible] = value;
};
*/
