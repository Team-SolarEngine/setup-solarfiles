mod question_prompt;
mod initialize_everything;

fn main() {
    let path_to_logo = question_prompt::get_input("Path to mod/script logo [FULL PATH. ADD / AT THE END]", &true);
    let path_to_banner = question_prompt::get_input("Path to mod/script banner [FULL PATH. ADD / AT THE END]", &true);
    let is_open_source = question_prompt::get_boolean("Is it open source?");
    let can_mess_with_computer = question_prompt::get_boolean("Can it mess with your computer?");
    let title = question_prompt::get_input("Input the title of your mod/script", &true);
    let description = question_prompt::get_input("Input a short description of your mod/script", &true);
    let made_by = question_prompt::get_input("Input the person/team who made it", &true);
    let download_url = question_prompt::get_input("Input the Download URL", &true);
    let external_url = question_prompt::get_input("Input the External URL", &false);
    let github_url = question_prompt::get_input("Input the Github URL", &false);
    let made_by_url = question_prompt::get_input("Input the person/team who made the script/mod URL", &false);

    print!("/=/= Final results =\\=\\
-> Logo Path: {}
-> Banner Path: {}
-> Readme: Create this yourself later in a text editor!
-> Config:
    -> Open Source: {}
    -> Messes with computer: {}
    -> Title: {}
    -> Short Description: {}
    -> Made By: {}
    -> Download URL: {}
    -> External URL: {}
    -> Github URL: {}
    -> Made By URL: {}",
        path_to_logo,
        path_to_banner,
        is_open_source,
        can_mess_with_computer,
        title,
        description,
        made_by,
        download_url,
        external_url,
        github_url,
        made_by_url,
    );

    let path_to_export = question_prompt::get_input("Where should we export it?", &true);
    let continue_question = question_prompt::get_boolean("Do you wish to continue?");

    if continue_question == "yes" {
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
        print!("Exiting...");
        std::process::exit(0);
    }
}
