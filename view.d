/*
 *	Some useful functions for Views
 */

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
			width = Print_ToVirtual(Print_GetStringWidthPtr(vt.text, vt.font), PS_X) * PS_VMAX / v.vsizex;
			vt.posx = PS_VMAX / 2 - width / 2;
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
			width = Print_ToVirtual(Print_GetStringWidthPtr(vt.text, vt.font), PS_X) * PS_VMAX / v.vsizex;
			//vt.posx = PS_VMAX - width - margin;
			vt.posx = PS_VMAX - width + margin;
			lp = l.next;
		end;
	};
};

func void ViewPtr_SetTextAndFontColor (var int viewPtr, var string texts, var int color, var int margin) {
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
					vt.color = color;
					vt.colored = (color != -1);

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
			while (l.next);
				var zCList del; del = _^ (l.next);
				l.next = del.next;
				MEM_Free (_@ (del));

				if (l.next) {
					l = _^ (l.next);
				};
			end;
		};
	} else {
		//Or add texts - if they were not added yet
		ViewPtr_AddText (viewPtr, vposX, vposY, texts, fontName, color);
	};

	ViewPtr_AlignText_Fixed (viewPtr, margin);
};

func void View_SetTextAndFontColor (var int hndl, var string texts, var int color, var int margin) {
	if (!Hlp_IsValidHandle (hndl)) { return; };
	var int viewPtr; viewPtr = getPtr (hndl);
	ViewPtr_SetTextAndFontColor (viewPtr, texts, color, margin);
};

func void View_SetText (var int hndl, var string texts, var int margin) {
	View_SetTextAndFontColor (hndl, texts, -1, margin);
};

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

func int zcView_IsOpen (var int hndl) {
	if (!Hlp_IsValidHandle (hndl)) { return FALSE; };

	var int viewPtr; viewPtr = getPtr (hndl);
	if (!viewPtr) { return FALSE; };
	var zCView view; view = _^ (viewPtr);

	return view.IsOpen;
};

func int zCView_Noise_IsActive () {
	const int cGAME_VIEW_NOISE = 5;
	var int zCView_NoisePtr; zCView_NoisePtr = MEM_Game.array_view [cGAME_VIEW_NOISE];

	if (zCView_NoisePtr) {
		var zCView v; v = _^ (zCView_NoisePtr);
		return v.ondesk;
	};

	return FALSE;
};
