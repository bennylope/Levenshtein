package levenshtein

// Finds the Levenshtein distance between two strings, a & b.
// TODO switch to interfaces from strings?
func Distance(a string, b string) int {
	if a == b {
		return 0
	}

	if len(a) == 0 {
		return len(b)
	}
	if len(b) == 0 {
		return len(a)
	}

	var longer *string
	var shorter *string

	// Ampersands resolve memory addresses, not the values
	if len(a) > len(b) {
		longer, shorter = &a, &b
	} else {
		longer, shorter = &b, &a
	}

	var d int = 0
	// Dereference the variable 'shorter': & gets address, * gets value
	//for i, str := range *shorter {
	for i := 0; i < len(*shorter); i++ {
		// *shorter[i] means the compiler will try to get the ith index of
		// a string pointer type, so it has to be dereferenced first, then
		// the index can be taken
		if (*shorter)[i] != (*longer)[i] {
			d += 1
		}
	}

	return d + (len(*longer) - len(*shorter))
}
