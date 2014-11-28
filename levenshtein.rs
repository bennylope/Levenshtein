// This is just a brief exploration of the syntax of Rust. Not
// making an attempt to learn the language in any useful way for the time
// being.

use std::str;

// Initially thought to use String types but Rust complained that the code
// needed to use clone(). We don't need to operate on the strings, just
// references to them, so using slices - `&str` - works much better.
fn string_distance(source: &str, target: &str) -> int {
    if source == target {
        return 0;  // early return requires a semi-colon
    }
    if source.len() == 0 {
        return target.len() as int;  // len returns a uint value, must be cast
    }
    if target.len() == 0 {
        return source.len() as int;
    }

    // Named variables will be immutable by default - specify that this one is mutable so we can increment later.
    let mut distance: int = 0;

    let longer: &[u8];
    let shorter: &[u8];

    if source.len() > target.len() {
        longer = source.as_bytes();
        shorter = target.as_bytes();
    } else {
        longer = target.as_bytes();
        shorter = source.as_bytes();
    }

    for x in range(0, shorter.len()) {
        if shorter[x] != longer[x] {
            distance = distance + 1;
        }
    }

    // Still need to account for the newline characters apparently
    distance + longer.len() as int - shorter.len() as int - 1 // function return, no semi-colon
}

fn main() {
    // println is not a function, it's a macro, hence called with exclamation point
    println!("First string?");
    let source = std::io::stdin().read_line().ok().expect("Failed to read line");
    println!("Second string?");
    let target = std::io::stdin().read_line()
                                .ok()
                                .expect("Failed to read line");

    let distance: int = string_distance(source.as_slice(), target.as_slice());
    println!("{:s} has a distance of {} from {:s}",
            // str::replace returns a String from 3 &str parameters
            str::replace(target.as_slice(), "\n", ""),
            distance.to_string(),
            str::replace(source.as_slice(), "\n", ""));
}
