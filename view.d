/*
 *	Some useful functions for LeGo Views & engine zCView
 *
 *	Naming convention updated to match LeGo logic
 *
 *	 ViewPtr* functions - working with view pointers
 *	 View* functions - working with handles
 */

const int Print_TimeInfinite = -1073741824; //float -2

//	AFSP 'internal' constants for view intflags
//	 - engine is only using const int VIEW_I_TEXT = 1 << 0; //1
//	 - we will add our own constants to allow automated & easier view formatting

const int VIEW_AUTO_RESIZE			= 1 << 1; //2
const int VIEW_AUTO_ALPHA			= 1 << 2; //4
const int VIEW_TXT_VCENTER			= 1 << 3; //8
const int VIEW_TXT_HCENTER			= 1 << 4; //16

/*
 *	ViewPtr_SetIntFlags
 */
func void ViewPtr_SetIntFlags (var int viewPtr, var int intflags) {
	if (!viewPtr) { return; };
	var zCView v; v = _^ (viewPtr);
	v.intflags = v.intflags | intflags;
};

/*
 *	View_SetIntFlags
 */
func void View_SetIntFlags (var int hndl, var int intflags) {
	if (!Hlp_IsValidHandle (hndl)) { return; };
	var int viewPtr; viewPtr = getPtr (hndl);

	ViewPtr_SetIntFlags (viewPtr, intflags);
};

/*
 *	ViewPtr_AutoResize
 */
func void ViewPtr_AutoResize (var int viewPtr) {
	if (!viewPtr) { return; };
	var zCView v; v = _^ (viewPtr);

	var zCList l;
	var zCViewText vt;

	//Loop through text lines - figure out overall sizeX & sizeY
	var int psizeX; psizeX = 0;
	var int psizeY; psizeY = 0;

	var int width;

	var int list; list = v.textLines_next;

	while (list);
		l = _^ (list);

		if (l.data) {
			vt = _^ (l.data);
			psizeY += zCFont_GetFontY (vt.font);
			width = Font_GetStringWidthPtr(vt.text, vt.font);

			if (width > psizeX) {
				psizeX = width;
			};
		};

		list = l.next;
	end;

	if ((psizeX > v.psizeX) || (psizeY > v.psizeY)) {
		if (psizeX < v.psizeX) { psizeX = v.psizeX; };
		if (psizeY < v.psizeY) { psizeY = v.psizeY; };

		psizeX = Print_ToVirtual (psizeX, PS_X);
		psizeY = Print_ToVirtual (psizeY, PS_Y);

		ViewPtr_Resize (viewPtr, psizeX, psizeY);
	};
};

/*
 *	View_AutoResize
 */
func void View_AutoResize (var int hndl) {
	if (!Hlp_IsValidHandle (hndl)) { return; };
	var int viewPtr; viewPtr = getPtr (hndl);

	ViewPtr_AutoResize (viewPtr);
};

/*
 *	Centers text lines vertically in view
 */
func void ViewPtr_CenterTextLines (var int viewPtr) {
	if (!viewPtr) { return; };
	var zCView v; v = _^ (viewPtr);

	var zCList l;
	var zCViewText vt;

	//Loop through text lines - figure out overall sizeY
	var int psizeY; psizeY = 0;

	var int list; list = v.textLines_next;

	while (list);
		l = _^ (list);

		if (l.data) {
			vt = _^ (l.data);
			psizeY += zCFont_GetFontY (vt.font);
		};

		list = l.next;
	end;

	//Loop through text lines - update Y pos
	var int height; height = Print_ToVirtual(psizeY, PS_Y) * PS_VMAX / Print_ToVirtual (v.psizey, PS_Y);
	var int pposY; pposY = (PS_VMAX - height) / 2;

	list = v.textLines_next;

	while (list);
		l = _^ (list);

		if (l.data) {
			vt = _^ (l.data);
			vt.posY = pposY;

			//textLines_next.posY - virtual pos
			var int vtFontHeight; vtFontHeight = Print_ToVirtual (zCFont_GetFontY (vt.font), v.psizey);
			pposY += vtFontHeight;
		};

		list = l.next;
	end;
};

/*
 *	View_CenterTextLines
 */
func void View_CenterTextLines (var int hndl) {
	if (!Hlp_IsValidHandle (hndl)) { return; };
	var int viewPtr; viewPtr = getPtr (hndl);
	ViewPtr_CenterTextLines (viewPtr);
};

/*
 *	zCViewPtr_Printwin
 */
func void zCViewPtr_Printwin (var int viewPtr, var string s) {
	//0x00700D20 public: void __thiscall zCView::Printwin(class zSTRING const &)
	const int zCView__Printwin_G1 = 7343392;

	//0x007AA8D0 public: void __thiscall zCView::Printwin(class zSTRING const &)
	const int zCView__Printwin_G2 = 8038608;

	if (!viewPtr) { return; };

	//CALL_zStringPtrParam cannot be used in recyclable call
	CALL_zStringPtrParam (s);
	CALL__thiscall (viewPtr, MEMINT_SwitchG1G2 (zCView__Printwin_G1, zCView__Printwin_G2));
};

/*
 *	zCViewPtr_SetPos
 */
func void zCViewPtr_SetPos (var int viewPtr, var int vposx, var int vposy) {
	//0x006FDA10 public: void __thiscall zCView::SetPos(int,int)
	const int zCView__SetPos_G1 = 7330320;

	//0x007A75B0 public: void __thiscall zCView::SetPos(int,int)
	const int zCView__SetPos_G2 = 8025520;

	if (!viewPtr) { return; };

	const int call = 0;
	if (CALL_Begin (call)) {
		CALL_IntParam (_@ (vposy));
		CALL_IntParam (_@ (vposx));
		CALL__thiscall (_@ (viewPtr), MEMINT_SwitchG1G2 (zCView__SetPos_G1, zCView__SetPos_G2));
		call = CALL_End ();
	};
};

/*
 *	zCViewPtr_CheckTimedText
 */
func void zCViewPtr_CheckTimedText (var int viewPtr) {
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

/*
 *	zCList_zCViewText_DeleteListDatas
 */
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
 *	Gets font from view
 */
func int zCViewPtr_GetFont(var int viewPtr) {
	//0x006FFDC0 public: class zCFont * __thiscall zCView::GetFont(void)
	const int zCView__GetFont_G1 = 7339456;

	//0x007A9950 public: class zCFont * __thiscall zCView::GetFont(void)
	const int zCView__GetFont_G2 = 8034640;

	if (!viewPtr) { return 0; };

	var int retVal;

	const int call = 0;
	if (CALL_Begin (call)) {
		CALL_PutRetValTo(_@(retVal));
		CALL__thiscall (_@ (viewPtr), MEMINT_SwitchG1G2(zCView__GetFont_G1, zCView__GetFont_G2));
		call = CALL_End ();
	};

	return + retVal;
};

/*
 *	Prints centered timed colored text s at posY
 */
func void zCViewPtr_PrintTimedCX(var int viewPtr, var int posY, var string s, var int timeF, var int color) {
	//0x006FE230 public: void __thiscall zCView::PrintTimedCX(int,class zSTRING const &,float,struct zCOLOR *)
	const int zCView__PrintTimedCX_G1 = 7332400;

	//0x007A7DB0 public: void __thiscall zCView::PrintTimedCX(int,class zSTRING const &,float,struct zCOLOR *)
	const int zCView__PrintTimedCX_G2 = 8027568;

	if (!viewPtr) { return; };

	const int colorPtr = 0;

	if (!colorPtr) {
		colorPtr = MEM_Alloc (4);
	};

	MEM_WriteInt (colorPtr, color);

	CALL_PtrParam(colorPtr);
	CALL_FloatParam(timeF);
	CALL_zStringPtrParam(s);
	CALL_IntParam(posY);
	CALL__thiscall(viewPtr, MEMINT_SwitchG1G2 (zCView__PrintTimedCX_G1, zCView__PrintTimedCX_G2));
};

/*
 *	Prints timed colored text s at posX & posY
 */
func void zCViewPtr_PrintTimed(var int viewPtr, var int posX, var int posY, var string s, var int timeF, var int color) {
	//0x006FE1A0 public: void __thiscall zCView::PrintTimed(int,int,class zSTRING const &,float,struct zCOLOR *)
	const int zCView__PrintTimed_G1 = 7332256;

	//0x007A7D20 public: void __thiscall zCView::PrintTimed(int,int,class zSTRING const &,float,struct zCOLOR *)
	const int zCView__PrintTimed_G2 = 8027424;

	if (!viewPtr) { return; };

	const int colorPtr = 0;

	if (!colorPtr) {
		colorPtr = MEM_Alloc (4);
	};

	MEM_WriteInt (colorPtr, color);

	CALL_PtrParam(colorPtr);
	CALL_FloatParam(timeF);
	CALL_zStringPtrParam(s);
	CALL_IntParam(posY);
	CALL_IntParam(posX);
	CALL__thiscall(viewPtr, MEMINT_SwitchG1G2 (zCView__PrintTimed_G1, zCView__PrintTimed_G2));
};

/*
 *	zCView_DeleteText alternatives
 */

//Not sure why ... but when I tried this with some engine views - game crashed:
//23:710E016A (0x219BEE20 0x006E9208 0x008DCE50 0x00000000) MSVCR100.dll, free()+28 byte(s) .... <zError.cpp,#467>

//LeGo-devs informed, for now I will use this method ... we can change it if needed later :)
//https://forum.worldofplayers.de/forum/threads/1505251-Skriptpaket-LeGo-4/page27?p=27126692#post27126692

/*
 *	ViewPtr_DeleteText_Safe
 */
func void ViewPtr_DeleteText_Safe (var int viewPtr) {
	if (!viewPtr) { return; };
	var zCView v; v = _^ (viewPtr);

	//Destroy list
	zCList_zCViewText_DeleteListDatas (_@ (v.textLines_data));
};

/*
 *	View_DeleteText_Safe
 */
func void View_DeleteText_Safe (var int hndl) {
	if (!Hlp_IsValidHandle (hndl)) { return; };
	var int viewPtr; viewPtr = getPtr (hndl);

	ViewPtr_DeleteText_Safe (viewPtr);
};

/*
 *	ViewPtr_AlignText_Fixed
 */
//TODO: remove and replace with ViewPtr_AlignText once it is fixed in LeGo
func void ViewPtr_AlignText_Fixed (var int viewPtr, var int margin) {
	if (!viewPtr) { return; };

	var zCView v; v = _^ (viewPtr);
	var int lp; lp = v.textLines_next;
	var zCList l;
	var zCViewText vt;

	var int width;

	if(margin == 0) {
		while(lp);
			l = _^(lp);
			vt = _^(l.data);
			//When I tried to center some views created by engine vsizex was set to PS_VMAX, psizex contained correct value (these views are confusing ...)
			//width = Print_ToVirtual(Font_GetStringWidthPtr(vt.text, vt.font), PS_X) * PS_VMAX / v.vsizex;
			width = Print_ToVirtual(Font_GetStringWidthPtr(vt.text, vt.font), PS_X) * PS_VMAX / Print_ToVirtual (v.psizex, PS_X);
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
			//width = Print_ToVirtual(Font_GetStringWidthPtr(vt.text, vt.font), PS_X) * PS_VMAX / v.vsizex;
			width = Print_ToVirtual(Font_GetStringWidthPtr(vt.text, vt.font), PS_X) * PS_VMAX / Print_ToVirtual (v.psizex, PS_X);
			//LeGo bug - subtraction of negative number is addition ... so we need to add negative number ...
			//vt.posx = PS_VMAX - width - margin;
			vt.posx = PS_VMAX - width + margin;
			lp = l.next;
		end;
	};
};

/*
 *	View_AlignText_Fixed
 */
func void View_AlignText_Fixed (var int hndl, var int margin) {
	if (!Hlp_IsValidHandle (hndl)) { return; };
	var int viewPtr; viewPtr = getPtr (hndl);
	ViewPtr_AlignText_Fixed (viewPtr, margin);
};

/*
 *	ViewPtr_SetTextAndFontColor
 */
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
	var int flagTextsChanged; flagTextsChanged = FALSE;

	if (list) {
		l = _^ (list);

		while (i < cnt);
			text = STR_Split(texts, Print_LineSeperator, i);

			if (list) {
				//Update existing text view
				l = _^ (list);

				if (l.data) {
					vt = _^ (l.data);

					if (!Hlp_StrCmp (vt.text, text)) {
						flagTextsChanged = TRUE;
						vt.text = text;
					};

					if (color != -1) {
						vt.color = color;
						vt.colored = (color != -1);
					};

					//Calc Y pos for next line
					var int vtFontHeight; vtFontHeight = Print_ToVirtual (zCFont_GetFontY (vt.font), v.psizey);
					vposY = vt.posY + vtFontHeight;
				};

				list = l.next;
			} else {
				//Add new text view
				ViewPtr_AddText (viewPtr, vposX, vposY, text, fontName, color);
				vposY += fontHeight;
				flagListExtended = TRUE;
				flagTextsChanged = TRUE;
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
				flagTextsChanged = TRUE;

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
		flagTextsChanged = TRUE;
	};

	//-- Auto formatting
	if (flagTextsChanged) {
		if (v.intflags & VIEW_AUTO_ALPHA) {
			ViewPtr_SetAlphaAll (viewPtr, v.alpha);
		};

		if (v.intflags & VIEW_AUTO_RESIZE) {
			ViewPtr_AutoResize (viewPtr);
		};

		if (v.intflags & VIEW_TXT_HCENTER) {
			ViewPtr_AlignText_Fixed (viewPtr, 0);
		};

		if (v.intflags & VIEW_TXT_VCENTER) {
			ViewPtr_CenterTextLines (viewPtr);
		};
	};
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
	return (view.IsOpen | view.continueOpen);
};

func int View_IsOpen (var int hndl) {
	if (!Hlp_IsValidHandle (hndl)) { return FALSE; };
	var int viewPtr; viewPtr = getPtr (hndl);
	return + ViewPtr_IsOpen (viewPtr);
};

func int ViewPtr_IsClosed (var int viewPtr) {
	if (!viewPtr) { return FALSE; };
	var zCView view; view = _^ (viewPtr);
	return (view.isClosed | view.continueClose);
};

func int View_IsClosed (var int hndl) {
	if (!Hlp_IsValidHandle (hndl)) { return FALSE; };
	var int viewPtr; viewPtr = getPtr (hndl);
	return + ViewPtr_IsClosed (viewPtr);
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

//bruh ... LeGo does not have any safety checks
func void ViewPtr_Close_Safe(var int viewPtr) {
	if (!viewPtr) { return; };
	ViewPtr_Close (viewPtr);
};

func void View_Close_Safe (var int hndl) {
	if (!Hlp_IsValidHandle (hndl)) { return; };
	ViewPtr_Close_Safe (getPtr (hndl));
};

//--

func void ViewPtr_Open_Safe (var int viewPtr) {
	if (!viewPtr) { return; };
	ViewPtr_Open (viewPtr);
};

func void View_Open_Safe(var int hndl) {
	if (!Hlp_IsValidHandle (hndl)) { return; };
	ViewPtr_Open_Safe (getPtr( hndl));
};

//--

func void ViewPtr_MoveTo_Safe (var int viewPtr, var int x, var int y) {
	if (!viewPtr) { return; };
	ViewPtr_MoveTo (viewPtr, x, y);
};

func void View_MoveTo_Safe (var int hndl, var int x, var int y) {
	if (!Hlp_IsValidHandle (hndl)) { return; };
	View_MoveTo (hndl, x, y);
};

func void ViewPtr_Resize_Safe (var int viewPtr, var int x, var int y) {
	if (!viewPtr) { return; };
	ViewPtr_Resize (viewPtr, x, y);
};

func void View_Resize_Safe (var int hndl, var int x, var int y) {
	if (!Hlp_IsValidHandle (hndl)) { return; };
	View_Resize (hndl, x, y);
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
