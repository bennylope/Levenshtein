package levenshtein

import "testing"

func TestSimpleDistance(t *testing.T) {
  var d int

  d = Distance("kitten", "kitten")
	if d != 0 {
		t.Error("Expected distance of 0, got ", d)
	}

	d = Distance("k", "sitting")
	if d != 7 {
		t.Error("Expected distance of 7, got ", d)
	}

	d = Distance("", "sitting")
	if d != 7 {
		t.Error("Expected distance of 7, got ", d)
	}

	d = Distance("kitten", "")
	if d != 6 {
		t.Error("Expected distance of 6, got ", d)
	}

	d = Distance("kitten", "sitting")
	if d != 3 {
		t.Error("Expected distance of 3, got ", d)
	}
}
