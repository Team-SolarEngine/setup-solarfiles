import shutil
import os
import sys
import src.setOfQuestions as soq
import src.utils.question as q

def main(
    pathToExport,
    isOpenSource,
    canMessWithComputer,
    title,
    description,
    madeBy,
    externalURL,
    githubURL,
    madeByURL,
    downloadURL,
    pathToLogo,
    pathToBanner
):
    if os.path.exists(f"{pathToExport}/.solar-engine"):
        pathExists = q.getBoolean("`.solar-engine` exists in this path. Do you wish to delete it?")
        if pathExists == "y" or pathExists == "Y":
            shutil.rmtree(f"{pathToExport}/.solar-engine")
            pass
        else:
            print("Exiting...")
            sys.exit(1)
    else:
        os.mkdir(f"{pathToExport}/.solar-engine")

        # config.json // readme.md
        # this is writing
        with open(f"{pathToExport}/.solar-engine/config.json", "w") as f:
            f.write(f"""{{
"isOpenSource": "{soq.getBoolean(isOpenSource)}",
"canMessWithComputer": "{soq.getBoolean(canMessWithComputer)}",

"title": "{title}",
"description": "{description}",
"madeBy": "{madeBy}",

"externalURL": "{externalURL}",
"githubURL": "{githubURL}",
"madeByURL": "{madeByURL}",
"downloadURL": "{downloadURL}"
}}""")
        with open(f"{pathToExport}/.solar-engine/readme.md", "w") as f:
            f.write(f"A mod about {title}")

        # logo.png // banner.png
        # this is copying
        shutil.copyfile(pathToLogo, f"{pathToExport}/.solar-engine/logo.png")
        shutil.copyfile(pathToBanner, f"{pathToExport}/.solar-engine/banner.png")