import utility, strutils, seqUtils, sugar, strformat

const 
    day = "9"

type
    CharArray = seq[seq[char]]

proc parseInput(): CharArray =
    for each in getInput(day):
        result.add( each.toSeq )
    
# proc addBasin(elem: char, basins: var seq[char]): bool =
#     for each in

proc getLowest(input: CharArray): seq[char] =
    let
        len_arr = input.len
    for r, row in input:
        let
            r_len = row.len
        for e, elem in row:
            let
                up   = (if r > 0: input[r-1][e]  else: 'A')
                down = (if r < (len_arr-1): input[r+1][e]  else: 'A')
                left   = (if e > 0: input[r][e-1]  else: 'A')
                right = (if e < (r_len-1): input[r][e+1]  else: 'A')
            if elem < up and elem < down and elem < left and elem < right:
                result.add(elem)

proc getBasins(input: CharArray): seq[seq[char]] =
    let
        len_arr = input.len
    var
        basins: seq[tuple[x: int, y: int]]
        resul : seq[seq[tuple[x: int, y: int]]]
    for r, row in input:
        let
            r_len = row.len
        for e, elem in row:
            let
                up   = (if r > 0: input[r-1][e]  else: '\n')
                down = (if r < (len_arr-1): input[r+1][e]  else: '\n')
                left   = (if e > 0: input[r][e-1]  else: '\n')
                right = (if e < (r_len-1): input[r][e+1]  else: '\n')
            if elem < up or elem < down or elem < left or elem < right:
                for b, basin in resul:
                    let
                        up_basin = (x: r-1, y: e)
                        down_basin = (x: r+1, y: e)
                        left_basin = (x: r, y: e-1)
                        right_basin = (x: r, y: e+1)
                    if up_basin in basin or down_basin in basin or left_basin in basin or right_basin in basin:
                            resul[b].add( (x: r, y: e) )
                            echo basin
                    else:
                        # let
                            # new_basins = basin.map(each => input[each.x][each.y])
                            # echo new
                        # if basin.len > 0:
                        #     resul.add(basin)
                        #     resul[b] = @[]
                        basins.add( (r, e) )
                # if not addBasin(elem, basins):


proc toNum(charac: char): int =
    return charac.ord - 48

proc partOne() =
    const part = "1"
    var
        count = 0
    let
        input =  parseInput()
        lows = getLowest(input).map(each => each.toNum + 1)

    echo lows
    count = lows.foldl(a + b)
    echo "Answer: " & $count
    submitAnswer(day, part, $count)

proc partTwo() =
    const
        part = "2"
    var
        count = 0
    let
        input =  parseInput()
        basins = getBasins(input)

    echo basins

    echo "Answer: " & $count
    # submitAnswer(day, part, $count)


when isMainModule:
    # partOne()
    partTwo()