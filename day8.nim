import utility, strutils, seqUtils, sugar, strscans, tables, algorithm, sets

const 
    day = "8"
    nos = [6, 2, 5, 5, 4, 5, 6, 3, 7, 6]

proc altGetInput(): seq[string] =
    discard getInput(day)

    return readFile("input6.txt").split('\n')


proc partOne() =
    const part = "1"
    var
        count = 0
    let
        nos_count =  nos.toCountTable
    echo nos_count

    for index, each in getInput(day):
        let
            output_lens = each.split(" | ")[1].split(' ').map(each => each.len)
        for each in output_lens:
            if nos_count[each] == 1:
                count += 1

    echo "Answer: " & $count
    submitAnswer(day, part, $count)

proc srt(str: string): string =
    return str.sorted.join

proc getForTwo(words: var seq[string], word: string, dict: var Table[string, int]) =
    let
        words = words.filter(each => each.len != word.len)
    # echo word, 'z'
    for each in words:
        if each.contains(word):
            if each.len == 5:
                # words = words.filter(each => each.len != 5)
                discard dict.hasKeyOrPut(each, 5)
        else:
            if each.len == 6:
                # words = words.filter(each => each.len != 6)
                discard dict.hasKeyOrPut(each, 6)
    # echo dict
# 
proc getForFour(words: var seq[string], word: string, dict: var Table[string, int]) =
    let
        words = words.filter(each => each.len != word.len)
    for each in words:
        if each.contains(word):
            if each.len == 6:
                discard dict.hasKeyOrPut(each, 9)
    echo dict


proc getNumber(words: seq[string]) =
    var
        dict = initTable[string, int]()
        all_words = words.map(each => each.srt)
    echo all_words
    # isolate unique words
    for word in all_words:
        if word.len == 2:
            dict[word] = 1

            # echo "one"
            for sec in all_words:
                if sec.len == 5:
                    if sec.toHashSet.intersection(word.toHashSet).len == 2:
                        dict[sec] = 3
                    elif sec.contains(word):
                        dict[sec] = 5
                        
                elif sec.len == 6:
                    # if sec.contains(word):
                    if sec.toHashSet.intersection(word.toHashSet).len == 1:
                        dict[sec] = 6
                        # echo sec
 
        elif word.len == 4:
            dict[word] = 4

            for sec in all_words:
                if sec.len == 5:
                    if sec.toHashSet.intersection(word.toHashSet).len == 2:
                        dict[sec] = 2
                if sec.len == 6:
                    if sec.toHashSet.intersection(word.toHashSet).len == 4:
                        dict[sec] = 9
            

        elif word.len == 3:
            dict[word] = 7
 
        elif word.len == 7:
            dict[word] = 8

            for sec in all_words:
                if sec.len == 6:
                    if sec.toHashSet.intersection(word.toHashSet).len == 6:
                        dict[sec] = 0
            
    echo dict
    echo ""
 


proc partTwo() =
    const
        part = "2"
    var
        count = 0
    let
        nos_count =  nos.toCountTable
        # nos_dict  =  initTable[string, int]()                     
        # similar   = {
    echo nos_count

    for index, each in getInput(day):
        # var current_no = ""
        let
            output = each.split(" | ")[1].split(' ')
    
        # echo output
        getNumber(output)
 
    echo "Answer: " & $count
    # submitAnswer(day, part, $count)


when isMainModule:
    # partOne()
    partTwo()