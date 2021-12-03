import utility, strutils, seqUtils, sugar, strscans

const 
    day = "3"
    char_range  = 12

proc getMostSig(value: seq[string], index: int): tuple[gamma: char, eps: char] =
    var
        most = 0
        count = 0
    for each in value:
        most += each[index].int - 48
        count += 1
    
    if most < 500:
        return ('0', '1')
    else:
        return ('1', '0')

proc getGamma(input: seq[string], iters = 0..<char_range): string =
    var gamma = ""
    for ind in iters:
        let sig = getMostSig(input, ind)
        gamma.add(sig.gamma)

    return gamma

proc getEpsilon(input: seq[string], iters = 0..<char_range): string =
    var eps = ""
    for ind in iters:
        let sig = getMostSig(input, ind)
        eps.add(sig.eps)

    return eps

proc getPower(one: string, two: string): int =
    let
        newOne = one.parseBinInt
        newTwo = two.parseBinInt
    return newOne * newTwo

proc getRating(values: seq[string], index: int): tuple[most: seq[string], least: seq[string] ] =
    var 
        most: int
        count: int
        ones: seq[string]
        zeros: seq[string]
    for each in values:
        most += each[index].int - 48
        count += 1

        if each[index] == '1':
            ones.add(each)
        else:
            zeros.add(each)

    if most.toFloat < (count / 2): 
        return (zeros, ones)
    else:
        return (ones, zeros)

proc getOxy(input: seq[string]): string =
    var
        ind = 0
        ans =  getRating(input, ind)[0]
    # echo ans
    while ans.len > 1:
        ind += 1
        ans = getRating(ans, ind)[0]
    
    return ans[0]
 
proc getCo2(input: seq[string]): string =
    var
        ind = 0
        ans =  getRating(input, ind)[1]
    # echo ans
    while ans.len > 1:
        ind += 1
        ans = getRating(ans, ind)[1]
    
    return ans[0]
        

proc partTwo() =
    const part = "2"
    let
        allInput = getInput(day)
    # for each in allInput :
    let
        oxy = getOxy(allInput)
        co2 = getCo2(allInput)
        count = getPower(oxy, co2)
    echo oxy, ":", co2

    echo "Answer: " & $count
    submitAnswer(day, part, $count)

proc partOne() =
    const
        part = "1"
    let
        allInput = getInput(day)
        gam = getGamma(allInput)
        epp = getEpsilon(allInput)

    let count = getPower(gam, epp)

    echo "Answer: " & $count
    # submitAnswer(day, part, $count)


when isMainModule:
    partOne()
    partTwo()

