/*
 *	Initializes console
 */
func void Game_InitConsole () {
	//0x00645280 void __cdecl Game_InitConsole(void)
	const int Game_InitConsole_G1 = 6574720;

	//0x00673470 void __cdecl Game_InitConsole(void)
	const int Game_InitConsole_G2 = 6763632;

	CALL__cdecl (MEMINT_SwitchG1G2 (Game_InitConsole_G1, Game_InitConsole_G2));
};

/*
 *	Evaluate console command
 *	 - console has to be initialized first with Game_InitConsole
 *	Usage: zCConsole_Evaluate ("toggle desktop")
 */
func void zCConsole_Evaluate (var string command) {
	//0x006DB5D0 public: int __thiscall zCConsole::Evaluate(class zSTRING const &)
	const int zCConsole__Evaluate_G1 = 7189968;

	//0x00724E20 public: int __thiscall zCConsole::Evaluate(class zSTRING const &)
	const int zCConsole__Evaluate_G2 = 7491104;

	//0x008DC5A0 class zCConsole zcon
	//const int zcon_address_G1 = 9291168;

	CALL_zStringPtrParam (command);
	CALL__thiscall (zcon_address, MEMINT_SwitchG1G2 (zCConsole__Evaluate_G1, zCConsole__Evaluate_G2));
};

/*
 *	Shows console
 */
func void zCConsole_Show () {
	//0x006DA2D0 public: void __thiscall zCConsole::Show(void)
	const int zCConsole__Show_G1 = 7185104;

	//0x00783460 public: void __thiscall zCConsole::Show(void)
	const int zCConsole__Show_G2 = 7877728;

	CALL__thiscall (zcon_address, MEMINT_SwitchG1G2 (zCConsole__Show_G1, zCConsole__Show_G2));
};

/*
 *	Hides console
 */
func void zCConsole_Hide () {
	//0x006DA530 public: void __thiscall zCConsole::Hide(void)
	const int zCConsole__Hide_G1 = 7185712;

	//0x007836B0 public: void __thiscall zCConsole::Hide(void)
	const int zCConsole__Hide_G2 = 7878320;

	CALL__thiscall (zcon_address, MEMINT_SwitchG1G2 (zCConsole__Hide_G1, zCConsole__Hide_G2));
};

/*
 *	Emulates test mode key pressing
 *	Usage: oCGame_TestKeys (KEY_F6)
 */
func void oCGame_TestKeys (var int key) {
	//0x00660000 private: int __thiscall oCGame::TestKeys(int)
	const int oCGame__TestKeys_G1 = 6684672;

	//0x0069FAC0 private: int __thiscall oCGame::TestKeys(int)
	const int oCGame__TestKeys_G2 = 6945472;

	CALL_IntParam (key);
	CALL__thiscall (_@ (MEM_Game), MEMINT_SwitchG1G2 (oCGame__TestKeys_G1, oCGame__TestKeys_G2));
};