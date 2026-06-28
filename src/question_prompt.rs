use colored::Colorize;
use std::io::{self, Write};
use std::time::Duration;
use std::thread;

pub fn get_input(text: &str, is_required: &bool) -> String {
    if *is_required { print!("{} {}{}\n{} ", "╭─".black(), text.bright_white(), "*".red(), "╰─".black()); } else { print!("{} {}\n{} ", "╭─".black(), text.bright_white(), "╰─".black()); }
    io::stdout().flush().unwrap();

    let mut input = String::new();
    io::stdin().read_line(&mut input).unwrap();

    if input.trim().is_empty() && *is_required {
        println!("\nNo input was given. Exiting app...");
        thread::sleep(Duration::from_secs(2));
                
        println!("Exiting app.");
        std::process::exit(0);
    }

    input.trim().to_string()
}

pub fn get_boolean(text: &str) -> String {
    print!("{} {} {}\n{} ", "╭─".black(), text.bright_white(), "[y/n]".black(), "╰─".black());
    io::stdout().flush().unwrap();

    let mut input = String::new();
    io::stdin().read_line(&mut input).unwrap();

    if input.trim().is_empty() {
        println!("\nNo input was given. Exiting app...");
        thread::sleep(Duration::from_secs(1));
        std::process::exit(0);
    }

    if input.trim() == "y" || input.trim() == "Y" {
        "yes".to_string()
    } else if input.trim() == "n" || input.trim() == "N" {
        "no".to_string()
    } else {
        println!("\nNot a real option. Exiting app...");
        thread::sleep(Duration::from_secs(1));
        std::process::exit(0);
    }
}