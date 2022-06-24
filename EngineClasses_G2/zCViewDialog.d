/*
typedef enum zEViewFX {
VIEW_FX_NONE        = 0,
VIEW_FX_ZOOM        = 1,
VIEW_FX_FADE        = VIEW_FX_ZOOM << 1,
VIEW_FX_BOUNCE      = VIEW_FX_FADE << 1,
VIEW_FX_FORCE_DWORD = 0xffffffff
} zTViewFX;

typedef enum zEViewAlignment {
VIEW_ALIGN_NONE,
VIEW_ALIGN_MAX,
VIEW_ALIGN_MIN,
VIEW_ALIGN_CENTER
} zTViewAlign;

enum oEInventoryAlignment {
oEInventoryAlignment_Left,
oEInventoryAlignment_Right
};

enum oEItemContainerAlignment {
oEItemContainerAlignment_Left,
oEItemContainerAlignment_Right
};

enum oEStealContainerAlignment {
oEStealContainerAlignment_Left,
oEStealContainerAlignment_Right
};

typedef enum zETradeDialogSection {
TRADE_SECTION_LEFT_INVENTORY,
TRADE_SECTION_RIGHT_INVENTORY
} zTTradeSection;

*/

/*
 *
 */
class zCViewText2 {
	var int enabledColor; //int // sizeof 04h offset 00h
	var int enabledTimer; //int // sizeof 04h offset 04h

	//zPOS PixelPosition; // sizeof 08h offset 08h
	var int pixelPositionX;
	var int pixelPositionY;

	var int timer; //float // sizeof 04h offset 10h
	var string text; //zSTRING // sizeof 14h offset 14h

	//zCViewFont ViewFont; // sizeof 14h offset B8h
	//class zCViewFont {
	var int funcAlphaBlend; //zTRnd_AlphaBlendFunc // sizeof 04h offset 00h
	var int font; //zCFont* // sizeof 04h offset 04h
	var int color; //zCOLOR // sizeof 04h offset 08h
	var int alpha; //int // sizeof 04h offset 0Ch
	var int enabledBlend; //int // sizeof 04h offset 10h
	//};
};

//class zCViewDialog : public zCViewPrint, public zCInputCallback {
class zCViewDialog {
  //class zCViewPrint : public zCViewFX {
   //class zCViewFX : public zCViewDraw {
    //class zCViewDraw : public zCViewObject {
     //class zCViewObject : public zCObject, public zCViewBase {
      //class zCObject {
	var int _vtbl; //0
	var int refctr; //4
	var int hashindex; //8
	var int hashNext; //12

	var string objectName; //16
      //}

	var int _zCViewBase_vtbl; //36

	var int virtualPositionX; //zPOS // sizeof 08h offset 28h
	var int virtualPositionY;
	var int virtualSizeX; //zPOS // sizeof 08h offset 30h
	var int virtualSizeY;

	var int pixelPositionX; //zPOS // sizeof 08h offset 38h
	var int pixelPositionY;
	var int pixelSizeX; //zPOS // sizeof 08h offset 40h
	var int pixelSizeY;

	var int ID; //unsigned long // sizeof 04h offset 48h
	var int viewParent; //zCViewObject* // sizeof 04h offset 4Ch

	//zCListSort<zCViewObject> ListChildren; // sizeof 0Ch offset 50h
	var int listChildren_compare;
	var int listChildren_data;
	var int listChildren_next;
     //}

	var int textureFuncAlpha; //zTRnd_AlphaBlendFunc // sizeof 04h offset 5Ch
	var int texture; //zCTexture* // sizeof 04h offset 60h
	var int textureColor; //zCOLOR // sizeof 04h offset 64h
	var int textureAlpha; //int // sizeof 04h offset 68h

	//zVEC2 TexturePosition[2]; // sizeof 10h offset 6Ch
	var int texturePosition_0[2];
	var int texturePosition_1[2];
    //}

	var int hasOpened; //int // sizeof 04h offset 7Ch
	var int hasClosed; //int // sizeof 04h offset 80h
	var int timeOpen; //float // sizeof 04h offset 84h
	var int timeClose; //float // sizeof 04h offset 88h
	var int durationOpen; //float // sizeof 04h offset 8Ch
	var int durationClose; //float // sizeof 04h offset 90h
	var int modeOpen; //unsigned long // sizeof 04h offset 94h
	var int modeClose; //unsigned long // sizeof 04h offset 98h

	//zVEC2 TextureOffset[2]; // sizeof 10h offset 9Ch
	var int textureOffset_0[2];
	var int textureOffset_1[2];
   //}

	//zCArray<zCViewText2*> ListTextLines; // sizeof 0Ch offset ACh
	var int listTextLines_array; //zCViewText2*
	var int listTextLines_numAlloc;  //int
	var int listTextLines_numInArray;//int

	//zCViewFont ViewFont; // sizeof 14h offset B8h
	//class zCViewFont {
	var int funcAlphaBlend; //zTRnd_AlphaBlendFunc // sizeof 04h offset 00h
	var int font; //zCFont* // sizeof 04h offset 04h
	var int color; //zCOLOR // sizeof 04h offset 08h
	var int alpha; //int // sizeof 04h offset 0Ch
	var int enabledBlend; //int // sizeof 04h offset 10h
	//};

	var int positionCursorX; //zPOS // sizeof 08h offset CCh
	var int positionCursorY;
	var int offsetTextPixelX; //zPOS // sizeof 08h offset D4h
	var int offsetTextPixelY;
	var int sizeMargin_0[2]; //zPOS // sizeof 10h offset DCh
	var int sizeMargin_1[2];
  //}

	var int zCInputCallback_vtbl; //236

	var int isDone; //int // sizeof 04h offset F0h
	var int isActivated; //int // sizeof 04h offset F4h
};

//class oCViewDialogInventory : public zCViewDialog {
class oCViewDialogInventory {
 //class zCViewDialog : public zCViewPrint, public zCInputCallback {
  //class zCViewPrint : public zCViewFX {
   //class zCViewFX : public zCViewDraw {
    //class zCViewDraw : public zCViewObject {
     //class zCViewObject : public zCObject, public zCViewBase {
      //class zCObject {
	var int _vtbl; //0
	var int refctr; //4
	var int hashindex; //8
	var int hashNext; //12

	var string objectName; //16
      //}

	var int _zCViewBase_vtbl; //36

	var int virtualPositionX; //zPOS // sizeof 08h offset 28h
	var int virtualPositionY;
	var int virtualSizeX; //zPOS // sizeof 08h offset 30h
	var int virtualSizeY;

	var int pixelPositionX; //zPOS // sizeof 08h offset 38h
	var int pixelPositionY;
	var int pixelSizeX; //zPOS // sizeof 08h offset 40h
	var int pixelSizeY;

	var int ID; //unsigned long // sizeof 04h offset 48h
	var int viewParent; //zCViewObject* // sizeof 04h offset 4Ch

	//zCListSort<zCViewObject> ListChildren; // sizeof 0Ch offset 50h
	var int listChildren_compare;
	var int listChildren_data;
	var int listChildren_next;
     //}

	var int textureFuncAlpha; //zTRnd_AlphaBlendFunc // sizeof 04h offset 5Ch
	var int texture; //zCTexture* // sizeof 04h offset 60h
	var int textureColor; //zCOLOR // sizeof 04h offset 64h
	var int textureAlpha; //int // sizeof 04h offset 68h

	//zVEC2 TexturePosition[2]; // sizeof 10h offset 6Ch
	var int texturePosition_0[2];
	var int texturePosition_1[2];
    //}

	var int hasOpened; //int // sizeof 04h offset 7Ch
	var int hasClosed; //int // sizeof 04h offset 80h
	var int timeOpen; //float // sizeof 04h offset 84h
	var int timeClose; //float // sizeof 04h offset 88h
	var int durationOpen; //float // sizeof 04h offset 8Ch
	var int durationClose; //float // sizeof 04h offset 90h
	var int modeOpen; //unsigned long // sizeof 04h offset 94h
	var int modeClose; //unsigned long // sizeof 04h offset 98h
	//zVEC2 TextureOffset[2]; // sizeof 10h offset 9Ch
	var int textureOffset_0[2];
	var int textureOffset_1[2];
   //}

	//zCArray<zCViewText2*> ListTextLines; // sizeof 0Ch offset ACh
	var int listTextLines_array; //zCViewText2*
	var int listTextLines_numAlloc;  //int
	var int listTextLines_numInArray;//int

	//zCViewFont ViewFont; // sizeof 14h offset B8h
	//class zCViewFont {
	var int funcAlphaBlend; //zTRnd_AlphaBlendFunc // sizeof 04h offset 00h
	var int font; //zCFont* // sizeof 04h offset 04h
	var int color; //zCOLOR // sizeof 04h offset 08h
	var int alpha; //int // sizeof 04h offset 0Ch
	var int enabledBlend; //int // sizeof 04h offset 10h
	//};

	var int positionCursorX; //zPOS // sizeof 08h offset CCh
	var int positionCursorY;
	var int offsetTextPixelX; //zPOS // sizeof 08h offset D4h
	var int offsetTextPixelY;
	var int sizeMargin_0[2]; //zPOS // sizeof 10h offset DCh
	var int sizeMargin_1[2];
  //}

	var int zCInputCallback_vtbl; //236

	var int isDone; //int // sizeof 04h offset F0h
	var int isActivated; //int // sizeof 04h offset F4h
 //}

	var int oTInventoryAlignment; //oEInventoryAlignment // sizeof 04h offset F8h
	var int oTAlignmentInventory; //oEInventoryAlignment // sizeof 04h offset FCh
	var int inventory; //oCNpcInventory* // sizeof 04h offset 100h
	var int alignment; //oEInventoryAlignment // sizeof 04h offset 104h
};

//class oCViewDialogItem : public zCViewDialog {
class oCViewDialogItem {
 //class zCViewDialog : public zCViewPrint, public zCInputCallback {
  //class zCViewPrint : public zCViewFX {
   //class zCViewFX : public zCViewDraw {
    //class zCViewDraw : public zCViewObject {
     //class zCViewObject : public zCObject, public zCViewBase {
      //class zCObject {
	var int _vtbl; //0
	var int refctr; //4
	var int hashindex; //8
	var int hashNext; //12

	var string objectName; //16
      //}

	var int _zCViewBase_vtbl; //36

	var int virtualPositionX; //zPOS // sizeof 08h offset 28h
	var int virtualPositionY;
	var int virtualSizeX; //zPOS // sizeof 08h offset 30h
	var int virtualSizeY;

	var int pixelPositionX; //zPOS // sizeof 08h offset 38h
	var int pixelPositionY;
	var int pixelSizeX; //zPOS // sizeof 08h offset 40h
	var int pixelSizeY;

	var int ID; //unsigned long // sizeof 04h offset 48h
	var int viewParent; //zCViewObject* // sizeof 04h offset 4Ch

	//zCListSort<zCViewObject> ListChildren; // sizeof 0Ch offset 50h
	var int listChildren_compare;
	var int listChildren_data;
	var int listChildren_next;
     //}

	var int textureFuncAlpha; //zTRnd_AlphaBlendFunc // sizeof 04h offset 5Ch
	var int texture; //zCTexture* // sizeof 04h offset 60h
	var int textureColor; //zCOLOR // sizeof 04h offset 64h
	var int textureAlpha; //int // sizeof 04h offset 68h

	//zVEC2 TexturePosition[2]; // sizeof 10h offset 6Ch
	var int texturePosition_0[2];
	var int texturePosition_1[2];
    //}

	var int hasOpened; //int // sizeof 04h offset 7Ch
	var int hasClosed; //int // sizeof 04h offset 80h
	var int timeOpen; //float // sizeof 04h offset 84h
	var int timeClose; //float // sizeof 04h offset 88h
	var int durationOpen; //float // sizeof 04h offset 8Ch
	var int durationClose; //float // sizeof 04h offset 90h
	var int modeOpen; //unsigned long // sizeof 04h offset 94h
	var int modeClose; //unsigned long // sizeof 04h offset 98h
	//zVEC2 TextureOffset[2]; // sizeof 10h offset 9Ch
	var int textureOffset_0[2];
	var int textureOffset_1[2];
   //}

	//zCArray<zCViewText2*> ListTextLines; // sizeof 0Ch offset ACh
	var int listTextLines_array; //zCViewText2*
	var int listTextLines_numAlloc;  //int
	var int listTextLines_numInArray;//int

	//zCViewFont ViewFont; // sizeof 14h offset B8h
	//class zCViewFont {
	var int funcAlphaBlend; //zTRnd_AlphaBlendFunc // sizeof 04h offset 00h
	var int font; //zCFont* // sizeof 04h offset 04h
	var int color; //zCOLOR // sizeof 04h offset 08h
	var int alpha; //int // sizeof 04h offset 0Ch
	var int enabledBlend; //int // sizeof 04h offset 10h
	//};

	var int positionCursorX; //zPOS // sizeof 08h offset CCh
	var int positionCursorY;
	var int offsetTextPixelX; //zPOS // sizeof 08h offset D4h
	var int offsetTextPixelY;
	var int sizeMargin_0[2]; //zPOS // sizeof 10h offset DCh
	var int sizeMargin_1[2];
  //}

	var int zCInputCallback_vtbl; //236

	var int isDone; //int // sizeof 04h offset F0h
	var int isActivated; //int // sizeof 04h offset F4h

 //}
	var int item; //oCItem* // sizeof 04h offset F8h
};

//class oCViewDialogItemContainer : public zCViewDialog {
class oCViewDialogItemContainer {
 //class zCViewDialog : public zCViewPrint, public zCInputCallback {
  //class zCViewPrint : public zCViewFX {
   //class zCViewFX : public zCViewDraw {
    //class zCViewDraw : public zCViewObject {
     //class zCViewObject : public zCObject, public zCViewBase {
      //class zCObject {
	var int _vtbl; //0
	var int refctr; //4
	var int hashindex; //8
	var int hashNext; //12

	var string objectName; //16
      //}

	var int _zCViewBase_vtbl; //36

	var int virtualPositionX; //zPOS // sizeof 08h offset 28h
	var int virtualPositionY;
	var int virtualSizeX; //zPOS // sizeof 08h offset 30h
	var int virtualSizeY;

	var int pixelPositionX; //zPOS // sizeof 08h offset 38h
	var int pixelPositionY;
	var int pixelSizeX; //zPOS // sizeof 08h offset 40h
	var int pixelSizeY;

	var int ID; //unsigned long // sizeof 04h offset 48h
	var int viewParent; //zCViewObject* // sizeof 04h offset 4Ch

	//zCListSort<zCViewObject> ListChildren; // sizeof 0Ch offset 50h
	var int listChildren_compare;
	var int listChildren_data;
	var int listChildren_next;
     //}

	var int textureFuncAlpha; //zTRnd_AlphaBlendFunc // sizeof 04h offset 5Ch
	var int texture; //zCTexture* // sizeof 04h offset 60h
	var int textureColor; //zCOLOR // sizeof 04h offset 64h
	var int textureAlpha; //int // sizeof 04h offset 68h

	//zVEC2 TexturePosition[2]; // sizeof 10h offset 6Ch
	var int texturePosition_0[2];
	var int texturePosition_1[2];
    //}

	var int hasOpened; //int // sizeof 04h offset 7Ch
	var int hasClosed; //int // sizeof 04h offset 80h
	var int timeOpen; //float // sizeof 04h offset 84h
	var int timeClose; //float // sizeof 04h offset 88h
	var int durationOpen; //float // sizeof 04h offset 8Ch
	var int durationClose; //float // sizeof 04h offset 90h
	var int modeOpen; //unsigned long // sizeof 04h offset 94h
	var int modeClose; //unsigned long // sizeof 04h offset 98h
	//zVEC2 TextureOffset[2]; // sizeof 10h offset 9Ch
	var int textureOffset_0[2];
	var int textureOffset_1[2];
   //}

	//zCArray<zCViewText2*> ListTextLines; // sizeof 0Ch offset ACh
	var int listTextLines_array; //zCViewText2*
	var int listTextLines_numAlloc;  //int
	var int listTextLines_numInArray;//int

	//zCViewFont ViewFont; // sizeof 14h offset B8h
	//class zCViewFont {
	var int funcAlphaBlend; //zTRnd_AlphaBlendFunc // sizeof 04h offset 00h
	var int font; //zCFont* // sizeof 04h offset 04h
	var int color; //zCOLOR // sizeof 04h offset 08h
	var int alpha; //int // sizeof 04h offset 0Ch
	var int enabledBlend; //int // sizeof 04h offset 10h
	//};

	var int positionCursorX; //zPOS // sizeof 08h offset CCh
	var int positionCursorY;
	var int offsetTextPixelX; //zPOS // sizeof 08h offset D4h
	var int offsetTextPixelY;
	var int sizeMargin_0[2]; //zPOS // sizeof 10h offset DCh
	var int sizeMargin_1[2];
  //}

	var int zCInputCallback_vtbl; //236

	var int isDone; //int // sizeof 04h offset F0h
	var int isActivated; //int // sizeof 04h offset F4h
 //}

	var int oTItemContainerAlignment; //oEItemContainerAlignment // sizeof 04h offset F8h
	var int oTAlignmentItemContainer; //oEItemContainerAlignment // sizeof 04h offset FCh
	var int itemContainer; //oCItemContainer* // sizeof 04h offset 100h
	var int alignment; //oEItemContainerAlignment // sizeof 04h offset 104h
	var int value; //unsigned long // sizeof 04h offset 108h
	var int valueMultiplier; //float // sizeof 04h offset 10Ch
};


//class oCViewDialogStealContainer : public zCViewDialog {
class oCViewDialogStealContainer {
 //class zCViewDialog : public zCViewPrint, public zCInputCallback {
  //class zCViewPrint : public zCViewFX {
   //class zCViewFX : public zCViewDraw {
    //class zCViewDraw : public zCViewObject {
     //class zCViewObject : public zCObject, public zCViewBase {
      //class zCObject {
	var int _vtbl; //0
	var int refctr; //4
	var int hashindex; //8
	var int hashNext; //12

	var string objectName; //16
      //}

	var int _zCViewBase_vtbl; //36

	var int virtualPositionX; //zPOS // sizeof 08h offset 28h
	var int virtualPositionY;
	var int virtualSizeX; //zPOS // sizeof 08h offset 30h
	var int virtualSizeY;

	var int pixelPositionX; //zPOS // sizeof 08h offset 38h
	var int pixelPositionY;
	var int pixelSizeX; //zPOS // sizeof 08h offset 40h
	var int pixelSizeY;

	var int ID; //unsigned long // sizeof 04h offset 48h
	var int viewParent; //zCViewObject* // sizeof 04h offset 4Ch

	//zCListSort<zCViewObject> ListChildren; // sizeof 0Ch offset 50h
	var int listChildren_compare;
	var int listChildren_data;
	var int listChildren_next;
     //}

	var int textureFuncAlpha; //zTRnd_AlphaBlendFunc // sizeof 04h offset 5Ch
	var int texture; //zCTexture* // sizeof 04h offset 60h
	var int textureColor; //zCOLOR // sizeof 04h offset 64h
	var int textureAlpha; //int // sizeof 04h offset 68h

	//zVEC2 TexturePosition[2]; // sizeof 10h offset 6Ch
	var int texturePosition_0[2];
	var int texturePosition_1[2];
    //}

	var int hasOpened; //int // sizeof 04h offset 7Ch
	var int hasClosed; //int // sizeof 04h offset 80h
	var int timeOpen; //float // sizeof 04h offset 84h
	var int timeClose; //float // sizeof 04h offset 88h
	var int durationOpen; //float // sizeof 04h offset 8Ch
	var int durationClose; //float // sizeof 04h offset 90h
	var int modeOpen; //unsigned long // sizeof 04h offset 94h
	var int modeClose; //unsigned long // sizeof 04h offset 98h
	//zVEC2 TextureOffset[2]; // sizeof 10h offset 9Ch
	var int textureOffset_0[2];
	var int textureOffset_1[2];
   //}

	//zCArray<zCViewText2*> ListTextLines; // sizeof 0Ch offset ACh
	var int listTextLines_array; //zCViewText2*
	var int listTextLines_numAlloc;  //int
	var int listTextLines_numInArray;//int

	//zCViewFont ViewFont; // sizeof 14h offset B8h
	//class zCViewFont {
	var int funcAlphaBlend; //zTRnd_AlphaBlendFunc // sizeof 04h offset 00h
	var int font; //zCFont* // sizeof 04h offset 04h
	var int color; //zCOLOR // sizeof 04h offset 08h
	var int alpha; //int // sizeof 04h offset 0Ch
	var int enabledBlend; //int // sizeof 04h offset 10h
	//};

	var int positionCursorX; //zPOS // sizeof 08h offset CCh
	var int positionCursorY;
	var int offsetTextPixelX; //zPOS // sizeof 08h offset D4h
	var int offsetTextPixelY;
	var int sizeMargin_0[2]; //zPOS // sizeof 10h offset DCh
	var int sizeMargin_1[2];
  //}

	var int zCInputCallback_vtbl; //236

	var int isDone; //int // sizeof 04h offset F0h
	var int isActivated; //int // sizeof 04h offset F4h
 //}

	var int oTStealContainerAlignment; //oEStealContainerAlignment // sizeof 04h offset F8h
	var int oTAlignmentStealContainer; //oEStealContainerAlignment // sizeof 04h offset FCh
	var int stealContainer; //oCStealContainer* // sizeof 04h offset 100h
	var int alignment; //oEStealContainerAlignment // sizeof 04h offset 104h
	var int value; //unsigned long // sizeof 04h offset 108h
	var int valueMultiplier; //float // sizeof 04h offset 10Ch
};

//class oCViewDialogTrade : public zCViewDialog {
class oCViewDialogTrade {
 //class zCViewDialog : public zCViewPrint, public zCInputCallback {
  //class zCViewPrint : public zCViewFX {
   //class zCViewFX : public zCViewDraw {
    //class zCViewDraw : public zCViewObject {
     //class zCViewObject : public zCObject, public zCViewBase {
      //class zCObject {
	var int _vtbl; //0
	var int refctr; //4
	var int hashindex; //8
	var int hashNext; //12

	var string objectName; //16
      //}

	var int _zCViewBase_vtbl; //36

	var int virtualPositionX; //zPOS // sizeof 08h offset 28h
	var int virtualPositionY;
	var int virtualSizeX; //zPOS // sizeof 08h offset 30h
	var int virtualSizeY;

	var int pixelPositionX; //zPOS // sizeof 08h offset 38h
	var int pixelPositionY;
	var int pixelSizeX; //zPOS // sizeof 08h offset 40h
	var int pixelSizeY;

	var int ID; //unsigned long // sizeof 04h offset 48h
	var int viewParent; //zCViewObject* // sizeof 04h offset 4Ch

	//zCListSort<zCViewObject> ListChildren; // sizeof 0Ch offset 50h
	var int listChildren_compare;
	var int listChildren_data;
	var int listChildren_next;
     //}

	var int textureFuncAlpha; //zTRnd_AlphaBlendFunc // sizeof 04h offset 5Ch
	var int texture; //zCTexture* // sizeof 04h offset 60h
	var int textureColor; //zCOLOR // sizeof 04h offset 64h
	var int textureAlpha; //int // sizeof 04h offset 68h

	//zVEC2 TexturePosition[2]; // sizeof 10h offset 6Ch
	var int texturePosition_0[2];
	var int texturePosition_1[2];
    //}

	var int hasOpened; //int // sizeof 04h offset 7Ch
	var int hasClosed; //int // sizeof 04h offset 80h
	var int timeOpen; //float // sizeof 04h offset 84h
	var int timeClose; //float // sizeof 04h offset 88h
	var int durationOpen; //float // sizeof 04h offset 8Ch
	var int durationClose; //float // sizeof 04h offset 90h
	var int modeOpen; //unsigned long // sizeof 04h offset 94h
	var int modeClose; //unsigned long // sizeof 04h offset 98h
	//zVEC2 TextureOffset[2]; // sizeof 10h offset 9Ch
	var int textureOffset_0[2];
	var int textureOffset_1[2];
   //}

	//zCArray<zCViewText2*> ListTextLines; // sizeof 0Ch offset ACh
	var int listTextLines_array; //zCViewText2*
	var int listTextLines_numAlloc;  //int
	var int listTextLines_numInArray;//int

	//zCViewFont ViewFont; // sizeof 14h offset B8h
	//class zCViewFont {
	var int funcAlphaBlend; //zTRnd_AlphaBlendFunc // sizeof 04h offset 00h
	var int font; //zCFont* // sizeof 04h offset 04h
	var int color; //zCOLOR // sizeof 04h offset 08h
	var int alpha; //int // sizeof 04h offset 0Ch
	var int enabledBlend; //int // sizeof 04h offset 10h
	//};

	var int positionCursorX; //zPOS // sizeof 08h offset CCh
	var int positionCursorY;
	var int offsetTextPixelX; //zPOS // sizeof 08h offset D4h
	var int offsetTextPixelY;
	var int sizeMargin_0[2]; //zPOS // sizeof 10h offset DCh
	var int sizeMargin_1[2];
  //}

	var int zCInputCallback_vtbl; //236

	var int isDone; //int // sizeof 04h offset F0h
	var int isActivated; //int // sizeof 04h offset F4h
 //}

	var int dlgInventoryNpc; //oCViewDialogStealContainer* // sizeof 04h offset F8h
	var int dlgInventoryPlayer; //oCViewDialogInventory* // sizeof 04h offset FCh
	var int sectionTrade; //zTTradeSection // sizeof 04h offset 100h
	var int npcLeft; //oCNpc* // sizeof 04h offset 104h
	var int npcRight; //oCNpc* // sizeof 04h offset 108h
	var int transferCount; //short // sizeof 02h offset 10Ch
};

//class zCViewDialogChoice : public zCViewDialog {
class zCViewDialogChoice {
 //class zCViewDialog : public zCViewPrint, public zCInputCallback {
  //class zCViewPrint : public zCViewFX {
   //class zCViewFX : public zCViewDraw {
    //class zCViewDraw : public zCViewObject {
     //class zCViewObject : public zCObject, public zCViewBase {
      //class zCObject {
	var int _vtbl; //0
	var int refctr; //4
	var int hashindex; //8
	var int hashNext; //12

	var string objectName; //16
      //}

	var int _zCViewBase_vtbl; //36

	var int virtualPositionX; //zPOS // sizeof 08h offset 28h
	var int virtualPositionY;
	var int virtualSizeX; //zPOS // sizeof 08h offset 30h
	var int virtualSizeY;

	var int pixelPositionX; //zPOS // sizeof 08h offset 38h
	var int pixelPositionY;
	var int pixelSizeX; //zPOS // sizeof 08h offset 40h
	var int pixelSizeY;

	var int ID; //unsigned long // sizeof 04h offset 48h
	var int viewParent; //zCViewObject* // sizeof 04h offset 4Ch

	//zCListSort<zCViewObject> ListChildren; // sizeof 0Ch offset 50h
	var int listChildren_compare;
	var int listChildren_data;
	var int listChildren_next;
     //}

	var int textureFuncAlpha; //zTRnd_AlphaBlendFunc // sizeof 04h offset 5Ch
	var int texture; //zCTexture* // sizeof 04h offset 60h
	var int textureColor; //zCOLOR // sizeof 04h offset 64h
	var int textureAlpha; //int // sizeof 04h offset 68h

	//zVEC2 TexturePosition[2]; // sizeof 10h offset 6Ch
	var int texturePosition_0[2];
	var int texturePosition_1[2];
    //}

	var int hasOpened; //int // sizeof 04h offset 7Ch
	var int hasClosed; //int // sizeof 04h offset 80h
	var int timeOpen; //float // sizeof 04h offset 84h
	var int timeClose; //float // sizeof 04h offset 88h
	var int durationOpen; //float // sizeof 04h offset 8Ch
	var int durationClose; //float // sizeof 04h offset 90h
	var int modeOpen; //unsigned long // sizeof 04h offset 94h
	var int modeClose; //unsigned long // sizeof 04h offset 98h
	//zVEC2 TextureOffset[2]; // sizeof 10h offset 9Ch
	var int textureOffset_0[2];
	var int textureOffset_1[2];
   //}

	//zCArray<zCViewText2*> ListTextLines; // sizeof 0Ch offset ACh
	var int listTextLines_array; //zCViewText2*
	var int listTextLines_numAlloc;  //int
	var int listTextLines_numInArray;//int

	//zCViewFont ViewFont; // sizeof 14h offset B8h
	//class zCViewFont {
	var int funcAlphaBlend; //zTRnd_AlphaBlendFunc // sizeof 04h offset 00h
	var int font; //zCFont* // sizeof 04h offset 04h
	var int color; //zCOLOR // sizeof 04h offset 08h
	var int alpha; //int // sizeof 04h offset 0Ch
	var int enabledBlend; //int // sizeof 04h offset 10h
	//};

	var int positionCursorX; //zPOS // sizeof 08h offset CCh
	var int positionCursorY;
	var int offsetTextPixelX; //zPOS // sizeof 08h offset D4h
	var int offsetTextPixelY;
	var int sizeMargin_0[2]; //zPOS // sizeof 10h offset DCh
	var int sizeMargin_1[2];
  //}

	var int zCInputCallback_vtbl; //236

	var int isDone; //int // sizeof 04h offset F0h
	var int isActivated; //int // sizeof 04h offset F4h
 //}

	var int colorSelected; //zCOLOR // sizeof 04h offset F8h
	var int colorGrayed; //zCOLOR // sizeof 04h offset FCh
	var int choiceSelected; //int // sizeof 04h offset 100h
	var int choices; //int // sizeof 04h offset 104h
	var int lineStart; //int // sizeof 04h offset 108h
};
