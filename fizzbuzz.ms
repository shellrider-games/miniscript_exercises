import "qa"

fizzbuzz = function(number)
	if number % 15 == 0 then
		return "FizzBuzz"
	end if
	if number % 5 == 0 then
		return "Buzz"
	end if
	if number % 3 == 0 then
		return "Fizz"
	end if
	return "" + number
end function

runTests = function()
	qa.assertEqual fizzbuzz(1) , "1"
	qa.assertEqual fizzbuzz(2) , "2"
	qa.assertEqual fizzbuzz(3) , "Fizz"
	qa.assertEqual fizzbuzz(6) , "Fizz"
	qa.assertEqual fizzbuzz(5) , "Buzz"
	qa.assertEqual fizzbuzz(20), "Buzz"
	qa.assertEqual fizzbuzz(15) , "FizzBuzz"
	qa.assertEqual fizzbuzz(30) , "FizzBuzz"
end function

runTests

for i in range(1,100)
	print fizzbuzz(i)
end for