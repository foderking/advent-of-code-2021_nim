import std/httpclient
from os import existsFile
# import strutils


const
    Cookie = "53616c7465645f5f286233854807ebf2e15e1f6171afd50d75c2bb44570165dbb1da648b9f80588b05066079605f6baf"
    Year   = "2021"

proc downloadInput(day: string) =
    ## Downloads input for a specific day
    ## 
    ## Params
    ## =========
    ## 
    ## day: day of input to download
    let 
        client = newHttpClient()
        cook   = "session=" & Cookie
        url    = "https://adventofcode.com/" & Year & "/day/" & day & "/input"
    echo "Downloading input..."

    client.headers = newHttpHeaders({ "Cookie": cook })
    let content = client.getContent(url)

    echo "Input downloaded!"
    let file_name = "input" & day & ".txt"
    writeFile(file_name, content)

iterator getInput*(day: string): string =
    ## Iterates over any line in days input
    ## 
    ## If the file hasn't been downloaded yet,
    ## it downloads it automatically
    ## 
    ## Main implementation stolen from nim std library `lines` iterator

    let file_name = "input" & day & ".txt"
    if not file_name.existsFile:
        downloadInput(day)

    var f = open(filename, bufSize = 8000)
    try:
        var res = newStringOfCap(80)
        while f.readLine(res): yield res
    finally:
        close(f)

proc Test() =
    const day = "1"

    downloadInput(day)

when isMainModule:
    Test()