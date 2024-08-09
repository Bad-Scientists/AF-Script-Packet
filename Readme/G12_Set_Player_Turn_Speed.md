## G12 Set player turn speed
 - this 'patch' allows you to adjust players turning speed
 - default Gothic turn speed is: `0.1` - fairly slow if you are using only keyboard
 
<ins>Usage:</ins>
```c++
func void Init_Global() {
	//Ikarus initialization
	MEM_InitAll();

	//Default turn speed is 0.1
	G12_SetPlayerTurnSpeed(castToIntF(0.18));
};
```