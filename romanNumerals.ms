import "qa"

numberToRoman = function(number)
	currentNumber = number
	result = ""
	numberMap = {1000 : "M", 500 : "D", 100: "C",50 : "L", 10 : "X", 5 : "V", 1 : "I"}
	
	while currentNumber > 0
		for entry in numberMap
			currentKeyIndex = numberMap.indexes.indexOf(entry.key)
			if currentNumber >= entry.key then
				result = result + entry.value
				currentNumber = currentNumber - entry.key
				break
			else if (currentKeyIndex+1) % 2 == 0 then
				if currentKeyIndex < numberMap.len-1 and currentNumber+numberMap.indexes[currentKeyIndex+1] >= entry.key then
					result = result + numberMap[numberMap.indexes[currentKeyIndex+1]]
					currentNumber = currentNumber + numberMap.indexes[currentKeyIndex+1]
					break
				end if
			else
				if currentKeyIndex < numberMap.len-2 and currentNumber+numberMap.indexes[currentKeyIndex+2] >= entry.key then
					result = result + numberMap[numberMap.indexes[currentKeyIndex+2]]
					currentNumber = currentNumber + numberMap.indexes[currentKeyIndex+2]
					break
				end if
			end if
		end for
	end while
	return result
end function

runTests = function()
	qa.assertEqual numberToRoman(1) , "I"
	qa.assertEqual numberToRoman(2) , "II"
	qa.assertEqual numberToRoman(3) , "III"
	qa.assertEqual numberToRoman(4) , "IV"
	qa.assertEqual numberToRoman(5) , "V"
	qa.assertEqual numberToRoman(7) , "VII"
	qa.assertEqual numberToRoman(9) , "IX"
	qa.assertEqual numberToRoman(10), "X"
	qa.assertEqual numberToRoman(15), "XV"
	qa.assertEqual numberToRoman(20), "XX"
	qa.assertEqual numberToRoman(50), "L"
	qa.assertEqual numberToRoman(100), "C"
	qa.assertEqual numberToRoman(500), "D"
	qa.assertEqual numberToRoman(1000), "M"
	qa.assertEqual numberToRoman(40), "XL"
	qa.assertEqual numberToRoman(90), "XC"
	qa.assertEqual numberToRoman(99), "XCIX"
	qa.assertEqual numberToRoman(49), "XLIX"
	qa.assertEqual numberToRoman(145), "CXLV"
end function

runTests

for i in range(1,100)
	print numberToRoman(i)
end for