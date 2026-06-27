import src.setOfQuestions as soq
import time

try:
    soq.main()
except KeyboardInterrupt:
    print("Quitting... Program was interrupted by user...")
    time.sleep(2)