/*
 *	oCItemContainer, oCNpcInventory are taken from Ikarus G1 oCNPC class definition
 */ 

class oCItemContainer {
//      oCItemContainer inventory2 {
            var int    inventory2_vtbl;                           				   // 0x0550
            var int    inventory2_oCItemContainer_contents;                        // 0x0554 zCListSort<oCItem>*
            var int    inventory2_oCItemContainer_npc;                             // 0x0558 oCNpc*
            var int    inventory2_oCItemContainer_selectedItem;                    // 0x055C int
            var int    inventory2_oCItemContainer_offset;                          // 0x0560 int
            var int    inventory2_oCItemContainer_drawItemMax;                     // 0x0564 int
            var int    inventory2_oCItemContainer_itemListMode;                    // 0x0568 oTItemListMode
            var int    inventory2_oCItemContainer_frame;                           // 0x056C zBOOL
            var int    inventory2_oCItemContainer_right;                           // 0x0570 zBOOL
            var int    inventory2_oCItemContainer_ownList;                         // 0x0574 zBOOL
            var int    inventory2_oCItemContainer_prepared;                        // 0x0578 zBOOL
            var int    inventory2_oCItemContainer_passive;                         // 0x057C zBOOL
            var int    inventory2_oCItemContainer_viewCat;                         // 0x0580 zCView*
            var int    inventory2_oCItemContainer_viewItem;                        // 0x0584 zCView*
            var int    inventory2_oCItemContainer_viewItemActive;                  // 0x0588 zCView*
            var int    inventory2_oCItemContainer_viewItemHightlighted;            // 0x058C zCView*
            var int    inventory2_oCItemContainer_viewItemActiveHighlighted;       // 0x0590 zCView*
            var int    inventory2_oCItemContainer_viewItemFocus;                   // 0x0594 zCView*
            var int    inventory2_oCItemContainer_viewItemActiveFocus;             // 0x0598 zCView*
            var int    inventory2_oCItemContainer_viewItemHightlightedFocus;       // 0x059C zCView*
            var int    inventory2_oCItemContainer_viewItemActiveHighlightedFocus;  // 0x05A0 zCView*
            var int    inventory2_oCItemContainer_viewItemInfo;                    // 0x05A4 zCView*
            var int    inventory2_oCItemContainer_viewItemInfoItem;                // 0x05A8 zCView*
            var int    inventory2_oCItemContainer_textView;                        // 0x05AC zCView*
            var int    inventory2_oCItemContainer_viewArrowAtTop;                  // 0x05B0 zCView*
            var int    inventory2_oCItemContainer_viewArrowAtBottom;               // 0x05B4 zCView*
            var int    inventory2_oCItemContainer_rndWorld;                        // 0x05B8 zCWorld*
            var int    inventory2_oCItemContainer_posx;                            // 0x05BC int
            var int    inventory2_oCItemContainer_posy;                            // 0x05C0 int
            var string inventory2_oCItemContainer_textCategoryStatic;              // 0x05C4 zSTRING
            var int    inventory2_oCItemContainer_m_bManipulateItemsDisabled;      // 0x05D8 zBOOL
            var int    inventory2_oCItemContainer_m_bCanTransferMoreThanOneItem;   // 0x05DC zBOOL
            var int    inventory2_oCItemContainer_image_chroma;                    // 0x05E0 zCOLOR
            var int    inventory2_oCItemContainer_blit_chroma;                     // 0x05E4 zCOLOR
//      }
};

class oCNpcInventory {
//  oCNpcInventory {
//      oCItemContainer inventory2 {
            var int    inventory2_vtbl;                           				   // 0x0550
            var int    inventory2_oCItemContainer_contents;                        // 0x0554 zCListSort<oCItem>*
            var int    inventory2_oCItemContainer_npc;                             // 0x0558 oCNpc*
            var int    inventory2_oCItemContainer_selectedItem;                    // 0x055C int
            var int    inventory2_oCItemContainer_offset;                          // 0x0560 int
            var int    inventory2_oCItemContainer_drawItemMax;                     // 0x0564 int
            var int    inventory2_oCItemContainer_itemListMode;                    // 0x0568 oTItemListMode
            var int    inventory2_oCItemContainer_frame;                           // 0x056C zBOOL
            var int    inventory2_oCItemContainer_right;                           // 0x0570 zBOOL
            var int    inventory2_oCItemContainer_ownList;                         // 0x0574 zBOOL
            var int    inventory2_oCItemContainer_prepared;                        // 0x0578 zBOOL
            var int    inventory2_oCItemContainer_passive;                         // 0x057C zBOOL
            var int    inventory2_oCItemContainer_viewCat;                         // 0x0580 zCView*
            var int    inventory2_oCItemContainer_viewItem;                        // 0x0584 zCView*
            var int    inventory2_oCItemContainer_viewItemActive;                  // 0x0588 zCView*
            var int    inventory2_oCItemContainer_viewItemHightlighted;            // 0x058C zCView*
            var int    inventory2_oCItemContainer_viewItemActiveHighlighted;       // 0x0590 zCView*
            var int    inventory2_oCItemContainer_viewItemFocus;                   // 0x0594 zCView*
            var int    inventory2_oCItemContainer_viewItemActiveFocus;             // 0x0598 zCView*
            var int    inventory2_oCItemContainer_viewItemHightlightedFocus;       // 0x059C zCView*
            var int    inventory2_oCItemContainer_viewItemActiveHighlightedFocus;  // 0x05A0 zCView*
            var int    inventory2_oCItemContainer_viewItemInfo;                    // 0x05A4 zCView*
            var int    inventory2_oCItemContainer_viewItemInfoItem;                // 0x05A8 zCView*
            var int    inventory2_oCItemContainer_textView;                        // 0x05AC zCView*
            var int    inventory2_oCItemContainer_viewArrowAtTop;                  // 0x05B0 zCView*
            var int    inventory2_oCItemContainer_viewArrowAtBottom;               // 0x05B4 zCView*
            var int    inventory2_oCItemContainer_rndWorld;                        // 0x05B8 zCWorld*
            var int    inventory2_oCItemContainer_posx;                            // 0x05BC int
            var int    inventory2_oCItemContainer_posy;                            // 0x05C0 int
            var string inventory2_oCItemContainer_textCategoryStatic;              // 0x05C4 zSTRING
            var int    inventory2_oCItemContainer_m_bManipulateItemsDisabled;      // 0x05D8 zBOOL
            var int    inventory2_oCItemContainer_m_bCanTransferMoreThanOneItem;   // 0x05DC zBOOL
            var int    inventory2_oCItemContainer_image_chroma;                    // 0x05E0 zCOLOR
            var int    inventory2_oCItemContainer_blit_chroma;                     // 0x05E4 zCOLOR
//      }
        var int        inventory2_owner;                           // 0x05E8 oCNpc*
        var int        inventory2_packAbility;                     // 0x05EC zBOOL
//      zCListSort<oCItem>[INV_MAX] inventory {
            var int    inventory2_inventory0_Compare;              // 0x05F0 int(_cdecl*)(oCItem*,oCItem*)
            var int    inventory2_inventory0_data;                 // 0x05F4 oCItem*
            var int    inventory2_inventory0_next;                 // 0x05F8 zCListSort<oCItem>*
            var int    inventory2_inventory1_Compare;              // 0x05FC int(_cdecl*)(oCItem*,oCItem*)
            var int    inventory2_inventory1_data;                 // 0x0600 oCItem*
            var int    inventory2_inventory1_next;                 // 0x0604 zCListSort<oCItem>*
            var int    inventory2_inventory2_Compare;              // 0x0608 int(_cdecl*)(oCItem*,oCItem*)
            var int    inventory2_inventory2_data;                 // 0x060C oCItem*
            var int    inventory2_inventory2_next;                 // 0x0610 zCListSort<oCItem>*
            var int    inventory2_inventory3_Compare;              // 0x0614 int(_cdecl*)(oCItem*,oCItem*)
            var int    inventory2_inventory3_data;                 // 0x0618 oCItem*
            var int    inventory2_inventory3_next;                 // 0x061C zCListSort<oCItem>*
            var int    inventory2_inventory4_Compare;              // 0x0620 int(_cdecl*)(oCItem*,oCItem*)
            var int    inventory2_inventory4_data;                 // 0x0624 oCItem*
            var int    inventory2_inventory4_next;                 // 0x0628 zCListSort<oCItem>*
            var int    inventory2_inventory5_Compare;              // 0x062C int(_cdecl*)(oCItem*,oCItem*)
            var int    inventory2_inventory5_data;                 // 0x0630 oCItem*
            var int    inventory2_inventory5_next;                 // 0x0634 zCListSort<oCItem>*
            var int    inventory2_inventory6_Compare;              // 0x0638 int(_cdecl*)(oCItem*,oCItem*)
            var int    inventory2_inventory6_data;                 // 0x063C oCItem*
            var int    inventory2_inventory6_next;                 // 0x0640 zCListSort<oCItem>*
            var int    inventory2_inventory7_Compare;              // 0x0644 int(_cdecl*)(oCItem*,oCItem*)
            var int    inventory2_inventory7_data;                 // 0x0648 oCItem*
            var int    inventory2_inventory7_next;                 // 0x064C zCListSort<oCItem>*
            var int    inventory2_inventory8_Compare;              // 0x0650 int(_cdecl*)(oCItem*,oCItem*)
            var int    inventory2_inventory8_data;                 // 0x0654 oCItem*
            var int    inventory2_inventory8_next;                 // 0x0658 zCListSort<oCItem>*
//      }
        var string     inventory2_packString;                      // 0x065C zSTRING[INV_MAX]
        var string     inventory2_packString1;
        var string     inventory2_packString2;
        var string     inventory2_packString3;
        var string     inventory2_packString4;
        var string     inventory2_packString5;
        var string     inventory2_packString6;
        var string     inventory2_packString7;
        var string     inventory2_packString8;
        var int        inventory2__offset[9];                      // 0x0710 int[INV_MAX]
        var int        inventory2__itemnr[9];                      // 0x0734 int[INV_MAX]
        var int        inventory2_maxSlots[9];                     // 0x0758 int[INV_MAX]
        var int        inventory2_invnr;                           // 0x077C int
//  }
};
