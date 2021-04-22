func void Bar_SetAlphaBackAndBar (var int bar, var int alphaBack, var int alphaBar) {
	if(!Hlp_IsValidHandle(bar)) { return; };
	var _bar b; b = get(bar);
	var zCView v; v = View_Get(b.v0);
	v.alpha = alphaBack;
	if((v.alpha != 255) && (v.alphafunc == 1)) {
		v.alphafunc = 2;
	};
	v = View_Get(b.v1);
	v.alpha = alphaBar;
	if((v.alpha != 255) && (v.alphafunc == 1)) {
		v.alphafunc = 2;
	};
};
