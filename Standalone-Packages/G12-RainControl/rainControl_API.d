/*
 *	Rain control
 *
 *	1. Copy this file outside of script-packet
 *	2. Customize it (define your own rules for when it should be raining)
 *	3. Link it to Gothic.src
 *	4. Profit
 */

/*
 *	Example
 *	Here it will be raining during specified time period
 */
func void RainControl_SetupRain () {
	if (Wld_SetRainTime (04, 30, 05, 30)) {
	} else if (Wld_SetRainTime (09, 30, 10, 30)) {
	} else if (Wld_SetRainTime (12, 30, 13, 30)) {
	} else if (Wld_SetRainTime (16, 30, 17, 30)) {
	} else if (Wld_SetRainTime (19, 30, 20, 30)) {
	};
};
