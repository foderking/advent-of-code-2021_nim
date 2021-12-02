import utility, strutils, seqUtils, sugar

const 
    day = "1"

proc partOne() =
    const part = "1"
    var
        last = ""
        count = 0
    for index, each in getInput(day).pairs:
        if last == "":
            discard
        elif last.parseInt < each.parseInt:
            count += 1
        last = each

    echo "Answer: " & $count
    submitAnswer(day, part, $count)

proc partTwo() =
    const
        part = "2"
    let
        allInput = getInput(day)
    var
        count = 0
        last  = 0

    for index, each in allInput:
        if index < 2 :
            continue
        let
            windowOne = allInput[index-2..index]
            sumOne = windowOne.map(x => x.parseInt).foldl(a + b)
        
        if last != 0 and sumOne > last:
            echo sumOne, " ", last
            count.inc

        last = sumOne

    echo "Answer: " & $count
    submitAnswer(day, part, $count)


when isMainModule:
    partOne()
    partTwo()