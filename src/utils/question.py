import sys
import time

def input(text, isRequired=False):
    if isRequired:
        returnedPrint = input(f"{text}*\n-->")
        if returnedPrint:
            return returnedPrint
        else:
            "This input is required. Please try again."
            time.sleep(2)
            sys.exit(1)
    else:
        return input(f"{text}\n-->")

def boolean(text):
    returnedPrint = input(f"{text} - [y/n]\n-->")

    if returnedPrint == "y" or returnedPrint == "Y":
        return returnedPrint
    elif returnedPrint == "n" or returnedPrint == "N":
        return returnedPrint
    else:
        "That value does not exist."
        time.sleep(2)
        sys.exit(1)