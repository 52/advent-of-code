use std::fs::read_to_string;

fn main() {
    let aoc = AOC::new(read_to_string("./01/input.txt").unwrap());
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

impl Solution for AOC {
    fn new(file: String) -> Self {
        Self { input: file }
    }

    fn part_one(&self) -> u32 {
        self.input
            .split("\n\n")
            .map(|elf_load| {
                elf_load
                    .lines()
                    .map(|item| item.parse::<u32>().unwrap())
                    .sum::<u32>()
            })
            .max()
            .unwrap()
    }

    fn part_two(&self) -> u32 {
        let mut result = self
            .input
            .split("\n\n")
            .map(|group| {
                group
                    .lines()
                    .map(|item| item.parse::<u32>().unwrap())
                    .sum::<u32>()
            })
            .collect::<Vec<u32>>();

        result.sort_by(|a, b| b.cmp(a));
        let sum: u32 = result.iter().take(3).sum();
        sum
    }
}

#[cfg(test)]
mod day_1_tests {
    use super::*;

    #[test]
    fn test_part_one() {
        let aoc = AOC::new(read_to_string("../01/input-test.txt").unwrap());
        assert_eq!(aoc.part_one(), 24000);
    }

    #[test]
    fn test_part_two() {
        let aoc = AOC::new(read_to_string("../01/input-test.txt").unwrap());
        assert_eq!(aoc.part_two(), 45000);
    }
}
