import times, os, strutils, strformat, terminal, std/wordwrap

template timeSpent*(benchmarkName: string, code: untyped) =
  block:
    let benchmarkNameInjectable {.inject.} = benchmarkName
    let realTimeStart = epochTime()
    let processingTimeStart = cpuTime()
    code
    let processingTimeElapsed = cpuTime() - processingTimeStart
    let totalTimeElapsed = epochTime() - realTimeStart
    let processingTimeElapsedStr {.inject.} = processingTimeElapsed.formatFloat(format = ffDecimal, precision = 3)
    let totalTimeElapsedStr {.inject.} = totalTimeElapsed.formatFloat(format = ffDecimal, precision = 3)
    let processingTimePercentStr {.inject.} = ((processingTimeElapsed / totalTimeElapsed) * 100).formatFloat(format = ffDecimal, precision = 3)
    echo (&"{benchmarkNameInjectable} took {totalTimeElapsedStr}s in real time, but only {processingTimePercentStr}% of that time, or {processingTimeElapsedStr}s, was actually spent doing CPU processing.").wrapWords(terminalWidth(), false)

#[

Adapted from a stack overflow answer (https://stackoverflow.com/a/36580495) by zah (https://stackoverflow.com/users/35511/zah), used under CC BY-SA 4.0 (https://creativecommons.org/licenses/by-sa/4.0/) / Added CPU timer code and refactored by changing template and variable names from original and using `&` operator in place of string concatenation

]#