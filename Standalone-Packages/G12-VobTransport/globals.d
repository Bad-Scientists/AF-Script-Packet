//--- vob Transport global variables & constants
const int vobTransportCollectVobsRange			= 500;
const int vobTransportCollectVobSlotRange		= 500;
const int vobTransportAlignVobSlotRange			= 100;

var int vobTransportVobPtr;
var int vobTransportOriginalTrafo[16];
var int vobTransportOriginalAlphaChanged;
var int vobTransportOriginalAlphaEnabled;
var int vobTransportOriginalAlpha;
var int vobTransportOriginalCollisions;

var int vobTransportShowcaseVobPtr;

var int vobTransportShowcaseVobIndex;
var int vobTransportShowcaseVobVerticalIndex;
var int vobTransportShowcaseVobBuyValue;

var int vobTransportVobChanged;

var int vobTransportBBoxPtr;

var int lastVobTransportMode;
var int vobTransportMode;
	const int vobTransportMode_Idle			= 0;
	const int vobTransportMode_Init			= 1;

	const int vobTransportMode_SelectVob		= 2;
	const int vobTransportMode_SelectNext		= 3;
	const int vobTransportMode_SelectPrev		= 4;
	const int vobTransportMode_SelectConfirm	= 5;

	const int vobTransportMode_Transform		= 6;
	const int vobTransportMode_Movement		= 7;
	const int vobTransportMode_Done			= 8;

	const int vobTransportMode_BuyVob		= 9;
	const int vobTransportMode_BuyVobSelect		= 10;

var int vobTransportActionMode;
	const int vobTransportActionMode_Clone		= 0;
	const int vobTransportActionMode_Move		= 1;
	const int vobTransportActionMode_DropItem	= 2;
	const int vobTransportActionMode_Edit		= 3;	//Not yet implemented

var int vobTransportTransformationMode;
	const int vobTransportTransformation_RotY	= 0;	//Default - rotation on Y axies
	const int vobTransportTransformation_RotX	= 1;
	const int vobTransportTransformation_RotZ	= 2;

var int vobTransportAlignObject;
	const int vobTransportAlignObject_Dont		= 0;
	const int vobTransportAlignObject_InFront	= 1;
	const int vobTransportAlignObject_SetToFloor	= 2;

var int vobTransportMovementSpeed;

var int vobTransportOffset[3];

//--- Vob Transport view handles

//Properties view
var int hVobTransportPropertiesViewFrame;		//Frame
var int hVobTransportPropertiesViewHeader;		//Header - I have this one extra - because of color (probably does not have to be extra)
var int hVobTransportPropertiesView;			//View itself

var int vobTransportPropertiesViewVisible;

//Buy Vob view
var int hVobTransportBuyVobViewFrame;

var int hVobTransportBuyVobView_Description;

var int hVobTransportBuyVobView_Line1;
var int hVobTransportBuyVobView_Line2;
var int hVobTransportBuyVobView_Line3;
var int hVobTransportBuyVobView_Line4;
var int hVobTransportBuyVobView_Line5;

var int hVobTransportBuyVobView_Count1;
var int hVobTransportBuyVobView_Count2;
var int hVobTransportBuyVobView_Count3;
var int hVobTransportBuyVobView_Count4;
var int hVobTransportBuyVobView_Count5;

var string sVobTransportBuyVobView_Description;
var string sVobTransportBuyVobView_Line1;
var string sVobTransportBuyVobView_Line2;
var string sVobTransportBuyVobView_Line3;
var string sVobTransportBuyVobView_Line4;
var string sVobTransportBuyVobView_Line5;

var string sVobTransportBuyVobView_Count1;
var string sVobTransportBuyVobView_Count2;
var string sVobTransportBuyVobView_Count3;
var string sVobTransportBuyVobView_Count4;
var string sVobTransportBuyVobView_Count5;

var int colorVobTransportBuyVobView_Count1;
var int colorVobTransportBuyVobView_Count2;
var int colorVobTransportBuyVobView_Count3;
var int colorVobTransportBuyVobView_Count4;
var int colorVobTransportBuyVobView_Count5;

var int vobTransportBuyVobViewVisible;
