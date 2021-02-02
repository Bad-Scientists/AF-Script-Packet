/***/

func void mulVectors (var int v, var int v1, var int v2)
{
	MEM_WriteIntArray (v, 0, mulf(MEM_ReadIntArray(v1,  0), MEM_ReadIntArray(v2,  0)));
	MEM_WriteIntArray (v, 1, mulf(MEM_ReadIntArray(v1,  1), MEM_ReadIntArray(v2,  1)));
	MEM_WriteIntArray (v, 2, mulf(MEM_ReadIntArray(v1,  2), MEM_ReadIntArray(v2,  2)));
};

func void divVectors (var int v, var int v1, var int v2)
{
	if (MEM_ReadIntArray(v2,  0) != 0) {	MEM_WriteIntArray (v, 0, divf(MEM_ReadIntArray(v1,  0), MEM_ReadIntArray(v2,  0))); };
	if (MEM_ReadIntArray(v2,  1) != 0) {	MEM_WriteIntArray (v, 1, divf(MEM_ReadIntArray(v1,  1), MEM_ReadIntArray(v2,  1))); };
	if (MEM_ReadIntArray(v2,  2) != 0) {	MEM_WriteIntArray (v, 2, divf(MEM_ReadIntArray(v1,  2), MEM_ReadIntArray(v2,  2))); };
};

//copy vector v1 to v2
//v1 - pointer to vector 1
//v2 - pointer to vector 2
func void copyVector (var int v1, var int v2)
{
	MEM_CopyBytes (v1, v2, 12);
};

//adds vector v2 to v1
//v - output pointer
//v1 - pointer to vector 1
//v2 - pointer to vector 2
func void addVectors (var int v, var int v1, var int v2)
{
	MEM_WriteIntArray (v, 0, addf(MEM_ReadIntArray(v1,  0), MEM_ReadIntArray(v2,  0)));
	MEM_WriteIntArray (v, 1, addf(MEM_ReadIntArray(v1,  1), MEM_ReadIntArray(v2,  1)));
	MEM_WriteIntArray (v, 2, addf(MEM_ReadIntArray(v1,  2), MEM_ReadIntArray(v2,  2)));
};

//subtracts vector v2 from v1
//v - output pointer
//v1 - pointer to vector 1
//v2 - pointer to vector 2
func void subVectors (var int v, var int v1, var int v2)
{
	MEM_WriteIntArray (v, 0, subf(MEM_ReadIntArray(v1,  0), MEM_ReadIntArray(v2,  0)));
	MEM_WriteIntArray (v, 1, subf(MEM_ReadIntArray(v1,  1), MEM_ReadIntArray(v2,  1)));
	MEM_WriteIntArray (v, 2, subf(MEM_ReadIntArray(v1,  2), MEM_ReadIntArray(v2,  2)));
};

//scale the vector with division
//v1 - pointer to vector
//m - division scalar
func void divVector (var int v1, var int d)
{
	if (!d) { return; };
	MEM_WriteIntArray (v1, 0, divf(MEM_ReadIntArray(v1,  0), d));
	MEM_WriteIntArray (v1, 1, divf(MEM_ReadIntArray(v1,  1), d));
	MEM_WriteIntArray (v1, 2, divf(MEM_ReadIntArray(v1,  2), d));
};

//scale the vector with multiplication
//v1 - pointer to vector
//m - multiplication scalar
func void mulVector (var int v1, var int m)
{
	MEM_WriteIntArray (v1, 0, mulf(MEM_ReadIntArray(v1,  0), m));
	MEM_WriteIntArray (v1, 1, mulf(MEM_ReadIntArray(v1,  1), m));
	MEM_WriteIntArray (v1, 2, mulf(MEM_ReadIntArray(v1,  2), m));
};

//returns magnitude of a vector
//v1 - pointer to vector
FUNC INT magVector (var int v1)
{
	return sqrtf (addf (addf (sqrf (MEM_ReadIntArray(v1,  0)), sqrf (MEM_ReadIntArray(v1,  1))), sqrf (MEM_ReadIntArray(v1,  2))));
};

//normalize vector
//v - output pointer
//v1 - pointer to vector 1
func void normalizeVector (var int v1)
{
	var int m; m = magVector (v1);
	if (!m) { return; };
	divVector (v1, m);
};

/***/

func int getVectorDistX (var int v1, var int v2) {
	return subf (MEM_ReadIntArray(v1,  0), MEM_ReadIntArray(v2,  0));
};

func int getVectorDistY (var int v1, var int v2) {
	return subf (MEM_ReadIntArray(v1,  1), MEM_ReadIntArray(v2,  1));
};

func int getVectorDistZ (var int v1, var int v2) {
	return subf (MEM_ReadIntArray(v1,  2), MEM_ReadIntArray(v2,  2));
};

//--- From Lehonas Trafo functions

func int getVectorDistXY (var int v1, var int v2) {
	var int a; var int b; var int c;
	a = subf(MEM_ReadIntArray(v1,  0), MEM_ReadIntArray(v2,  0));
	b = subf(MEM_ReadIntArray(v1,  1), MEM_ReadIntArray(v2,  1));
	c = addf(mulf(a,a), mulf(b,b));
	return sqrtf(c);
};

func int getVectorDist (var int v1, var int v2) {
	var int c; var int d; var int e;
	c = getVectorDistXY(v1, v2);
	d = subf(MEM_ReadIntArray(v1,  2), MEM_ReadIntArray(v2,  2));
	e = addf(mulf(c,c), mulf(d,d));
	return sqrtf(e);
};

//--- Derived from Mud-freaks InsertAnything package

func int getVectorDistXZ (var int v1, var int v2) {
	var int a; var int b; var int c;
	a = subf(MEM_ReadIntArray(v1,  0), MEM_ReadIntArray(v2,  0));
	b = subf(MEM_ReadIntArray(v1,  2), MEM_ReadIntArray(v2,  2));
	c = addf(mulf(a,a), mulf(b,b));
	return sqrtf(c);
};

func void vectorDirToTrf (var int v1, var int trafoPtr)
{
        MEM_WriteIntArray(trafoPtr, 2, MEM_ReadIntArray(v1, 0));
        MEM_WriteIntArray(trafoPtr, 6, MEM_ReadIntArray(v1, 1));
        MEM_WriteIntArray(trafoPtr, 10, MEM_ReadIntArray(v1, 2));
};

func void vectorPosToTrf (var int v1, var int trafoPtr)
{
        MEM_WriteIntArray(trafoPtr, 3, MEM_ReadIntArray(v1, 0));
        MEM_WriteIntArray(trafoPtr, 7, MEM_ReadIntArray(v1, 1));
        MEM_WriteIntArray(trafoPtr, 11, MEM_ReadIntArray(v1, 2));
};

func void trfDirToVector (var int trafoPtr, var int v1)
{
        MEM_WriteIntArray(v1, 0, MEM_ReadIntArray(trafoPtr, 2));
        MEM_WriteIntArray(v1, 1, MEM_ReadIntArray(trafoPtr, 6));
        MEM_WriteIntArray(v1, 2, MEM_ReadIntArray(trafoPtr, 10));
};

func void trfPosToVector (var int trafoPtr, var int v1)
{
        MEM_WriteIntArray(v1, 0, MEM_ReadIntArray(trafoPtr, 3));
        MEM_WriteIntArray(v1, 1, MEM_ReadIntArray(trafoPtr, 7));
        MEM_WriteIntArray(v1, 2, MEM_ReadIntArray(trafoPtr, 11));
};
