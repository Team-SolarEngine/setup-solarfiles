use dvs_interactive_cli_rs::boolean;
use std::fs;
use std::path::Path;
use colored::Colorize;

const CONTENT_README: &str = "# A mod about {title}";
const CONTENT_JSON_CONFIG: &str = r#"{
    "isOpenSource": "{is_open_source}",
    "canMessWithComputer": "{can_mess_with_computer}",
    "type": "{type}",

    "title": "{title}",
    "description": "{description}",
    "madeBy": "{made_by}",

    "downloadURL": "{download_url}",
    "externalURL": "{external_url}",
    "githubURL": "{github_url}",
    "madeByURL": "{made_by_url}",
}"#;

pub fn init_yes(
    path_to_logo: &str,
    path_to_banner: &str,
    what_type: Vec<i32>,
    is_open_source: &str,
    can_mess_with_computer: &str,
    title: &str,
    description: &str,
    made_by: &str,
    download_url: &str,
    external_url: &str,
    github_url: &str,
    made_by_url: &str,
    path_to_export: &str,
) {
    // === === === config.json // readme.md === === ===
    let formatted_string = format!("{}{}", path_to_export, ".solar-engine");
    let extended_path = Path::new(&formatted_string);

    if extended_path.exists() {
        let path_exists_prompt = boolean(&format!("`{}` {}", path_to_export.bright_black(), "path exists. Do you wish to delete it?".yellow()));

        if path_exists_prompt == "yes" {
            if let Err(e) = fs::remove_dir_all(extended_path) {
                eprintln!("Failed to remove directory: {}", e);
            }
        } else {
            print!("{}", "Exiting...".yellow());
            std::process::exit(0);
        }
    } else {
        fs::create_dir(extended_path).unwrap();
    }

    let mut returned_type_shi: &str = "Other";
    for num in what_type {
        if num == 1 {
            returned_type_shi = "Scripts";
        } else if num == 2 {
            returned_type_shi = "Mods";
        }
    }

    let populated_json = CONTENT_JSON_CONFIG
        .replace("{is_open_source}", is_open_source)
        .replace("{can_mess_with_computer}", can_mess_with_computer)
        .replace("{title}", title)
        .replace("{description}", description)
        .replace("{made_by}", made_by)
        .replace("{download_url}", download_url)
        .replace("{external_url}", external_url)
        .replace("{github_url}", github_url)
        .replace("{made_by_url}", made_by_url)
        .replace("{type}", returned_type_shi);

    let formatted_readme = CONTENT_README
        .replace("{title}",  title);

    create_file(&format!("{}/readme.md", formatted_string), &formatted_readme);
    create_file(&format!("{}/config.json", formatted_string), &populated_json);

    // === === === logo.png // banner.png === === ===
    let logo_formatted_path = &format!("{}/logo.png", formatted_string);
    fs::copy(path_to_logo, logo_formatted_path).unwrap();
    println!("{} {}", "Created".green(), logo_formatted_path.to_string().white());

    let banner_formatted_path = &format!("{}/banner.png", formatted_string);
    fs::copy(path_to_banner, banner_formatted_path).unwrap();
    println!("{} {}", "Created".green(), banner_formatted_path.to_string().white());
}

fn create_file(path_to: &str, content: &str) {
    fs::write(path_to, content).unwrap();
    println!("{} {}", "Created".green(), path_to.to_string().white());
}
