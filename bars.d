func void Bar_SetAlphaBackAndBar (var int bar, var int alphaBack, var int alphaBar) {
	if(!Hlp_IsValidHandle(bar)) { return; };
	var _bar b; b = get(bar);
	//Another trick von Mud-freak :)
	View_SetAlpha(b.v0, alphaBack);
	View_SetAlpha(b.v1, alphaBar);
};

func void Bar_Top (var int bar) {
	if(!Hlp_IsValidHandle(bar)) { return; };
	var _bar b; b = get(bar);
	View_Top(b.v0);
	View_Top(b.v1);
};
