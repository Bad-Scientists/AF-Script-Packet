/*
 *	zCListSort functions (I don't like LeGo ListS functions ... I mean why would you not start properly from index 0? :))
 */
func int zCListSort_GetNode (var int list, var int nr) {
	if (!list) { return 0; };

	if (nr < 0) { return 0; };

	var int i; i = 0;
	var int nodePtr; nodePtr = 0;

	var zCListSort l; l = _^ (list);

	while (l.next);
		if (i == nr) {
			nodePtr = l.next;
			break;
		};

		l = _^ (l.next);
		i += 1;
	end;

	return nodePtr;
};

func int zCListSort_GetData (var int list, var int nr) {
	if (!list) { return 0; };

	var int nodePtr; nodePtr = zCListSort_GetNode (list, nr);
	if (!nodePtr) { return 0; };

	var zCListSort l; l = _^ (nodePtr);
	return l.data;
};
