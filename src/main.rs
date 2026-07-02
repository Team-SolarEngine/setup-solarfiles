mod initialize_everything;
use dvs_interactive_cli_rs::boolean;
use dvs_interactive_cli_rs::input;

fn main() {
    let path_to_logo = input("Path to mod/script logo", &true, "FULL PATH.");
    let path_to_banner = input("Path to mod/script banner", &true, "FULL PATH.");
    let is_open_source = boolean("Is it open source?");
    let can_mess_with_computer = boolean("Can it mess with your computer?");
    let title = input("Input the title of your mod/script", &true, "Your epic cool mod");
    let description = input("Input a short description of your mod/script", &true, "A mod about yourself");
    let made_by = input("Input the person/team who made it", &true, "Myself");
    let download_url = input("Input the Download URL", &true, "https://...");
    let external_url = input("Input the External URL", &false, "https://...");
    let github_url = input("Input the Github URL", &false, "https://github.com/...");
    let made_by_url = input("Input the person/team who made the script/mod URL", &false, "https://...");

    let path_to_export = input("Where should we export it?", &true, "FULL PATH. ADD / AT THE END");
    let continue_question = boolean("Do you wish to continue?");

    if continue_question == "y" || continue_question == "Y" {
        initialize_everything::init_yes(
            &path_to_logo,
            &path_to_banner,
            &is_open_source,
            &can_mess_with_computer,
            &title,
            &description,
            &made_by,
            &download_url,
            &external_url,
            &github_url,
            &made_by_url,
            &path_to_export,
        );
    } else {
        println!("Exiting...");
        std::process::exit(0);
    }
}
