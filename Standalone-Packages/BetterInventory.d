//BetterInventory:tm: - very unfinished

/*
How it could be:tm:

class BI_cell {
	var string texture; // base texture
	var int state;		//  slot focus | focus highlited | focus equiped | focus equiped highlighted 
						//	slot       |       highlited |       equiped |       equiped highlighted 
	// cell position
	var int x1
	var int y1
	var int x2
	var int y2
};

class BI_inventory {
	var string titles[NUM_CAT]; // array of inventory category titles (All, Weapons, Armour, Magic, Artifacts, Food, Potions, Written, Misc)
	
	var int cells[NUM_CELLS]; 	// array holds handles for all cells
};
*/

/*
=======================
=== gameKeyEvents.d ===
=======================
if (key == KEY_J) && (pressed) {
		if (!BI_flip){ 	
			if (!BI_once) { 
				BI_Init(); //generates views and hides them (makes them ready, basically) - Should be done sooner than here, but it doesn't work in startup.d
				BI_once = 1;
			};
			BI_test();
			BI_flip = 1;
		} else {
			BI_unload();
			BI_flip = 0;
		};
	};

if ( BI_STATE == BI_DIALOG_INVENTORY) {

		if (key == KEY_LEFTARROW || key == KEY_A) && (pressed){
			if (BI_focus%BI_COLS != 0 && BI_focus < NUM_CELLS){
				BI_DeselectSlot(BI_focus);
				BI_focus -= 1;
				BI_SelectSlot(BI_focus);
			};	
		};
		if (key == KEY_RIGHTARROW || key == KEY_D) && (pressed){
			if (BI_focus%BI_COLS != BI_COLS - 1 && BI_focus < NUM_CELLS){
				BI_DeselectSlot(BI_focus);
				BI_focus += 1;
				BI_SelectSlot(BI_focus);
			};
		};
		if (key == KEY_UPARROW || key == KEY_W) && (pressed){
			if (1 && BI_focus < NUM_CELLS){
				BI_DeselectSlot(BI_focus);
				BI_focus -= BI_COLS;
				BI_SelectSlot(BI_focus);
			};	
		};
		if (key == KEY_DOWNARROW || key == KEY_S) && (pressed){
			if (1 && BI_focus < NUM_CELLS){
				BI_DeselectSlot(BI_focus);
				BI_focus += BI_COLS;
				BI_SelectSlot(BI_focus);
			};
		};
	return FALSE;
	};
	
======================	
=== AI_constants.d ===
======================
var int 	BI_STATE;

const int 	BI_DIALOG_NONE   		= 0;
const int 	BI_DIALOG_INVENTORY  	= 1;
const int 	BI_DIALOG_TRADING	  	= 2;

=================
=== globals.d ===
=================

var int PS_VMax_Height;
var int PS_VMax_Mltp;

var int BI_once;
var int BI_flip;

*/

//constants in virtual coords (saves the hassle to manually recalc them for all the resolution)
const int Cell_size_X = 425;
const int Margin = 50;
const int Left_Margin = Margin;
const int Right_Margin = PS_VMax - Left_Margin - Cell_size_X;
const int Top_Margin = Margin;

const int BI_COLS = 4;
const int BI_ROWS = 7;

const int NUM_CELLS = BI_COLS * BI_ROWS;
var int Arr_cells[NUM_CELLS];
var int BI_focus;

var int title;



func int CV(var int inp){ //inp is in virtual coords, translates the height to the correct aspect ratio based on players setting 
	return roundf(mulf(mkf(inp), PS_VMax_Mltp));
};

func int BI_Render_Cell(var int x1, var int y1, var int x2, var int y2, var string texture){
	var int zCViewPtr;
	zCViewPtr = View_Create(x1, y1, x1+x2, y1+y2);
	View_SetTexture(zCViewPtr, texture);
	//MEM_Info(PV ("zCViewPtr", zCViewPtr));
	if (Hlp_StrCmp(texture, "Inv_Titel.tga")){
		// TODO: position and size could be calculated based on the size of the text :thinking:
		View_AddText(zCViewPtr, 1024 , 1024+512, /*"Badlands Chugs"*/"Vše", "Font_Old_10_White.tga");  
	};
	return Render_AddView(zCViewPtr);
};

func void BI_SelectSlot (var int id) {
	var int src; src = _@(Arr_cells);
	var int cellHandle; cellHandle = MEM_ReadIntArray(src, id);
	//MEM_Info(PV ("cellHandle", cellHandle));


    View_SetTexture(cellHandle-1, "Inv_Slot_Highlighted_Focus.tga");

};

func void BI_DeselectSlot (var int id) {
	var int src; src = _@(Arr_cells);
	var int cellHandle; cellHandle = MEM_ReadIntArray(src, id);
	//MEM_Info(PV ("cellHandle", cellHandle));
	
    View_SetTexture(cellHandle-1, "Inv_Slot_Focus.tga");

};

func int BI_AddCell(var int x){
	if(x == 0){ return 0; };
	return x * (Cell_size_X + Margin/5);
};

func void fillArray(var int id, var int x1, var int y1, var int x2, var int y2, var string texture )
{
    var int src; src = _@(Arr_cells);
    MEM_WriteIntArray(src, id, BI_Render_Cell(x1, y1, x2, y2, texture));
};                            		

func int retArray(var int ID){
	var int src; src = _@(Arr_cells);
    MEM_ReadIntArray(src, id);
};



func int BI_Init(){
	MEM_Info("===============================================");
	MEM_Info("           BI_Init()");
	MEM_Info("===============================================");
	PS_VMax_Height = roundf(mulf(divf(mkf(Print_Screen[PS_Y]), mkf(Print_Screen[PS_X])), mkf(PS_VMax)));
	PS_VMax_Mltp = divf(mkf(Print_Screen[PS_X]), mkf(Print_Screen[PS_Y]));
	BI_focus = 0;
	
//========== create label view
	title = BI_Render_Cell(Right_Margin - BI_AddCell(BI_COLS-1), CV(Top_Margin), Cell_size_X, CV(180) , "Inv_Titel.tga");
	MEM_Info(PV("title",title));
	// hide the view
	//Render_CloseView(title);
	
//========== fill cell array with view handles
	MEM_InitLabels();


	var int x; var int y; var int arrIndex;
    x = 0; 
    
    /* while (x < max_x) */
    var int x_loop; x_loop = MEM_StackPos.position;
    if (x < BI_ROWS) {
        y = 0;
        /* while (y < max_y) */
        var int y_loop; y_loop = MEM_StackPos.position;
        if (y < BI_COLS) {
			fillArray(	x * BI_COLS + y, 
						Right_Margin - BI_AddCell(BI_COLS-y-1), 
						CV(Top_Margin + 180 + Margin) + CV(BI_AddCell(x)), 
						Cell_size_X, CV(Cell_size_X), 
						"Inv_Slot_Focus.tga");	
			MEM_Info(PV("BI_COLS-y",BI_COLS-y));				
			y += 1;
            /* continue y_loop */
            MEM_StackPos.position = y_loop;
        };
        x += 1;    
        /* continue x_loop */
        MEM_StackPos.position = x_loop;
    };
	
	// hide all of the cells
	MEM_InitLabels();

    x = 0; 
    
    // while (x < max_x) 
	x_loop = MEM_StackPos.position;
    if (x < BI_ROWS) {
        y = 0;
        // while (y < max_y) 
		y_loop = MEM_StackPos.position;
        if (y < BI_COLS) {
			Render_CloseView(retArray( x * BI_COLS + y )); 
			y += 1;
            // continue y_loop 
            MEM_StackPos.position = y_loop;
        };
        x += 1;    
        // continue x_loop 
        MEM_StackPos.position = x_loop;
    };

	
};


func void BI_test(){ //show inventory
	/*
	var int 	BI_STATE;

	const int 	BI_DIALOG_NONE   		= 0;
	const int 	BI_DIALOG_INVENTORY  	= 1;
	const int 	BI_DIALOG_TRADING	  	= 2;
	*/
	BI_STATE = BI_DIALOG_INVENTORY;

	
	Render_OpenView(title);	
	
	BI_SelectSlot(BI_focus);
	
	MEM_InitLabels();

	var int x; var int y; var int arrIndex;
    x = 0; 
    
    /* while (x < max_x) */
    var int x_loop; x_loop = MEM_StackPos.position;
    if (x < BI_ROWS) {
        y = 0;
        /* while (y < max_y) */
        var int y_loop; y_loop = MEM_StackPos.position;
        if (y < BI_COLS) {
			Render_OpenView(retArray( x * BI_COLS + y )); 
			y += 1;
            /* continue y_loop */
            MEM_StackPos.position = y_loop;
        };
        x += 1;    
        /* continue x_loop */
        MEM_StackPos.position = x_loop;
    };
};

func void BI_unload(){
	Render_CloseView(title);
	
	BI_STATE = BI_DIALOG_NONE;
//======= Closing views stored in array	=======
	MEM_InitLabels();

	var int x; var int y; var int arrIndex;
    x = 0; 
    
    /* while (x < max_x) */
    var int x_loop; x_loop = MEM_StackPos.position;
    if (x < BI_ROWS) {
        y = 0;
        /* while (y < max_y) */
        var int y_loop; y_loop = MEM_StackPos.position;
        if (y < BI_COLS) {
			Render_CloseView(retArray( x * BI_COLS + y )); 
			y += 1;
            /* continue y_loop */
            MEM_StackPos.position = y_loop;
        };
        x += 1;    
        /* continue x_loop */
        MEM_StackPos.position = x_loop;
    };
//=======================================	
};