/*
 *	oCItemContainer, oCNpcInventory are taken from Ikarus G2A oCNPC class definition
 */ 

/*
class oCItemContainer : public zCInputCallback {
	public:
	zCListSort<oCItem>* contents;
	oCNpc* npc;
	zSTRING titleText;
	int invMode;
	int selectedItem;
	int offset;
	int maxSlotsCol;
	int maxSlotsColScr;
	int maxSlotsRow;
	int maxSlotsRowScr;
	int maxSlots;
	int marginTop;
	int marginLeft;
	int frame;
	int right;
	int ownList;
	int prepared;
	int passive;
	short TransferCount;
	zCView* viewTitle;
	zCView* viewBack;
	zCView* viewItem;
	zCView* viewItemActive;
	zCView* viewItemHightlighted;
	zCView* viewItemActiveHighlighted;
	zCView* viewItemInfo;
	zCView* viewItemInfoItem;
	zCView* textView;
	zCView* viewArrowAtTop;
	zCView* viewArrowAtBottom;
	zCWorld* rndWorld;
	int posx;
	int posy;
	int m_bManipulateItemsDisabled;
	int m_bCanTransferMoreThanOneItem;
};
 
class oCNpcInventory : public oCItemContainer {
	public:
	oCNpc* owner;
	int packAbility;
	zCListSort<oCItem> inventory;
	zSTRING packString;
	int maxSlots; 
*/

class oCItemContainer {
	//oCNpcInventory {
	//oCItemContainer {
	var int    inventory2_vtbl;                                           // 0x0668
	var int    inventory2_oCItemContainer_contents;                       // 0x066C zCListSort<oCItem>*
	var int    inventory2_oCItemContainer_npc;                            // 0x0670 oCNpc*
	var string inventory2_oCItemContainer_titleText;                      // 0x0674 zSTRING
	var int    inventory2_oCItemContainer_invMode;                        // 0x0688 int
	var int    inventory2_oCItemContainer_selectedItem;                   // 0x068C int
	var int    inventory2_oCItemContainer_offset;                         // 0x0690 int
	var int    inventory2_oCItemContainer_maxSlotsCol;                    // 0x0694 int
	var int    inventory2_oCItemContainer_maxSlotsColScr;                 // 0x0698 int
	var int    inventory2_oCItemContainer_maxSlotsRow;                    // 0x069C int
	var int    inventory2_oCItemContainer_maxSlotsRowScr;                 // 0x06A0 int
	var int    inventory2_oCItemContainer_maxSlots;                       // 0x06A4 int
	var int    inventory2_oCItemContainer_marginTop;                      // 0x06A8 int
	var int    inventory2_oCItemContainer_marginLeft;                     // 0x06AC int
	var int    inventory2_oCItemContainer_frame;                          // 0x06B0 zBOOL
	var int    inventory2_oCItemContainer_right;                          // 0x06B4 zBOOL
	var int    inventory2_oCItemContainer_ownList;                        // 0x06B8 zBOOL
	var int    inventory2_oCItemContainer_prepared;                       // 0x06BC zBOOL
	var int    inventory2_oCItemContainer_passive;                        // 0x06C0 zBOOL
	var int    inventory2_oCItemContainer_TransferCount;                  // 0x06C4 zINT
	var int    inventory2_oCItemContainer_viewTitle;                      // 0x06C8 zCView*
	var int    inventory2_oCItemContainer_viewBack;                       // 0x06CC zCView*
	var int    inventory2_oCItemContainer_viewItem;                       // 0x06D0 zCView*
	var int    inventory2_oCItemContainer_viewItemActive;                 // 0x06D4 zCView*
	var int    inventory2_oCItemContainer_viewItemHightlighted;           // 0x06D8 zCView*
	var int    inventory2_oCItemContainer_viewItemActiveHighlighted;      // 0x06DC zCView*
	var int    inventory2_oCItemContainer_viewItemInfo;                   // 0x06E0 zCView*
	var int    inventory2_oCItemContainer_viewItemInfoItem;               // 0x06E4 zCView*
	var int    inventory2_oCItemContainer_textView;                       // 0x06E8 zCView*
	var int    inventory2_oCItemContainer_viewArrowAtTop;                 // 0x06EC zCView*
	var int    inventory2_oCItemContainer_viewArrowAtBottom;              // 0x06F0 zCView*
	var int    inventory2_oCItemContainer_rndWorld;                       // 0x06F4 zCWorld*
	var int    inventory2_oCItemContainer_posx;                           // 0x06F8 int
	var int    inventory2_oCItemContainer_posy;                           // 0x06FC int
	var int    inventory2_oCItemContainer_m_bManipulateItemsDisabled;     // 0x0700 zBOOL
	var int    inventory2_oCItemContainer_m_bCanTransferMoreThanOneItem;  // 0x0704 zBOOL
	//}
};

class oCNpcInventory {
	//oCNpcInventory {
	//oCItemContainer {
	var int    inventory2_vtbl;                                           // 0x0668
	var int    inventory2_oCItemContainer_contents;                       // 0x066C zCListSort<oCItem>*
	var int    inventory2_oCItemContainer_npc;                            // 0x0670 oCNpc*
	var string inventory2_oCItemContainer_titleText;                      // 0x0674 zSTRING
	var int    inventory2_oCItemContainer_invMode;                        // 0x0688 int
	var int    inventory2_oCItemContainer_selectedItem;                   // 0x068C int
	var int    inventory2_oCItemContainer_offset;                         // 0x0690 int
	var int    inventory2_oCItemContainer_maxSlotsCol;                    // 0x0694 int
	var int    inventory2_oCItemContainer_maxSlotsColScr;                 // 0x0698 int
	var int    inventory2_oCItemContainer_maxSlotsRow;                    // 0x069C int
	var int    inventory2_oCItemContainer_maxSlotsRowScr;                 // 0x06A0 int
	var int    inventory2_oCItemContainer_maxSlots;                       // 0x06A4 int
	var int    inventory2_oCItemContainer_marginTop;                      // 0x06A8 int
	var int    inventory2_oCItemContainer_marginLeft;                     // 0x06AC int
	var int    inventory2_oCItemContainer_frame;                          // 0x06B0 zBOOL
	var int    inventory2_oCItemContainer_right;                          // 0x06B4 zBOOL
	var int    inventory2_oCItemContainer_ownList;                        // 0x06B8 zBOOL
	var int    inventory2_oCItemContainer_prepared;                       // 0x06BC zBOOL
	var int    inventory2_oCItemContainer_passive;                        // 0x06C0 zBOOL
	var int    inventory2_oCItemContainer_TransferCount;                  // 0x06C4 zINT
	var int    inventory2_oCItemContainer_viewTitle;                      // 0x06C8 zCView*
	var int    inventory2_oCItemContainer_viewBack;                       // 0x06CC zCView*
	var int    inventory2_oCItemContainer_viewItem;                       // 0x06D0 zCView*
	var int    inventory2_oCItemContainer_viewItemActive;                 // 0x06D4 zCView*
	var int    inventory2_oCItemContainer_viewItemHightlighted;           // 0x06D8 zCView*
	var int    inventory2_oCItemContainer_viewItemActiveHighlighted;      // 0x06DC zCView*
	var int    inventory2_oCItemContainer_viewItemInfo;                   // 0x06E0 zCView*
	var int    inventory2_oCItemContainer_viewItemInfoItem;               // 0x06E4 zCView*
	var int    inventory2_oCItemContainer_textView;                       // 0x06E8 zCView*
	var int    inventory2_oCItemContainer_viewArrowAtTop;                 // 0x06EC zCView*
	var int    inventory2_oCItemContainer_viewArrowAtBottom;              // 0x06F0 zCView*
	var int    inventory2_oCItemContainer_rndWorld;                       // 0x06F4 zCWorld*
	var int    inventory2_oCItemContainer_posx;                           // 0x06F8 int
	var int    inventory2_oCItemContainer_posy;                           // 0x06FC int
	var int    inventory2_oCItemContainer_m_bManipulateItemsDisabled;     // 0x0700 zBOOL
	var int    inventory2_oCItemContainer_m_bCanTransferMoreThanOneItem;  // 0x0704 zBOOL
	//}

	var int    inventory2_owner;                                          // 0x0708 oCNpc*
	var int    inventory2_packAbility;                                    // 0x070C zBOOL
	//zCListSort<oCItem> {
	var int    inventory2_inventory_Compare;                              // 0x0710 int(_cdecl*)(oCItem*,oCItem*)
	var int    inventory2_inventory_data;                                 // 0x0714 oCItem*
	var int    inventory2_inventory_next;                                 // 0x0718 zCListSort<oCItem>*
	//}
	var string inventory2_packString;                                     // 0x071C zSTRING
	var int    inventory2_maxSlots;                                       // 0x0730 int
	//}
};
