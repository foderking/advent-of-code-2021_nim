import utility, strutils, seqUtils, sugar, strscans

const 
    day = "<day>"

proc altGetInput(): seq[string] =
    discard getInput(day)

    return readFile("input6.txt").split('\n')


proc partOne() =
    const part = "1"
    var
        count = 0

    for index, each in getInput(day):
        discard

    echo "Answer: " & $count
    submitAnswer(day, part, $count)

proc partTwo() =
    const
        part = "2"
    var
        count = 0

    for index, each in getInput(day):
        discard

    echo "Answer: " & $count
    submitAnswer(day, part, $count)


when isMainModule:
    partOne()
    partTwo()