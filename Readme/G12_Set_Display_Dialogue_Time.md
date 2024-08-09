## G12 Set display dialogue distance
 - this 'patch' allows you to adjust min max display time for subtitles
 - default Gothic display time is min: `1000` and max `8000` ms
 - if you don't have audio voice over and you have long sentences subtitles will cut off after 8 seconds ...

<ins>Usage:</ins>
```c++
func void Init_Global() {
	//Ikarus initialization
	MEM_InitAll();

	//Update display dialogue min / max time
	G12_SetDisplayDialogueTime(1500, 30000);
};
```