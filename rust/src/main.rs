fn main() {
    let file = std::fs::read_to_string("../data/day01").expect("Could not read file");

    let sum: u64 = file
        .lines()
        .map(|line| {
            line.chars().filter_map(|c| match c {
                c if c.is_ascii_digit() => Some((c as u64) - ('0' as u64)),
                _ => None,
            })
        })
        .filter_map(first_and_last)
        .map(|(first, last)| 10 * first + last)
        .sum();
    println!("part 1: {}", sum);

    let sum: u64 = file
        .lines()
        .map(|line| {
            line.char_indices().filter_map(|(i, c)| match (i, c) {
                (_, c) if c.is_ascii_digit() => Some((c as u64) - ('0' as u64)),
                (i, _) if line[i..].starts_with("one") => Some(1),
                (i, _) if line[i..].starts_with("two") => Some(2),
                (i, _) if line[i..].starts_with("three") => Some(3),
                (i, _) if line[i..].starts_with("four") => Some(4),
                (i, _) if line[i..].starts_with("five") => Some(5),
                (i, _) if line[i..].starts_with("six") => Some(6),
                (i, _) if line[i..].starts_with("seven") => Some(7),
                (i, _) if line[i..].starts_with("eight") => Some(8),
                (i, _) if line[i..].starts_with("nine") => Some(9),
                _ => None,
            })
        })
        .filter_map(first_and_last)
        .map(|(first, last)| 10 * first + last)
        .sum();
    println!("part 2: {}", sum);
}

fn first_and_last<T: Copy>(it: impl Iterator<Item = T>) -> Option<(T, T)> {
    it.fold(None::<(T, T)>, |state, t| {
        state.map_or(Some((t,t)), |(f, _)| Some((f, t)))
    })
}
