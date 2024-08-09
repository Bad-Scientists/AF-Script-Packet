## G1 Ever looming barrier
 - Hooks Barrier render function and prevents Barrier from disappearing completely. \#immersion

    [![G1 Ever looming barrier](https://img.youtube.com/vi/ZEyFpN-f0Y8/0.jpg)](https://www.youtube.com/watch?v=ZEyFpN-f0Y8)

Init function: `G1_BarrierEverlooming_Init ();`

Additionaly you can interact with Barrier using these functions:
```c++
//use fadeState -1 to start from current fade state
//max fadeState value is 120

void oCBarrier_Hide(); //hides Barrier immediately. Barrier will reappear after a while. (vanilla cycle)
void oCBarrier_FadeIn(var int fadeState); //fades in Barrier from fadeState
void oCBarrier_FadeOut(var int fadeState); //fades out Barrier from fadeState
```