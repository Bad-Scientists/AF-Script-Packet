/*
 *
 */
instance zCViewText2@ (zCViewText2);

func int zCViewText2_New() {
	var int ptr; ptr = create(zCViewText2@);
	return ptr;
};

func int zCViewText2_Create(var string text, var int pposX, var int pposY, var int font, var int color, var int alpha, var int funcAlphaBlend) {
	var int ptr; ptr = zCViewText2_New();
	if (!ptr) { return 0; };

	var zCViewText2 v; v = _^(ptr);
	v.text = text;
	v.pixelPositionX = pposX;
	v.pixelPositionY = pposY;

	if (color != -1) {
		v.color = color;
		v.enabledColor = TRUE;
	};

	v.font = font;

	if (alpha != -1) {
		v.alpha = alpha;
	};

	if (funcAlphaBlend > 0) {
		v.enabledBlend = TRUE;
		v.funcAlphaBlend = funcAlphaBlend;
	};

	return ptr;
};
