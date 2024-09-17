/*
 *	zCListSort functions (I don't like LeGo ListS functions ... I mean why would you not start properly from index 0? :))
 */

/*
 *	zCListSort_GetNode
 */
func int zCListSort_GetNode(var int list, var int nr) {
	if (!list) { return 0; };
	if (nr < 0) { return 0; };

	var int i; i = 0;
	var int ptr; ptr = list;

	while (ptr);
		ptr = MEM_ReadInt(ptr + 8);

		if (i == nr) {
			return ptr;
		};

		i += 1;
	end;

	return 0;
};

/*
 *	zCListSort_GetData
 */
func int zCListSort_GetData(var int list, var int nr) {
	if (!list) { return 0; };

	var int nodePtr; nodePtr = zCListSort_GetNode(list, nr);
	if (!nodePtr) { return 0; };

	nodePtr = MEM_ReadInt(nodePtr + 4);
	return + nodePtr;
};

/*
 *	zCListSort_GetLength
 */
func int zCListSort_GetLength(var int list) {
	if (!list) { return 0; };

	var int nr; nr = 0;
	var int ptr; ptr = list;

	while(ptr);
		ptr = MEM_ReadInt(ptr + 8);
		nr += 1;
	end;

	return nr;
};
