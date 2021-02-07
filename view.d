/*
 *	Some useful functions for Views
 */
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

func void zcView_SetText (var int hndl, var string text) {
	if (!Hlp_IsValidHandle (hndl)) { return; }; 
	
	var zCView view; view = _^ (getPtr (hndl));
	
	if (view.textLines_next) {
		var zCList list; list = _^ (view.textLines_next);
		var zCViewText viewT; viewT = _^ (list.data);
	    
		viewT.text = text;
	};
};

func void zcView_SetTextAndFontColor (var int hndl, var string text, var int color) {
	if (!Hlp_IsValidHandle (hndl)) { return; }; 
	
	var zCView view; view = _^ (getPtr (hndl));
	
	if (view.textLines_next) {
		var zCList list; list = _^ (view.textLines_next);
		var zCViewText viewT; viewT = _^ (list.data);
	    
		viewT.text = text;
		viewT.color = color;
		viewT.colored = TRUE;
	};
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
