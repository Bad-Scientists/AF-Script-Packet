## G12 Set display dialogue distance
 - G1 dialogue distance is by default `500` ... that's not enough, very often because of this distance subtitles will not display at all when talking to Npc.
 - this 'patch' allows you to set custom distance:

<ins>Usage:</ins>
```c++
func void Init_Global() {
	//Ikarus initialization
	MEM_InitAll();

	//Update display dialogue distance. Default G1 500
	G12_SetDisplayDialogueDistance(1500);
};
```