import utility, strutils, seqUtils, tables

const 
    day = "6"

proc initDayTable(input: seq[int]): Table[int, int] =
    ## Turns a sequence into a table containing each unique number as a key
    ## and the number of occurences for each number as its value
    ## 
    ## Makes it fast, and takes less memory performing operations instead of 
    ## using raw sequences
    for each in input:
        if result.hasKey(each):
            result[each] += 1
        else:
            result[each] = 1

proc increaseOccurence(tabl: var Table[int, int], k: int, v: int) =
    ## Increase the number of occurences of `k` in `tabl` by `v`
    if v == 0:
        discard
    elif tabl.hasKey(k):
        tabl[k] += v
    else:
        tabl[k] = v

proc shiftDayTable(count_table: var Table[int, int]) =
    ## Subtracts 1 from each key in `count_table`
    ## Also handles for overflows when a key is 0,
    var
        new_t: Table[int, int]
        overflows: int
    for each, val in count_table.pairs:
        if each == 0:
            overflows += val
        else:
            new_t[each-1] = val
    
    if overflows > 0:
        new_t.increaseOccurence(6, overflows)
        new_t.increaseOccurence(8, overflows)
    count_table = new_t

proc getLen(c_table: Table[int, int]): int =
    for each in c_table.values:
        result += each

proc main(num_day: int): int =
    var
        mainInput = getInput(day)[0].split(',').map(parseInt)
        count_table  = mainInput.initDayTable

    for _ in countup(1, num_day):
        count_table.shiftDayTable
    
    echo count_table
    return count_table.getLen

proc partOne() =
    const part = "1"
    var
        count = 0
        # num_days = 18
        num_days = 80

    count = main(num_days)
    echo "Answer: " & $count
    submitAnswer(day, part, $count)

proc partTwo() =
    const
        part = "2"
        num_days = 256
    var
        count = 0

    count = main(num_days)
    echo "Answer: " & $count
    submitAnswer(day, part, $count)


when isMainModule:
    partOne()
    partTwo()