import utility, strutils, seqUtils, sugar

const 
    day = "4"
    arr_len = 100
type
    Board = array[5, seq[string]]


proc printBoard(board: Board) =
    echo '-'.repeat(24)
    for each in board:
        var output = ""
        for num in each:
            output = output & num.alignLeft(3) & ", "
        echo '|' & output[0..^3] & '|'
        echo '-'.repeat(24)
    echo ""

proc getBoard(): array[arr_len, Board] =
    discard getInput(day)
    let
        input = readFile("input4.txt").split("\n\n")
    for index, board in input[1..^1]:
        var bd: Board
        for i, row in board.split('\n')[0..4]:
            bd[i] = row.split(' ').filter(x => x != "")
        result[index] =  bd

proc parseInstructions(): seq[string] =
    let
        input = getInput(day)
    return input[0].split(',')

proc drawNumber(input: var array[arr_len, Board], no: string) =
    echo "removing ", no
    for b_index, board in input:
        for r_index, row in board:
            for e_index, each in row:
                if each == no:
                    input[b_index][r_index][e_index] = ""

proc checkWin(input: var array[arr_len, Board]): tuple[isWin: bool, index: int] =
    var ans = (false, 0)
    for ii, each_board in input:
        for x in 0..4:
            if each_board[x] == @["", "", "", "", ""]:
                each_board.printBoard
                ans = (true, ii)
                return ans
            var count = 0
            for y in 0..4:
                if each_board[y][x] == "":
                    count += 1
            if count == 5:
                each_board.printBoard
                ans = (true, ii)
                return ans
    return ans
 
proc altCheckWin(input: var array[arr_len, Board]): seq[tuple[isWin: bool, index: int]] =
    var
        ans: seq[tuple[isWin: bool, index: int]]
        w: seq[int]
        count = 0

    for ii, each_board in input:
        for x, each_row in each_board:
            if each_row == @["", "", "", "", ""]:
                each_board.printBoard
                if w.contains(ii):
                    discard
                else:
                    w.add(ii)
                    ans.add((true, ii))

            for y in 0..4:
                if each_board[y][x] == "":
                    count += 1
            if count == 5:
                if w.contains(ii):
                    discard
                else:
                    each_board.printBoard
                    w.add(ii)
                    ans.add((true, ii))
    return ans

proc getSum(input: Board): int =
    for row in input:
        for col in row:
            if col != "":
                result += col.parseInt


proc partOne() =
    const part = "1"
    var
        num_ans: int
        count: int
        sum: int
        input = getBoard()
        instr = parseInstructions()

    for num in instr:
        drawNumber(input, num)
        let (win, board_index) = checkWin(input)
    
        if win:
            num_ans = num.parseInt
            sum = getSum(input[board_index])
            break
    count = num_ans * sum

    echo "number: " & $num_ans
    echo "sum: ", sum
    echo "Answer: ", count
    submitAnswer(day, part, $count)

proc partTwo() =
    const
        part = "2"
    var
        num_ans: int
        count: int
        sum: int
        board_index: int
        input = getBoard()
        instr = parseInstructions()
        won: seq[int]

    for num in instr:
        drawNumber(input, num)
        let altcheck = altCheckWin(input)
    
        for each in altcheck:
            if each.index notin won:
                won.add(each.index)
                board_index = each.index
                num_ans = num.parseInt
        if won.len >= arr_len:
            break
    echo won
    sum = getSum(input[board_index])
    count = num_ans * sum

    echo "number: " & $num_ans
    echo "sum: ", sum
    echo "Answer: ", count
    submitAnswer(day, part, $count)



when isMainModule:
    partOne()
    partTwo()
