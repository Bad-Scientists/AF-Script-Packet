/*
 *	Simple feature - keeping console commands history
 *	 - you can list through your last 64 console commands by pressing KEY_INSERT
 *	 - console command currently entered will be cleared by KEY_ESCAPE
 */
func void _hook_zCConsole_HandleEvent () {
	var int key; key = MEM_ReadInt (ESP + 4);

	var int cancel; cancel = FALSE;
	var int update; update = FALSE;

	//Of course we can go for 255 ... but 64 should be more than enough :)
	const int HISTORYENTRIES_MAX = 64;

	var string history[HISTORYENTRIES_MAX];

	var int i;
	var int j;
	var int historyIndex;

	var string command;

	//0x008DC5A0 class zCConsole zcon
	var zCConsole console; console = _^ (zcon_address);

	//Escape - if console is not empty will clear console & reset historyIndex
	if (key == KEY_ESCAPE) {
		if (STR_Len (console.instr)) {
			historyIndex = 0;
			console.instr = "";

			key = KEY_BACK;
			update = TRUE;
		};
	};

	if (key == KEY_INSERT) {
		historyIndex = Clamp (historyIndex, 0, HISTORYENTRIES_MAX);

		command = MEM_ReadStringArray (_@s (history), historyIndex);
		console.lastcommand = command;

		if (STR_Len (command)) {
			historyIndex += 1;
			if (historyIndex == HISTORYENTRIES_MAX) {
				historyIndex = 0;
			};
		} else {
			command = MEM_ReadStringArray (_@s (history), 0);
			console.lastcommand = command;
			historyIndex = 1;
		};
	};

	if (key == KEY_RETURN) {
		//Reset index
		historyIndex = 0;

		//Trim input
		console.instr = STR_Trim (console.instr, " ");

		//Store only non-blanks
		if (STR_Len (console.instr)) {
			//Shift history by 1 to the right
			i = HISTORYENTRIES_MAX - 1;

			while (i > 0);
				command = MEM_ReadStringArray (_@s (history), i - 1);

				//If command is already in the list - run one more loop
				if (Hlp_StrCmp (command, console.instr)) {
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

			MEM_WriteStringArray (_@s (history), 0, console.instr);
		};
	};

	if (update) {
		MEM_WriteInt (ESP + 4, key);
		EDI = key;
	};

	if (cancel) {
		//EDI has to be also nulled
		MEM_WriteInt (ESP + 4, 0);
		EDI = 0;
	};
};

func void G12_ConsoleHistory_Init () {
	const int once = 0;

	if (!once) {
		//0x006D8BA0 public: virtual int __thiscall zCConsole::HandleEvent(int)
		const int zCConsole__HandleEvent_G1 = 7179168;

		//0x00781DB0 public: virtual int __thiscall zCConsole::HandleEvent(int)
		const int zCConsole__HandleEvent_G2 = 7871920;

		HookEngine (MEMINT_SwitchG1G2 (zCConsole__HandleEvent_G1, zCConsole__HandleEvent_G2), 5, "_hook_zCConsole_HandleEvent");
		once = 1;
	};
};
