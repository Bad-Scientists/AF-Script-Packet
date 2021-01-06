var int Barrier_FadeStateMin;	//Min alpha value (cannot be 0! otherwise Barrier will disappear)

/*
 *	Function will start Barriers fade in effect
 */
func void oCBarrier_FadeIn (){
	var oCBarrier b; b = _^ (MEM_SkyController.barrier);

	//Start fade in
	b.fadeIn = TRUE;
};

func void _hook_oCBarrier_Render (){
	var oCBarrier b; b = _^ (ECX);

	if (b.fadeOut) {
		//If Barrier.fadeState == 0 then Barrier disappears completely
		//We don't want that, set our minimal acceptable value Barrier_FadeStateMin = 1
		if (Barrier_FadeStateMin == 0) {
			Barrier_FadeStateMin = 1;
		};
		
		//If we reached out minimal acceptable fade value - stop fading out
		if (b.fadeState == Barrier_FadeStateMin){
			b.fadeOut = FALSE;
		};
	};
};

func void G1_Barrier_Everlooming_Init (){
	const int once = 0;

	if (!once){
		Barrier_FadeStateMin = Hlp_Random (15) + 1; //Random minimal fadeState 1 - 15
		//Hook makes sure that Barrier will never disappear completely
		HookEngine (oCBarrier__Render, 6, "_hook_oCBarrier_Render");
		once = 1;
	};
};