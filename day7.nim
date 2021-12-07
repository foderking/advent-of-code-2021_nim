import utility, strutils, seqUtils, sugar, strscans

const 
    day = "7"

proc parseInput(): seq[int] =
    let
        input =  getInput(day)
    return input[0].split(',').map(parseInt)

proc meanDev(arr: seq[int], no: int): int =
    let
        diff = arr.map(each => abs(each - no))
    return diff.foldl(a + b)

proc altSum(no_range: int, ): int =
    for each in 1..no_range:
        result += each

proc altMeanDev(arr: seq[int], no: int): int =
    let
        diff = arr.map(each => altSum(abs(each - no)))
    return diff.foldl(a + b)

proc partOne() =
    const part = "1"
    let
        input = parseInput()
        allElems = (0..input.max).toSeq
        allDevs = allElems.map(each => meanDev(input, each))
        count = allDevs.min
    echo "Answer: " & $count
    submitAnswer(day, part, $count)

proc partTwo() =
    const
        part = "2"
    let
        input = parseInput()
        allElems = (0..input.max).toSeq
        allDevs = allElems.map(each => altMeanDev(input, each))
        count = allDevs.min
    echo "Answer: " & $count
    submitAnswer(day, part, $count)


when isMainModule:
    partOne()
    partTwo()