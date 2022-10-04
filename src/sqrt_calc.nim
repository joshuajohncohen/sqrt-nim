import decimal

import std/strformat
import std/strutils

import std/terminal
import std/wordwrap

template squared(d: DecimalType): DecimalType =
  (d * d)

proc pow(d: DecimalType, e: DecimalType): DecimalType =
  result = d

  for _ in 1..parseInt($abs(e)):
    result *= d

  if e < newDecimal("0"):
    result = newDecimal("1") / result

proc squareRoot(n: DecimalType, precision: DecimalType): DecimalType =
  let dec1 = newDecimal("1")
  let dec2 = newDecimal("2")
  let dec10 = newDecimal("10")
  
  var numerator = n
  var numDigits = newDecimal("0")

  while numDigits < precision:
    while (numerator + dec1).squared() < n * dec10.pow(numDigits * dec2):
      numerator += 1
      echo numerator

    numerator *= 10
    numDigits += dec1

  result = numerator / dec10.pow(numDigits)

when isMainModule:
  
  from benchmark import timeSpent
  
  echo "Welcome to Joshua and Tanner's square root algorithm (new and improved and overhauled and reimplemented and optimized and just generally way faster)".wrapWords(terminalWidth(), false)
  echo "-----------------"
  echo ""
  
  var
     num: DecimalType
     digits: DecimalType
     answer: DecimalType

  while true:
    echo "\n\nEnter a positive number to take the square root of:"
    num = newDecimal(readLine(stdin))
  
    echo "\nWhat precision, in terms of the number of digits following the decimal point, should the result be calculated to? (zero for an integer result)".wrapWords(terminalWidth(), false)
    digits = newDecimal($parseInt(readLine(stdin)))

    echo ""
  
    timeSpent "The calculation":
      answer = squareRoot(num, digits)
    
    echo (&"\n\nThe square root of {num}, to {digits} digit(s) after the decimal point, is {$answer}.").wrapWords(terminalWidth(), false)
