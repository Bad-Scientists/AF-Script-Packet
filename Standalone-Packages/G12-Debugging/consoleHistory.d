//Custom constant for custom automcomplete logic
const int ConsoleAutocompletion_Parser = 255;
const int ConsoleAutocompletion_Waynet = 256;

var string consoleAutocompleteCommand;
var string consoleAutocompleteSuggestion;

/*
 *	Simple feature - keeping console commands history
 *	 - you can list through your last 64 console commands by pressing KEY_INSERT (loop), KEY_UP, KEY_DOWN
 *	 - added custom autocompletion for certain console commands - suggestions are printed to console view, KEY_RIGHT will autocomplete suggested word
 */
func void _hook_zCConsole_HandleEvent () {
	//Don't handle any keys if inactive!
	var int cur_console; cur_console = zCConsole_Get_Cur_Console ();
	if (!cur_console) { return; };

	var int key; key = MEM_ReadInt (ESP + 4);

	var int cancel; cancel = FALSE;
	var int update; update = FALSE;

	//Of course we can go for 255 ... but 64 should be more than enough :)
	const int HISTORYENTRIES_MAX = 64;

	var int historyEntries;
	var string history[HISTORYENTRIES_MAX];

	var int i;
	var int j;
	var int historyIndex;

	var int autocompleted;
	var int numWords;
	var string newInstr;

	var string command;
	var string consoleCommand;
	var string storeCommand; storeCommand = STR_EMPTY;

	//0x008DC5A0 class zCConsole zcon
	var zCConsole console; console = _^ (zcon_address);

	const int init = 0;
	if (!init) {
		consoleAutocompleteCommand = STR_EMPTY;
		consoleAutocompleteSuggestion = STR_EMPTY;
		historyEntries = -1;
		init = 1;
	};

	//Support for NumPad
	if (key == KEY_NUMPAD0) { key = KEY_0; update = TRUE; };
	if (key == KEY_NUMPAD1) { key = KEY_1; update = TRUE; };
	if (key == KEY_NUMPAD2) { key = KEY_2; update = TRUE; };
	if (key == KEY_NUMPAD3) { key = KEY_3; update = TRUE; };
	if (key == KEY_NUMPAD4) { key = KEY_4; update = TRUE; };
	if (key == KEY_NUMPAD5) { key = KEY_5; update = TRUE; };
	if (key == KEY_NUMPAD6) { key = KEY_6; update = TRUE; };
	if (key == KEY_NUMPAD7) { key = KEY_7; update = TRUE; };
	if (key == KEY_NUMPAD8) { key = KEY_8; update = TRUE; };
	if (key == KEY_NUMPAD9) { key = KEY_9; update = TRUE; };

	if (key == KEY_NUMPADENTER) { key = KEY_RETURN; update = TRUE; };

	if (key == KEY_BACKSLASH) {
		console.instr = ConcatStrings (console.instr, BtoC (92));
		zCConsole_Update ();
		cancel = TRUE;
	};

	//Controls - up / down keys list through history
	if ((key == KEY_UPARROW) || (key == KEY_INSERT)) {
		historyIndex -= 1;
	};

	if (key == KEY_DOWNARROW) {
		historyIndex += 1;
	};

	if ((key == KEY_DOWNARROW) || (key == KEY_UPARROW) || (key == KEY_INSERT))
	{
		//Store already typed in console input
		console.instr = STR_TrimChar (console.instr, CHR_SPACE);
		storeCommand = console.instr;

		if (historyIndex < 0) {
			//Clear
			historyIndex = -1;
			console.instr = STR_EMPTY;
		} else
		if (historyIndex > historyEntries) {
			//Clear
			historyIndex = historyEntries + 1;
			console.instr = STR_EMPTY;
		} else {
			//Read from history
			command = MEM_ReadStringArray (_@s (history), historyIndex);
			console.instr = command;
		};

		zCConsole_Update ();
		cancel = TRUE;
	};

	//Append auto-completion suggestion
	if (key == KEY_TAB) {
		if (STR_Len (consoleAutocompleteSuggestion)) {
			consoleCommand = consoleAutocompleteCommand;
			consoleCommand = ConcatStrings (consoleCommand, STR_SPACE);
			consoleCommand = ConcatStrings (consoleCommand, consoleAutocompleteSuggestion);
			consoleCommand = ConcatStrings (consoleCommand, STR_SPACE);

			consoleCommand = STR_Lower (consoleCommand);

			console.instr = consoleCommand;
			zCConsole_Update ();
			cancel = TRUE;

			consoleAutocompleteCommand = STR_EMPTY;
			consoleAutocompleteSuggestion = STR_EMPTY;
		};
	};

	if (key == KEY_RETURN) {
		//Reset index
		historyIndex = -1;

		//Trim input
		console.instr = STR_TrimChar (console.instr, CHR_SPACE);
		storeCommand = console.instr;
	};

	//Store only non-blanks
	if (STR_Len (storeCommand)) {
		//Shift history by 1 to the right
		i = HISTORYENTRIES_MAX - 1;
		historyEntries = 0;

		while (i > 0);
			command = MEM_ReadStringArray (_@s (history), i - 1);

			if (historyEntries == 0) {
				if (STR_Len (command)) { historyEntries = i; };
			};

			//If command is already in the list - run one more loop
			if (Hlp_StrCmp (command, storeCommand)) {
				j = i;

				//Shift history from this index to left
				while (j < (HISTORYENTRIES_MAX - 1));
					command = MEM_ReadStringArray (_@s (history), j + 1);
					MEM_WriteStringArray (_@s (history), j, command);
					j += 1;
				end;
			} else {
				MEM_WriteStringArray (_@s (history), i, command);
			};

			i -= 1;
		end;

		MEM_WriteStringArray (_@s (history), 0, storeCommand);
	};

	//Our own implementation of autocompletion
	if ((!update) && (!cancel)) {
		var string c; c = GetKeyChar (key);

		if (STR_Len (c)) {
			autocompleted = FALSE;
			newInstr = ConcatStrings (console.instr, c);
			newInstr = STR_Upper (newInstr);

			numWords = STR_GetWords (newInstr);

			//Reset
			consoleAutocompleteCommand = STR_EMPTY;
			consoleAutocompleteSuggestion = STR_EMPTY;

			//Autocomplete only from word 2 onwards
			if (numWords > 1) {
				//--> re-build console command(s)

				//Get keyword
				consoleCommand = STR_PickWord (newInstr, 0);

				i = 1;
				while (i + 1 <= numWords);
					//Get type (do we have custom auto-completion ?)
					var int autocompletionType; autocompletionType = zCConsole_GetType (consoleCommand);

					if ((autocompletionType == ConsoleAutocompletion_Parser) || (autocompletionType == ConsoleAutocompletion_Waynet))
					{
						//Get the rest of the command - this is what we will try to auto-complete
						consoleAutocompleteSuggestion = myStr_SubStr (newInstr, STR_Len (consoleCommand) + 1, STR_Len (newInstr));
					};

					//Default console parser autocompletion
					//Npc console parser autocompletion
					if (autocompletionType == ConsoleAutocompletion_Parser) {
						autocompleted = zCParser_AutoCompletion (console.cparser, _@s (consoleAutocompleteSuggestion));
					};

					//Waypoint autocompletion
					if (autocompletionType == ConsoleAutocompletion_Waynet) {
						autocompleted = WayNet_AutoCompletion (_@s (consoleAutocompleteSuggestion));
					};

					if (autoCompleted) {
						consoleAutocompleteCommand = consoleCommand;

						var string lastSuggestion;

						if (!Hlp_StrCmp (lastSuggestion, consoleAutocompleteSuggestion)) {
							zCViewPtr_Printwin (console.conview, consoleAutocompleteSuggestion);
						};

						lastSuggestion = consoleAutocompleteSuggestion;
						break;
					};

					consoleCommand = ConcatStrings (consoleCommand, STR_SPACE);
					consoleCommand = ConcatStrings (consoleCommand, STR_PickWord (newInstr, i));

					i += 1;
				end;
				//<--
			};
		};
	};

	if (update) {
		zCInputCallback_SetKey(key);
	};

	if (cancel) {
		zCInputCallback_SetKey(0);
	};
};

func void _hook_zCConsole_Show () {
	//Update auto-completion (engine commands are updated after Init_Global call? so updating auto-completion when opened)

	//Custom autocompletion for 'create' command
	zCConsole_UpdateType ("create", ConsoleAutocompletion_Parser);

	//Custom autocompletion for 'goto waypoint' command
	zCConsole_UpdateType ("goto waypoint", ConsoleAutocompletion_Waynet);
};

func void G12_ConsoleHistory_Init () {
	const int once = 0;

	if (!once) {
		//0x006D8BA0 public: virtual int __thiscall zCConsole::HandleEvent(int)
		const int zCConsole__HandleEvent_G1 = 7179168;

		//0x00781DB0 public: virtual int __thiscall zCConsole::HandleEvent(int)
		const int zCConsole__HandleEvent_G2 = 7871920;
		HookEngine (MEMINT_SwitchG1G2 (zCConsole__HandleEvent_G1, zCConsole__HandleEvent_G2), 5, "_hook_zCConsole_HandleEvent");

		//0x006DA2D0 public: void __thiscall zCConsole::Show(void)
		const int zCConsole__Show_G1 = 7185104;

		//0x00783460 public: void __thiscall zCConsole::Show(void)
		const int zCConsole__Show_G2 = 7877728;
		HookEngine (MEMINT_SwitchG1G2 (zCConsole__Show_G1, zCConsole__Show_G2), 6, "_hook_zCConsole_Show");

		once = 1;
	};
};
