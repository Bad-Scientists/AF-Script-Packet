## G12 Set mag book turn time
 - this 'patch' allows you to adjust time it takes for mag book to turn between spell items
 - default Gothic turn time speed is 250 ms

<ins>Usage:</ins>
```c++
func void Init_Global() {
	//Ikarus initialization
	MEM_InitAll();

	//Update turn time speed
	G12_SetMagBookTurnTime(500);
};
```