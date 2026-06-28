use super::question_prompt;
use std::fs;
use std::path::Path;
use colored::Colorize;

const CONTENT_README: &str = "# A mod about {title}";
const CONTENT_JSON_CONFIG: &str = r#"{
    "isOpenSource": "{is_open_source}",
    "canMessWithComputer": "{can_mess_with_computer}",
    
    "title": "{title}",
    "description": "{description}",
    "madeBy": "{made_by}",
    
    "downloadURL": "{download_url}",
    "externalURL": "{external_url}",
    "githubURL": "{github_url}",
    "madeByURL": "{made_by_url}",
}
"#;

pub fn init_yes(
    path_to_logo: &str,
    path_to_banner: &str,
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
        let path_exists_prompt = question_prompt::get_boolean(&format!("`{}` {}", path_to_export.bright_black(), "path exists. Do you wish to delete it?".yellow()));

        if path_exists_prompt == "yes" {
            fs::remove_dir_all(extended_path).unwrap();
        } else {
            print!("{}", "Exiting...".yellow());
            std::process::exit(0);
        }
    } else {
        fs::create_dir(extended_path).unwrap();
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
        .replace("{made_by_url}", made_by_url);
    
    create_file(&format!("{}/readme.md", formatted_string), CONTENT_README);
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