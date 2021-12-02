import std/httpclient
from os import existsFile
import nre, seqUtils
# import strutils


const
    Cookie = "53616c7465645f5f286233854807ebf2e15e1f6171afd50d75c2bb44570165dbb1da648b9f80588b05066079605f6baf"
    Year   = "2021"

proc downloadInput(day: string, year: string) =
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

proc getInput*(day: string, year=Year): seq[string] =
    ## Iterates over any line in days input
    ## 
    ## Return  a sequence containing each line in input
    ## 
    ## If the file hasn't been downloaded yet,
    ## it downloads it automatically
    ## 
    ## e.g
    ## ```
    ## for each in getInput("4", "2020):
    ##      echo lineInput
    let
        file_name = "input" & day & ".txt"

    if not file_name.existsFile:
        downloadInput(day, year)

    var
        inputs: seq[string]
        f = open(filename, bufSize = 8000)
    try:
        var
            res = newStringOfCap(80)
        while f.readLine(res):
            inputs.add(res)
    finally:
        close(f)
    
    return inputs


proc submitAnswer*(day: string, part: string, answer: string) =
    echo "Submitting answer..."
    let 
        client = newHttpClient(maxRedirects=0)
        cook   = "session=" & Cookie
        url    = "https://adventofcode.com/" & Year & "/day/" & day & "/answer"
        reqBody =  "level=" & part & "&" & "answer=" & answer
    # echo reqBody
    # echo url
    client.headers = newHttpHeaders({"Cookie": cook, "Content-Type": "application/x-www-form-urlencoded" })
    let resp =client.post(url, reqBody)

    let
        respBody = resp.body
        regMatch = respBody.find(re"\<main\>\s+\<article\>\<p\>(.*?)\<\/p\>").get.captures[0]

    echo regMatch
    # echo resp.headers


when isMainModule:
    # Test()
    # echo ["input1.txt".readFile]
    # for each in getInput("5"):
    #     echo each
    submitAnswer("1", "2", "1564")
    # echo getInput("5", "2015")