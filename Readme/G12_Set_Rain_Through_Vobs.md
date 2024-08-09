## G12 Set rain through vobs
 - this 'patch' enables/disables raytrace check ignoring vobs - by deault it is raining through vobs in Gothic (probably an oversight)
 - default Gothic turn speed is: `0.1` - fairly slow if you are using only keyboard
 - created by **Showdown & Lehona** [(original post)](https://forum.worldofplayers.de/forum/threads/1299679-Skriptpaket-Ikarus-4/page11?p=24735929&viewfull=1#post24735929)

<ins>Usage:</ins>
```c++
func void Init_Global() {
	//Ikarus initialization
	MEM_InitAll();

	//Turn off raining through vobs
	G12_SetRainThroughVobs(FALSE);
};
```