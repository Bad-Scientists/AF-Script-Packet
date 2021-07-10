/*
 *	Some useful functions for Views
 */

//TODO: remove and replace with ViewPtr_AlignText once ViewPtr_AlignText is fixed in LeGo
func void zCViewPtr_AlignText (var int ptr, var int margin) {
    var zCView v;  v = _^(ptr);
    var int    lp; lp = v.textLines_next;
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

func void zcView_SetFontColor (var int hndl, var int color) {
	if (!Hlp_IsValidHandle (hndl)) { return; }; 
	
	var zCView view; view = _^ (getPtr (hndl));
	
	if (view.textLines_next) {
		var zCList list; list = _^ (view.textLines_next);
		var zCViewText viewT; viewT = _^ (list.data);
	    
		viewT.color = color;
		viewT.colored = TRUE;
	};
};

func void zcView_SetText (var int hndl, var string text, var int margin) {
	if (!Hlp_IsValidHandle (hndl)) { return; }; 

	var int viewPtr; viewPtr = getPtr (hndl);
	var zCView v; v = _^ (viewPtr);

	var int i; i = 0;
	var int cnt; cnt = STR_SplitCount (text, Print_LineSeperator);

	var zCList l; 
	var zCViewText vt; 

	var string fontName;

	var int posX;
	var int posY;

	posX = v.pposX;
	posY = v.pposY;

	//Update existing zCViewText objects
	var int list; list = v.textLines_next;
	if (list) {
		while (i < cnt);
			if (list) {
				l = _^ (list);
				vt = _^ (l.data);
				
				vt.text = STR_Split(text, Print_LineSeperator, i);
				list = l.next;
				
				posY += vt.posY;
			} else {
				//Add text first
				fontName = Print_GetFontName (v.font);
				View_AddText (hndl, posX, posY, STR_Split(text, Print_LineSeperator, i), fontName);
			};

			i += 1;
		end;
	} else {
		//Add text first
		fontName = Print_GetFontName (v.font);
		View_AddText (hndl, posX, posY, text, fontName);
	};

	zCViewPtr_AlignText (viewPtr, margin);
};

func void zcView_SetTextAndFontColor (var int hndl, var string text, var int color, var int margin) {
	if (!Hlp_IsValidHandle (hndl)) { return; }; 

	var int viewPtr; viewPtr = getPtr (hndl);
	var zCView v; v = _^ (viewPtr);

	var int i; i = 0;
	var int cnt; cnt = STR_SplitCount (text, Print_LineSeperator);

	var zCList l; 
	var zCViewText vt; 

	var string fontName;

	var int posX;
	var int posY;

	posX = v.pposX;
	posY = v.pposY;

	//Update existing zCViewText objects
	var int list; list = v.textLines_next;
	if (list) {
		while (i < cnt);
			if (list) {
				l = _^ (list);
				vt = _^ (l.data);
				
				vt.text = STR_Split(text, Print_LineSeperator, i);
				vt.color = color;
				vt.colored = (color != -1);
				
				list = l.next;
				
				posY += vt.posY;
			} else {
				//Add text first
				fontName = Print_GetFontName (v.font);
				View_AddTextColored (hndl, posX, posY, STR_Split(text, Print_LineSeperator, i), fontName, color);
			};

			i += 1;
		end;
	} else {
		//Add text first
		fontName = Print_GetFontName (v.font);
		View_AddTextColored (hndl, posX, posY, text, fontName, color);
	};

	zCViewPtr_AlignText (viewPtr, margin);
};

func int zcView_OnDesk (var int hndl) {
	if (!Hlp_IsValidHandle (hndl)) { return FALSE; };

	var zCView view; view = _^ (getPtr (hndl));

	return view.onDesk;
};

func int zcView_IsOpen (var int hndl) {
	if (!Hlp_IsValidHandle (hndl)) { return FALSE; };

	var zCView view; view = _^ (getPtr (hndl));
	return view.IsOpen;
};
