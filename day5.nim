import utility, strutils, tables

const 
    day = "5"
type
    Position = tuple
        x: int
        y: int
    

iterator iterate(no1: int, no2: int): int =
    if no1 < no2:
        for no in no1..no2:
            yield no
    elif no1 > no2:
        for no in no2..no1:
            yield no
    else:
        yield no1

proc parseLine(str: string): array[2, Position] =
    let
        both = str.split(" -> ")
        x1   = both[0].split(',')[0].parseInt
        y1   = both[0].split(',')[1].parseInt
        x2   = both[1].split(',')[0].parseInt
        y2   = both[1].split(',')[1].parseInt
    return [(x1, y1), (x2, y2)]

proc drawLine(input: array[2, Position], fullTable: var Table[Position, int], diag: bool) =
    let
        (x1, y1) = input[0]
        (x2, y2) = input[1]

    if x1 == x2:
        for y in iterate(y1, y2):
            if fullTable.hasKey((x1, y)):
                fullTable[(x1, y)] += 1
            else:
                fullTable[(x1, y)] = 1
    elif y1 == y2:
        for x in iterate(x1, x2):
            if fullTable.hasKey((x, y1)):
                fullTable[(x, y1)] += 1
            else:
                fullTable[(x, y1)] = 1

    elif diag:
        let
            yDel = y2 - y1
            xDel = x2 - x1
            s_x = (if xDel > 0: 1 else: -1)
            s_y = (if yDel > 0: 1 else: -1)
            slope = yDel / xDel
        
        if slope.abs == 1.0:
            var 
                y = y1
                x = x1
            
            # echo slope
            # echo s_x, s_y
            # echo input
            while true: 
                # echo (x, y)
                if fullTable.hasKey((x, y)):
                    fullTable[(x, y)] += 1
                else:
                    fullTable[(x, y)] = 1
                if y == y2 and x == x2:
                    break
                x += s_x
                y += s_y
        # echo "diag"

proc getCount(input: Table[Position, int]): int =
    for each in input.values:
        if each >= 2:
            result += 1
    
proc main(diag=false): Table[Position, int]=
    var
        fullTabl = initTable[Position, int]()

    for index, each in getInput(day):
        let parsed =  each.parseLine
        parsed.drawLine(fullTabl, diag)
    
    return fullTabl

proc partTwo() =
    const 
        part = "2"
    let
        fullTable = main(diag=true)
        count = fullTable.getCount
    echo "Answer: " & $count
    submitAnswer(day, part, $count)

proc partOne() =
    const
        part = "1"
    let
        fullTable = main()
        count = fullTable.getCount
    echo "Answer: " & $count
    submitAnswer(day, part, $count)



when isMainModule:
    partOne()
    partTwo()