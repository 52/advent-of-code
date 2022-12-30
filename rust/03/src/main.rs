use std::collections::HashMap;
use std::fs::read_to_string;
use std::ops::Div;

fn main() {
    let aoc = AOC::new(read_to_string("input.txt").unwrap());
    println!("Part 1: {}", aoc.part_one());
    println!("Part 2: {}", aoc.part_two());
}

struct AOC {
    input: String,
}

trait Solution {
    fn new(file: String) -> Self;
    fn part_one(&self) -> u32;
    fn part_two(&self) -> u32;
}

fn priority(c: char) -> u32 {
    match c {
        'a'..='z' => c as u32 - 'a' as u32 + 1,
        'A'..='Z' => c as u32 - 'A' as u32 + 1 + 26,
        _ => 0,
    }
}

fn make_map(chars: std::str::Chars) -> HashMap<char, Option<usize>> {
    let mut map: HashMap<char, Option<usize>> = HashMap::new();
    for c in chars {
        map.insert(c, None);
    }
    return map;
}
impl Solution for AOC {
    fn new(file: String) -> Self {
        Self { input: file }
    }

    fn part_one(&self) -> u32 {
        let mut sum = 0;
        for line in self.input.lines().into_iter() {
            let mid = line.len().div(2);
            let map = make_map(line[mid..line.len()].chars());

            for i in line[..mid].chars() {
                if let Some(_) = map.get(&i) {
                    sum += priority(i);
                    break;
                }
            }
        }
        return sum;
    }

    fn part_two(&self) -> u32 {
        let mut lines = self.input.lines();
        let mut sum = 0;

        while let (Some(_x), Some(_y), Some(_z)) = (lines.next(), lines.next(), lines.next()) {
            let x = make_map(_x.chars());
            let y = make_map(_y.chars());
            let z = make_map(_z.chars());

            for k in x.keys() {
                if y.contains_key(k) && z.contains_key(k) {
                    sum += priority(*k);
                }
            }
        }
        return sum;
    }
}

#[cfg(test)]
mod day_2_tests {
    use super::*;

    #[test]
    fn test_part_one() {
        let aoc = AOC::new(read_to_string("../03/input.txt").unwrap());
        assert_eq!(aoc.part_one(), 7908);
    }

    #[test]
    fn test_part_two() {
        let aoc = AOC::new(read_to_string("../03/input.txt").unwrap());
        assert_eq!(aoc.part_two(), 2838);
    }
}
