import decimal
import std/math

import std/strformat
import std/strutils

import std/terminal
import std/wordwrap


proc sciNotation(n: float64): seq[float64] = 
  let sciString = &"{n:e}"
  for x in sciString.split("e"):
    result.add(float64(parseFloat(x)))

proc intSqrt(n: int64): int64 =
  var float_n = float64(n)
  var sci_n: seq[float64]
  for i in sciNotation(float_n):
    sci_n.add(float64(i))
  var start = int64(sci_n[0]/10 * (10.pow(floor(sci_n[1] / 2))))
  var below = float64(start)
  var above = float64(start)
  while int64(above.pow(2)) <= int64(float_n):
    above += 1
  below = above - 1
  return int64(below)

proc squareRoot(n: int64, precision: int64): string =
  if precision == 0:
    return $intSqrt(n)
  elif precision < 0:
    discard "Error on negative input"
  
  var decimalResult = newDecimal(0)
  
  var denominator = int64(10)
  var numerator = int64(0)
  var numDigits = int64(0)

  while numDigits < precision:
    while (float64(numerator).pow(2) + float64(1)) < float64(float64(n) * float64(denominator).pow(2)):
      numerator += 1

    decimalResult += (newDecimal(numerator) / newDecimal(denominator))
    numDigits += 1
    numerator = int64(-1)
    denominator *= int64(10)

  result = $decimalResult

when isMainModule:
  
  from benchmark import timeSpent
  
  echo "Welcome to Joshua and Tanner's square root algorithm (new and improved and overhauled and reimplemented and optimized and just generally way faster)".wrapWords(terminalWidth(), false)
  echo "-----------------"
  echo ""
  
  var
     num: int64
     digits: int64
     answer: string

  while true:
    echo "\n\nEnter a positive integer to take the square root of:"
    num = int64(parseInt(readLine(stdin)))
  
    echo "\nWhat precision, in terms of the number of digits following the decimal point, should the result be calculated to? (zero for an integer result)".wrapWords(terminalWidth(), false)
    digits = int64(parseInt(readLine(stdin)))

    echo ""
  
    timeSpent "The calculation":
      answer = squareRoot(num, digits)
    
    echo (&"\n\nThe square root of {num}, to {digits} digit(s) after the decimal point, is {answer}.").wrapWords(terminalWidth(), false)
