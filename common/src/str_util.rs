use rand::{Rng, thread_rng};

pub fn generate_random_ascii_string(length: usize) -> String {
    let rng = &mut thread_rng();
    let result = (0..length)
        .map(|_| {
            // 直接将 u8 值转换为 char，因为我们知道它在 ASCII 范围内
            (rng.gen_range(33..=126)).to_string()
        })
        .collect::<String>();
    result
}

#[cfg(test)]
mod tests {
    use crate::str_util::generate_random_ascii_string;

    #[test]
    fn it_works() {
        let res = generate_random_ascii_string(2);
        println!("Test: {}",res)
    }
}

