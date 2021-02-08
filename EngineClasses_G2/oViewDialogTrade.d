/*
 - zCObject .... <zObject.cpp,#242>
     - zCViewObject .... <zObject.cpp,#242>
         - zCViewDraw [objs 1] [ctor 1] .... <zObject.cpp,#242>
             - zCViewFX .... <zObject.cpp,#242>
                 - zCViewPrint .... <zObject.cpp,#242>
                     - zCViewDialog .... <zObject.cpp,#242>
                         - oCViewDialogTrade [objs 1] [ctor 1] .... <zObject.cpp,#242>
*/

class oCViewDialogTrade {
	var int _vtbl;				//0

//class zCObject {
	var int refCtr;				//4	int refCtr;
	var int hashIndex;			//8	unsigned short hashIndex;
	var int hashNext;			//12	zCObject* hashNext;
	var string objectName;			//16	zSTRING objectName

//};

	var int zCViewBase_vtbl;		//36

//class zCViewObject : public zCObject, public zCViewBase {

	var int VirtualPositionX;		//40	zPOS VirtualPosition;
	var int VirtualPositionY;		//44
	var int VirtualSizeX;			//48	zPOS VirtualSize;
	var int VirtualSizeY;			//52
	var int PixelPositionX;			//56	zPOS PixelPosition;
	var int PixelPositionY;			//60
	var int PixelSizeX;			//64	zPOS PixelSize;
	var int PixelSizeY;			//68

	var int ID;				//72	unsigned long ID;
	var int ViewParent;			//76	zCViewObject* ViewParent;

	//zCListSort<zCViewObject> ListChildren;
	var int ListChildren_compareFunc;	//80	int (*Compare)(T *ele1,T *ele2);
	var int ListChildren_data;		//84	T*
	var int ListChildren_next;		//88	zCListSort<T>*
//};

//class zCViewDraw : public zCViewObject {

	var int TextureFuncAlpha;		//92	zTRnd_AlphaBlendFunc TextureFuncAlpha;

	var int Texture;			//96	zCTexture* Texture;
	var int TextureColor;			//100	zCOLOR TextureColor;
	var int TextureAlpha;			//104	int TextureAlpha;
	//float
	var int TexturePosition_0[2];		//108, 112	zVEC2 TexturePosition[2];
	var int TexturePosition_1[2];		//116, 120
//};

//class zCViewFX : public zCViewDraw {
	/*
	typedef enum zEViewFX {
	VIEW_FX_NONE        = 0,
	VIEW_FX_ZOOM        = 1,
	VIEW_FX_FADE        = VIEW_FX_ZOOM << 1,
	VIEW_FX_BOUNCE      = VIEW_FX_FADE << 1,
	VIEW_FX_FORCE_DWORD = 0xffffffff
	} zTViewFX;
	*/

	var int HasOpened;			//124	int HasOpened;
	var int HasClosed;			//128	int HasClosed;
	var int TimeOpen;			//132	float TimeOpen;
	var int TimeClose;			//136	float TimeClose;
	var int DurationOpen;			//140	float DurationOpen;
	var int DurationClose;			//144	float DurationClose;
	var int ModeOpen;			//148	unsigned long ModeOpen;
	var int ModeClose;			//152	unsigned long ModeClose;
	//float
	var int TextureOffset_0[2];		//156, 160	zVEC2 TextureOffset[2];
	var int TextureOffset_1[2];		//164, 168
//};

//class zCViewPrint : public zCViewFX {
	/*
	typedef enum zEViewAlignment {
	VIEW_ALIGN_NONE,
	VIEW_ALIGN_MAX,
	VIEW_ALIGN_MIN,
	VIEW_ALIGN_CENTER
	} zTViewAlign;
	*/

	//zCArray<zCViewText2*> ListTextLines;
	var int ListTextLines_array;		//172	T*
	var int ListTextLines_numAlloc;		//176	int
	var int ListTextLines_numInArray;	//180	int

	//zCViewFont ViewFont;
	var int FuncAlphaBlend;			//184	zTRnd_AlphaBlendFunc FuncAlphaBlend;
	var int Font;				//188	zCFont* Font;
	var int Color;				//192	zCOLOR Color;
	var int Alpha;				//196	int Alpha;
	var int EnabledBlend;			//200	int EnabledBlend;
	//

	var int PositionCursorX;		//204	zPOS PositionCursor;
	var int PositionCursorY;		//208
	var int OffsetTextPixelX;		//212	zPOS OffsetTextPixel;
	var int OffsetTextPixelY;		//216
	var int SizeMargin_0[2];		//220, 224	zPOS SizeMargin[2];
	var int SizeMargin_1[2];		//228, 232
//};

	var int zCInputCallback_vtbl;		//236

//class zCViewDialog : public zCViewPrint, public zCInputCallback {
	var int IsDone;				//240	int IsDone;
	var int IsActivated;			//244	int IsActivated;
//};

//class oCViewDialogTrade : public zCViewDialog {

	/*
	typedef enum zETradeDialogSection {
	TRADE_SECTION_LEFT_INVENTORY,
	TRADE_SECTION_RIGHT_INVENTORY
	} zTTradeSection;
	*/

	var int DlgInventoryNpc;		//248	oCViewDialogStealContainer* DlgInventoryNpc;
	var int DlgInventoryPlayer;		//252	oCViewDialogInventory* DlgInventoryPlayer;
	var int SectionTrade;			//256	zTTradeSection SectionTrade;
	var int NpcLeft;			//260	oCNpc* NpcLeft;
	var int NpcRight;			//264	oCNpc* NpcRight;
	var int TransferCount;			//268	short TransferCount;
//};
};
