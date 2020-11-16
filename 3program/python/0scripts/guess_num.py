import random


def guessNum(targetNum, maxNum=100):
    inputNum = int(input(f"Please enter a number within 0-{maxNum}: "))

    if inputNum not in range(maxNum + 1):
        guessNum(targetNum, maxNum)
    elif inputNum < targetNum:
        print("Lower!")
        guessNum(targetNum, maxNum)
    elif inputNum > targetNum:
        print("Higher!")
        guessNum(targetNum, maxNum)
    else:
        print("Bingo!")


if __name__ == "__main__":
    maxNum = 10000
    targetNum = random.randint(0, maxNum)
    guessNum(targetNum, maxNum)
