/*
If you donwload latest version of this script packet (and you should do that right away :) ) you will overwrite this 'API' file.
You should copy-paste below function to your own file, make your own changes, link it to Gothic.src and comment out this one ...
*/

/*
 *	Define your own logic here - when should rain start?
 */
func void RainControl_API () {
	if (Wld_SetRainTime (04, 30, 05, 30)) {
	} else if (Wld_SetRainTime (09, 30, 10, 30)) {
	} else if (Wld_SetRainTime (12, 30, 13, 30)) {
	} else if (Wld_SetRainTime (16, 30, 17, 30)) {
	} else if (Wld_SetRainTime (19, 30, 20, 30)) {
	};
};
