use std::fs::read_to_string;
use std::{cmp::Ordering, str::FromStr};

fn main() {
    let aoc = AOC::new(read_to_string("./day-2/input.txt").unwrap());
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

#[derive(PartialEq, Copy, Clone)]
enum Move {
    Rock = 1,
    Paper = 2,
    Scissors = 3,
}

impl PartialOrd for Move {
    fn partial_cmp(&self, other: &Self) -> Option<std::cmp::Ordering> {
        if self == &Move::Scissors && other == &Move::Rock {
            Some(Ordering::Less)
        } else if self == &Move::Rock && other == &Move::Scissors {
            Some(Ordering::Greater)
        } else {
            Some((*self as u8).cmp(&(*other as u8)))
        }
    }
}

impl FromStr for Move {
    type Err = String;

    fn from_str(s: &str) -> Result<Self, Self::Err> {
        match s {
            "A" | "X" => Ok(Move::Rock),
            "B" | "Y" => Ok(Move::Paper),
            "C" | "Z" => Ok(Move::Scissors),
            _ => Err("Not a known move".to_string()),
        }
    }
}

impl Solution for AOC {
    fn new(file: String) -> Self {
        Self { input: file }
    }

    fn part_one(&self) -> u32 {
        self.input
            .lines()
            .map(|line| {
                let moves: Vec<Move> = line
                    .split(" ")
                    .map(|s| s.parse::<Move>().unwrap())
                    .collect();
                match moves[0].partial_cmp(&moves[1]) {
                    Some(Ordering::Equal) => 3 + moves[1] as u32,
                    Some(Ordering::Less) => 6 + moves[1] as u32,
                    Some(Ordering::Greater) => 0 + moves[1] as u32,
                    None => {
                        panic!("moves should be comparable")
                    }
                }
            })
            .sum()
    }

    fn part_two(&self) -> u32 {
        self.input
            .lines()
            .map(|line| {
                let moves: Vec<&str> = line.split(" ").collect();
                let opponent_move = moves[0].parse::<Move>().unwrap();
                match moves[1] {
                    "X" => {
                        let our_move = match opponent_move {
                            Move::Rock => Move::Scissors,
                            Move::Paper => Move::Rock,
                            Move::Scissors => Move::Paper,
                        };
                        0 + our_move as u32
                    }
                    "Y" => 3 + opponent_move as u32,
                    "Z" => {
                        let our_move = match opponent_move {
                            Move::Rock => Move::Paper,
                            Move::Paper => Move::Scissors,
                            Move::Scissors => Move::Rock,
                        };
                        6 + our_move as u32
                    }
                    _ => {
                        panic!("Unexpected response");
                    }
                }
            })
            .sum()
    }
}

#[cfg(test)]
mod day_2_tests {
    use super::*;

    #[test]
    fn test_part_one() {
        let aoc = AOC::new(read_to_string("../day-2/input-test.txt").unwrap());
        assert_eq!(aoc.part_one(), 15);
    }

    #[test]
    fn test_part_two() {
        let aoc = AOC::new(read_to_string("../day-2/input-test.txt").unwrap());
        assert_eq!(aoc.part_two(), 12);
    }
}
