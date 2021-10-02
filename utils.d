func int max (var int int1, var int int2) {
	if (int1 > int2) { return int1; };
	return int2;
};

func int min (var int int1, var int int2) {
	if (int1 > int2) { return int2; };
	return int1;
};

func int abs (var int i) {
	if (i < 0) { i = 0 - i; };
	return i;
};
