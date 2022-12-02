use std::fs::read_to_string;

fn main() {
    let aoc = AOC::new(read_to_string("./day-2/input.txt").unwrap());
}

struct AOC {
    input: String,
}

trait Solution {
    fn new(file: String) -> Self;
}

impl Solution for AOC {
    fn new(file: String) -> Self {
        Self { input: file }
    }
}
