import utility, strutils, seqUtils, sugar, strscans

const 
    day = "2"

type
    # x reps the horizontal postion, y reps the vertical position
    # both measured with reference to the water surface
    Position = tuple
        x: int
        y: int
    AltPosition = tuple
        aim: int
        x: int
        y: int

proc partOne() =
    const part = "1"
    var
        count = 0
        horizontal: int
        vertical:   int
        position: Position

    for each in getInput(day):
        if each.scanf("forward $i", horizontal):
            position.x += horizontal
        elif each.scanf("down $i", vertical):
            position.y += vertical
        elif each.scanf("up $i", vertical):
            position.y -= vertical

    count = position.x * position.y
    echo "Answer: " & $count
    submitAnswer(day, part, $count)

proc partTwo() =
    const
        part = "2"
    var
        count = 0
        current_aim: int
        forward: int
        current_position: AltPosition

    for index, each in getInput(day):
        if each.scanf("forward $i", forward):
            current_position.x += forward
            current_position.y += (forward * current_position.aim)

        elif each.scanf("down $i", current_aim):
            current_position.aim += current_aim
        elif each.scanf("up $i", current_aim):
            current_position.aim -= current_aim

    echo current_position
    count = current_position.x * current_position.y
    echo "Answer: " & $count
    submitAnswer(day, part, $count)


when isMainModule:
    partOne()
    partTwo()