import sys
import time

def getInput(text, isRequired=False):
    if isRequired:
        returnedPrint = input(f"{text}*\n-> ")
        if returnedPrint:
            return returnedPrint
        else:
            print("This input is required. Please try again.")
            time.sleep(2)
            sys.exit(1)
    else:
        return input(f"{text}\n-> ")

def getBoolean(text):
    returnedPrint = input(f"{text} - [y/n]\n-> ")

    if returnedPrint == "y" or returnedPrint == "Y":
        return returnedPrint
    elif returnedPrint == "n" or returnedPrint == "N":
        return returnedPrint
    else:
        print("That value does not exist.")
        time.sleep(2)
        sys.exit(1)