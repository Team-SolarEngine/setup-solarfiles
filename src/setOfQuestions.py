import src.createEverything as ce
import src.utils.question as q
import time
import sys

def getBoolean(boolean):
    if boolean == "y" or boolean == "Y":
        return "yes"
    else:
        return "no"

def doesItExist(aString):
    if aString:
        return aString
    else:
        return "None inputted."

def main():
    pathToLogo = q.getInput("Path to mod/script logo [FULL PATH]", True)
    pathToBanner = q.getInput("Path to mod/script banner [FULL PATH]", True)
    isOpenSource = q.getBoolean("Is it open source?")
    canMessWithComputer = q.getBoolean("Can it mess with your computer?")
    title = q.getInput("Input the title of your mod/script", True)
    description = q.getInput("Input a short description of your mod/script", True)
    madeBy = q.getInput("Input the person/team who made it", True)
    downloadURL = q.getInput("Input the Download URL", True)
    externalURL = q.getInput("Input the External URL")
    githubURL = q.getInput("Input the Github URL")
    madeByURL = q.getInput("Input the person/team who made the script/mod URL")

    print(f"""/=/= Final results =\\=\\
-> Logo Path: {pathToLogo}
-> Banner Path: {pathToBanner}
-> Readme: Create this yourself later in a text editor!
-> Config:
    -> Open Source: {getBoolean(isOpenSource)}
    -> Messes with computer: {getBoolean(canMessWithComputer)}
    -> Title: {title}
    -> Short Description: {description}
    -> Made By: {madeBy}
    -> Download URL: {downloadURL}
    -> External URL: {doesItExist(externalURL)}
    -> Github URL: {doesItExist(githubURL)}
    -> Made By URL: {doesItExist(madeByURL)}""")

    pathToExport = q.getInput("Where should we export it?", True)
    continueQuestion = q.getBoolean("Do you wish to continue?")

    if continueQuestion:
        try:
            ce.main(
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
            )
            print(f"`.solar-engine` has done creating. Check {pathToExport}.")
        except Exception as e:
            print(f"An error has accoured: {e}")
    else:
        print("Exiting...")
        time.sleep(2)
        sys.exit(1)