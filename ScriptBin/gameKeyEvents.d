/*
 *	Author: szapp (mud-freak)
 *	Original post: https://forum.worldofplayers.de/forum/threads/1495001-Scriptsammlung-ScriptBin/page4?p=26055992#post26055992
 *
 *	2020-07-20 updated because of: https://forum.worldofplayers.de/forum/threads/1495001-Scriptsammlung-ScriptBin/page7?p=26482235&viewfull=1#post26482235
 */

/*
 * gameKeyEvents.d
 * Source: https://forum.worldofplayers.de/forum/threads/?p=26055992
 *
 * Handle key events from the player the way Gothic is doing it
 *
 * - Requires Ikarus, LeGo (HookEngine)
 * - Compatible with Gothic 1 and Gothic 2
 *
 * Instructions
 * - Initialize from Init_Global with
 *     Game_KeyEventInit();
 * - Add your key event detection in Game_KeyEvent
 */

/*
 *	[MODED]
 */

var int GameKeyEvent_Key;
var int GameKeyEvent_Pressed;

//[Internal variables]
var int _GameKeyEvent_Event;
var int _GameKeyEvent_Event_Handled;

func void GameKeyEvent_AddListener (var func f) {
	Event_AddOnce (_GameKeyEvent_Event, f);
};

func void GameKeyEvent_RemoveListener (var func f) {
	Event_Remove (_GameKeyEvent_Event, f);
};

func void GameKeyEvent_KeyHandled () {
	_GameKeyEvent_Event_Handled = TRUE;
};

/*
 * Customizable function to handle key events (pressed is FALSE: key is held, pressed is TRUE: key press onset)
 * This function has to return TRUE if the given key was handled, and FALSE otherwise
 */
func int Game_KeyEvent (var int key, var int pressed) {
	_GameKeyEvent_Event_Handled = FALSE;

	GameKeyEvent_Key = key;
	GameKeyEvent_Pressed = pressed;

	Event_Execute (_GameKeyEvent_Event, 0);

	return _GameKeyEvent_Event_Handled;
};

/*
 * This function is called during the running game when a key is pressed/held that is not already handled by Gothic
 */
func void Game_KeyEvent_() {
	if (Game_KeyEvent (ESI, MEM_ReadByte (MEMINT_KeyToggle_Offset + ESI))) {
		MEM_WriteByte (MEMINT_KeyToggle_Offset + ESI, 0); // Change toggle state only if key event was handled
	};
};

/*
 * Initialization function for custom key events
 */
func void Game_KeyEventInit () {
	if (!_GameKeyEvent_Event) {
		_GameKeyEvent_Event = Event_Create ();
	};
	const int once = 0;
	
	if (!once) {
		const int oCGame__HandleEvent_dfltCase_G1 = 6684404; //0x65FEF4
		const int oCGame__HandleEvent_dfltCase_G2 = 7328820; //0x6FD434

		HookEngineF(+MEMINT_SwitchG1G2(oCGame__HandleEvent_dfltCase_G1, oCGame__HandleEvent_dfltCase_G2), 6, Game_KeyEvent_);
		
		once = 1;
	};
};
