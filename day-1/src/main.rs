use std::fs::read_to_string;

fn main() {
    let aoc = AOC::new(read_to_string("./day-1/input.txt").unwrap());
    aoc.part_one();
    aoc.part_two();
}

struct AOC {
    input: String,
}

trait Solution {
    fn new(file: String) -> Self;
    fn part_one(&self);
    fn part_two(&self);
}

impl Solution for AOC {
    fn new(file: String) -> Self {
        Self { input: file }
    }

    fn part_one(&self) {
        let result = self
            .input
            .split("\n\n")
            .map(|elf_load| {
                elf_load
                    .lines()
                    .map(|item| item.parse::<u32>().unwrap())
                    .sum::<u32>()
            })
            .max()
            .unwrap();
        println!("Part 1: {}", result);
    }

    fn part_two(&self) {
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
        println!("Part 2: {}", sum);
    }
}
