import utility, strutils, seqUtils, sugar, strscans

const 
    day = "10"
    rules = {
        "normal"     : ['(', ')'],
        "square"     : ['[', ']'],
        "curly"      : ['{', '}'],
        "comparison" : ['<', '>']
    }
var
    normal_br: seq[char]
    square_br: seq[char]
    curly_br : seq[char]
    less_than: seq[char]

proc altGetInput(): seq[string] =
    discard getInput(day)

    return readFile("input6.txt").split('\n')

proc addChunk(chunk: char, parent: string): int =

    case parent:

    of "normal":
        if chunk == '(':
            echo "add ", chunk
            normal_br.add(chunk)
        else:
            if normal_br.len == 0:
                echo "ILLEGAL FOUND!!"
                return 3
            else:
                echo "pop ", normal_br.pop
    of "square":
        if chunk == '[':
            echo "add ", chunk
            square_br.add(chunk)
        else:
            if square_br.len == 0:
                echo "ILLEGAL FOUND!!"
                return 57
            else:
                echo "pop ", square_br.pop
    of "curly":
        if chunk == '{':
            echo "add ", chunk
            curly_br.add(chunk)
        else:
            if curly_br.len == 0:
                echo "ILLEGAL FOUND!!"
                return 1197
            else:
                echo "pop ", curly_br.pop
    of "comparison":
        if chunk == '<':
            echo "add ", chunk
            less_than.add(chunk)
        else:
            if less_than.len == 0:
                echo "ILLEGAL FOUND!!"
                return 25137
            else:
                echo "pop ", less_than.pop
    else:
        echo "overflow"

    echo normal_br
    echo square_br
    echo curly_br
    echo less_than

    return 0

proc partOne() =
    const
        part = "1"
    var
        count = 0

    # for each in rules:
        # echo each
    for index, chunks in getInput(day):
        echo chunks
        for each in chunks:
            for rule in rules:
                let
                    (name, arr) =  rule
                if arr.contains(each):
                    let new =  addChunk(each, name)
                    if new > 0:
                        count += new
                        break
        normal_br = @[]
        square_br = @[]
        curly_br = @[]
        less_than = @[]
        echo ""
            # echo "corrupt"
    echo "Answer: " & $count
    # submitAnswer(day, part, $count)

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
    # partTwo()