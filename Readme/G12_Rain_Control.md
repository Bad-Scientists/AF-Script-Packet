## G12 Rain Control
 - Allows you to control weather via API function `RainControl_SetupRain`
 
Init function: `G12_RainControl_Init();`

[API file](../Standalone-Packages/G12-RainControl/rainControl_API.d)

Additionaly you can interact with Rain using these functions:

```c++
//weatherType = [zTWEATHER_SNOW, zTWEATHER_RAIN]
void Wld_ResetWeather(); //resets weather overrides enabled by this feature.
void Wld_SetWeatherType(weatherType); //G2 NoTR only - sets weather type: snow or rain
void Wld_ForceWeatherType(weatherType); //G2 NoTR only - forces weather type: snow or rain
void Wld_SetDontRain(RainControl_DontRain); //if set to true - it will never rain
void Wld_SetRainForever(RainControl_RainForever); //if set to true - it will always rain
void Wld_SetRainOff(); //shuts off rain immediately
void Wld_SetRainOn(); //turns on rain immediately
void Wld_StartRain(newDuration); //fades in rain smoothly - for specified newDuration time (in minutes)
void Wld_StopRain(); //fades out rain smoothly - within next 5 in-game minutes
int Wld_SetRainTime(start_hr, start_min, end_hr, end_min); //if we are within specified time-range, then this function will turn on rain. Returns true if we are within time-range
```
