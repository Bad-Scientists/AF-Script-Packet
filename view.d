/*
 *	Some useful functions for LeGo Views & engine zCView
 *
 *	Naming convention updated to match LeGo logic
 *
 *	 ViewPtr* functions - working with view pointers
 *	 View* functions - working with handles
 */

func void zCView_CheckTimedText (var int viewPtr) {
	//0x006FE0E0 public: void __thiscall zCView::CheckTimedText(void)
	const int zCView__CheckTimedText_G1 = 6753728;

	//0x007A7C50 public: void __thiscall zCView::CheckTimedText(void)
	const int zCView__CheckTimedText_G2 = 7410288;

	if (!viewPtr) { return; };

	const int call = 0;
	if (CALL_Begin (call)) {
		CALL__thiscall (_@ (viewPtr), MEMINT_SwitchG1G2 (zCView__CheckTimedText_G1, zCView__CheckTimedText_G2));
		call = CALL_End ();
	};
};

//Releases list.data
//Deletes list.next
func void zCList_zCViewText_DeleteListDatas (var int listPtr) {
	//0x00702EA0 public: void __thiscall zCList<class zCViewText>::DeleteListDatas(void)
	const int zCList_zCViewText__DeleteListDatas_G1 = 7351968;

	//0x007ACAB0 public: void __thiscall zCList<class zCViewText>::DeleteListDatas(void)
	const int zCList_zCViewText__DeleteListDatas_G2 = 8047280;

	if (!listPtr) { return; };

	const int call = 0;
	if (CALL_Begin (call)) {
		CALL__thiscall (_@ (listPtr), MEMINT_SwitchG1G2 (zCList_zCViewText__DeleteListDatas_G1, zCList_zCViewText__DeleteListDatas_G2));
		call = CALL_End ();
	};
};

/*
 *	zCView_DeleteText alternatives
 */

//Not sure why ... but when I tried this with some engine views - game crashed:
//23:710E016A (0x219BEE20 0x006E9208 0x008DCE50 0x00000000) MSVCR100.dll, free()+28 byte(s) .... <zError.cpp,#467>

//LeGo-devs informed, for now I will use this method ... we can change it if needed later :)
//https://forum.worldofplayers.de/forum/threads/1505251-Skriptpaket-LeGo-4/page27?p=27126692#post27126692

func void ViewPtr_DeleteText_Safe (var int viewPtr) {
	if (!viewPtr) { return; };
	var zCView v; v = _^ (viewPtr);

	//Destroy list
	zCList_zCViewText_DeleteListDatas (_@ (v.textLines_data));
};

func void View_DeleteText_Safe (var int hndl) {
	if (!Hlp_IsValidHandle (hndl)) { return; };
	var int viewPtr; viewPtr = getPtr (hndl);

	ViewPtr_DeleteText_Safe (viewPtr);
};

//TODO: remove and replace with ViewPtr_AlignText once it is fixed in LeGo
func void ViewPtr_AlignText_Fixed (var int viewPtr, var int margin) {
	if (!viewPtr) { return; };

	var zCView v;  v = _^ (viewPtr);
	var int lp; lp = v.textLines_next;
	var zCList l;
	var zCViewText vt;

	var int width;

	if(margin == 0) {
		while(lp);
			l = _^(lp);
			vt = _^(l.data);
			//When I tried to center some views created by engine vsizex was set to PS_VMAX, psizex contained correct value (these views are confusing ...)
			//width = Print_ToVirtual(Print_GetStringWidthPtr(vt.text, vt.font), PS_X) * PS_VMAX / v.vsizex;
			width = Print_ToVirtual(Print_GetStringWidthPtr(vt.text, vt.font), PS_X) * PS_VMAX / Print_ToVirtual (v.psizex, PS_X);
			//vt.posx = (PS_VMAX / 2) - (width / 2);
			vt.posx = (PS_VMAX - width) / 2;
			lp = l.next;
		end;
	}
	else if(margin > 0) {
		while(lp);
			l = _^(lp);
			vt = _^(l.data);
			vt.posx = margin;
			lp = l.next;
		end;
	}
	else {
		while(lp);
			l = _^(lp);
			vt = _^(l.data);
			//width = Print_ToVirtual(Print_GetStringWidthPtr(vt.text, vt.font), PS_X) * PS_VMAX / v.vsizex;
			width = Print_ToVirtual(Print_GetStringWidthPtr(vt.text, vt.font), PS_X) * PS_VMAX / Print_ToVirtual (v.psizex, PS_X);
			//LeGo bug - subtraction of negative number is addition ... so we need to add negative number ...
			//vt.posx = PS_VMAX - width - margin;
			vt.posx = PS_VMAX - width + margin;
			lp = l.next;
		end;
	};
};

func void ViewPtr_SetTextAndFontColor (var int viewPtr, var string texts, var int color) {
	if (!viewPtr) { return; };

	var zCView v; v = _^ (viewPtr);
	var string fontName; fontName = Print_GetFontName (v.font);
	var int fontHeight; fontHeight = Print_ToVirtual (Print_GetFontHeight (fontName), v.psizey);

	var int cnt; cnt = STR_SplitCount (texts, Print_LineSeperator);
	var string text;

	var zCList l;
	var zCViewText vt;

	var int vposX;
	var int vposY;

	vposX = v.vposX;
	vposY = v.vposY;

	//Update existing zCViewText objects
	var int list; list = v.textLines_next;

	var int i; i = 0;
	var int flagListExtended; flagListExtended = FALSE;

	if (list) {
		l = _^ (list);

		while (i < cnt);
			text = STR_Split(texts, Print_LineSeperator, i);

			if (list) {
				//Update existing text view
				l = _^ (list);
				if (l.data) {
					vt = _^ (l.data);

					vt.text = text;

					if (color != -1) {
						vt.color = color;
						vt.colored = (color != -1);
					};

					var string vtFontName; vtFontName = Print_GetFontName (vt.font);
					var int vtFontHeight; vtFontHeight = Print_ToVirtual (Print_GetFontHeight (vtFontName), v.psizey);

					vposY = vt.posY + vtFontHeight;
				};

				list = l.next;
			} else {
				//Add new text view
				ViewPtr_AddText (viewPtr, vposX, vposY, text, fontName, color);
				vposY += fontHeight;

				flagListExtended = TRUE;
			};

			i += 1;
		end;

		//Remove extra text views
		if (!flagListExtended) {
			//Not sure why ... but when I tried this with some engine views - game crashed:
			//23:710E016A (0x219BEE20 0x006E9208 0x008DCE50 0x00000000) MSVCR100.dll, free()+28 byte(s) .... <zError.cpp,#467>
			//var int n; n = l.next;
			//l.next = 0;

			//while (n);
			//	var zCList del; del = _^ (n);

			//	n = del.next;
			//	MEM_Free (_@ (del));
			//end;

			if (l.next) {
				//Dettach list
				var int n; n = l.next;
				l.next = 0;

				//Destroy the rest of the list
				l = _^ (n);
				zCList_zCViewText_DeleteListDatas (_@ (l.data));
			};
		};
	} else {
		//Or add texts - if they were not added yet
		ViewPtr_AddText (viewPtr, vposX, vposY, texts, fontName, color);
	};

	ViewPtr_SetAlphaAll (viewPtr, v.alpha);
};

func void ViewPtr_SetTextMarginAndFontColor (var int viewPtr, var string texts, var int color, var int margin) {
	ViewPtr_SetTextAndFontColor (viewPtr, texts, color);
	ViewPtr_AlignText_Fixed (viewPtr, margin);
};

//-- View_SetTextAndFontColor

func void View_SetTextAndFontColor (var int hndl, var string texts, var int color) {
	if (!Hlp_IsValidHandle (hndl)) { return; };
	var int viewPtr; viewPtr = getPtr (hndl);
	ViewPtr_SetTextAndFontColor (viewPtr, texts, color);
};

func void View_SetTextMarginAndFontColor (var int hndl, var string texts, var int color, var int margin) {
	if (!Hlp_IsValidHandle (hndl)) { return; };
	var int viewPtr; viewPtr = getPtr (hndl);
	ViewPtr_SetTextMarginAndFontColor (viewPtr, texts, color, margin);
};

//-- View_SetText

func void View_SetText (var int hndl, var string texts) {
	ViewPtr_SetTextAndFontColor (hndl, texts, -1);
};

func void View_SetTextMargin (var int hndl, var string texts, var int margin) {
	View_SetTextMarginAndFontColor (hndl, texts, -1, margin);
};

//--

func void ViewPtr_SetFontColor (var int viewPtr, var int color) {
	if (!viewPtr) { return; };
	var zCView view; view = _^ (viewPtr);

	if (view.textLines_next) {
		var zCList list; list = _^ (view.textLines_next);
		var zCViewText viewT; viewT = _^ (list.data);

		viewT.color = color;
		viewT.colored = TRUE;
	};
};

func void View_SetFontColor (var int hndl, var int color) {
	if (!Hlp_IsValidHandle (hndl)) { return; };
	var int viewPtr; viewPtr = getPtr (hndl);

	ViewPtr_SetFontColor (viewPtr, color);
};

func int ViewPtr_OnDesk (var int viewPtr) {
	if (!viewPtr) { return FALSE; };
	var zCView view; view = _^ (viewPtr);
	return view.onDesk;
};

func int View_OnDesk (var int hndl) {
	if (!Hlp_IsValidHandle (hndl)) { return FALSE; };
	var int viewPtr; viewPtr = getPtr (hndl);
	return + ViewPtr_OnDesk (viewPtr);
};

func int ViewPtr_IsOpen (var int viewPtr) {
	if (!viewPtr) { return FALSE; };
	var zCView view; view = _^ (viewPtr);
	return view.IsOpen;
};

func int View_IsOpen (var int hndl) {
	if (!Hlp_IsValidHandle (hndl)) { return FALSE; };
	var int viewPtr; viewPtr = getPtr (hndl);
	return + ViewPtr_IsOpen (viewPtr);
};

func void ViewPtr_SetAlphaFunc (var int viewPtr, var int alphaFunc) {
	if (!viewPtr) { return; };
	var zCView view; view = _^ (viewPtr);
	view.alphaFunc = alphaFunc;
};

func void View_SetAlphaFunc (var int hndl, var int alphaFunc) {
	if (!Hlp_IsValidHandle (hndl)) { return; };
	var int viewPtr; viewPtr = getPtr (hndl);
	ViewPtr_SetAlphaFunc (viewPtr, alphaFunc);
};

//-- engine stuff

func int zCView_Noise_IsActive () {
	const int cGAME_VIEW_NOISE = 5;

	var int ptr; ptr = MEM_Game.array_view [cGAME_VIEW_NOISE];

	if (ptr) {
		var zCView v; v = _^ (ptr);
		return v.ondesk;
	};

	return FALSE;
};
