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

func string addString (var string s, var string s1, var string separator) {
	if (STR_Len (s) > 0) {
		s = ConcatStrings (s, separator);
	};

	s = ConcatStrings (s, s1);

	return s;
};