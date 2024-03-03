import "qa"

numberToRoman = function(n)
	currentNumber = n
	result = ""
	numbers = [1000, 500, 100, 50, 10 , 5, 1]
	romanDigits = ["M","D","C","L","X","V","I"]
	
	while currentNumber > 0
		for i in range(0, numbers.len-1)
			if currentNumber >= numbers[i] then
				result = result + romanDigits[i]
				currentNumber = currentNumber - numbers[i]
				break
			else if (i+1) % 2 == 0 then
				if i < numbers.len-1 and currentNumber+numbers[i+1] >= numbers[i] then
					result = result + romanDigits[i+1]
					currentNumber = currentNumber + numbers[i+1]
					break
				end if
			else
				if i < numbers.len-2 and currentNumber+numbers[i+2] >= numbers[i] then
					result = result + romanDigits[i+2]
					currentNumber = currentNumber + numbers[i+2]
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