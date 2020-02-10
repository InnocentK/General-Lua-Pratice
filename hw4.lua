--Problem 1------------------------------------------------------
function avg(array)

    local arr_avg = 0;
    local arr_len = 0;

    --Loops through array adding the sum of the contents
    for key,value in pairs(array) do
        arr_avg = arr_avg + value
	arr_len = arr_len + 1   --Calculates length
    end 
   
    arr_avg = arr_avg / arr_len
    return arr_avg
end

--Testing
--print(avg(arr))
-----------------------------------------------------------------

--Problem 2-------------------------------------------------------
function int_divide(a,b)

    local count = 0   --Keeps track of number of "divisions"

    --Loops until b can no longer subtract from a
    while (a >= b) do
        a = a - b
	count = count + 1
    end

    return count;
end

--Testing
--print(int_divide(4,4))
--------------------------------------------------------------------

--Problem 3---------------------------------------------------------
function cone_facts(r,h)

    local r_square = r * r
    local h_square = h * h
    local to_root = r_square + h_square

    local volume = (1 / 3) * math.pi * r_square * h
    local surface_area = (math.pi * r_square) + (math.pi * r * math.sqrt(to_root) )

    return volume,surface_area
end

--Testing
--print(cone_facts(3,3))
--------------------------------------------------------------------

--Problem 4---------------------------------------------------------
function join(a,b,c,d)

    local joined = a

    if b ~= nil then joined = joined .. "," .. b end 
    if c ~= nil then joined = joined .. "," .. c end 
    if d ~= nil then joined = joined .. "," .. d end 

    return joined
end

--Testing
--print(join("Four","Three","Two","One"))
--------------------------------------------------------------------

--Problem 5---------------------------------------------------------
function read_elements(f_name)

    local table2D = {}
    local count = 1;
    io.input(f_name)

    while true do
        line = io.read()
	if line == nil then break end

	-- Saves the two strings in each line seperately
	local twoString = {}

	--Saves the first column
	for word in line:gmatch("(%a+)") do
	    table.insert(twoString, word)
	end

	--Saves the second column
	for word in line:gmatch(" (%d+)") do
	    table.insert(twoString, word)
	end

	--The strings are then added to the table
	table2D[count] = {twoString[1], twoString[2]}
	count = count + 1
    end

    return table2D
end

--Testing
--elements_table = read_elements("elements.txt")
--print(elements_table[10][1], elements_table[10][2])
--------------------------------------------------------------------

--Problem 6---------------------------------------------------------
function sort_by_year(table_name)

    table.sort(table_name, function (a,b) return a[2] < b[2] end)

    --Iterates through table print element names and years
    for key,value in pairs(table_name) do
        print(value[1], value[2])
    end
end

--Testing
--sort_by_year({{'Hydrogen',1776},{'Helium',1868},{'Lithium',1817},{'Phosphorus',1669}})
--------------------------------------------------------------------

--Problem 7---------------------------------------------------------
function scan(num_string)

    local is_dec = true
    local is_octal = true
    local is_hexa = true
    local is_neg = false
    local hexa_start = false
    local type = "NONSENSE"
    
    --So that negative numbers are treated the same as positive
    if num_string:sub(1,1) == "-" then
        is_neg = true
	num_string = num_string:sub(2,num_string:len())
    end

    --Checks if the number is a decimal number
    for char in num_string:gmatch(".") do
        if (char > "9" or char < "0") then
	    is_dec = false
	    break
        end  
    end

    --Checks if the number is an octal number
    for char in num_string:gmatch(".") do
        if (char > "7" or char < "0") then 
	    is_octal = false
	    break
        end 
    end

    --So that the beginning of a hexadecimal number does not interfere with the rest
    if num_string:sub(1,2) == "0x" then
        hexa_start = true
	num_string = num_string:sub(3,num_string:len())
    end

    --Checks if the number is a hexadecimal number
    for char in num_string:gmatch(".") do
        if (char > "9" or char < "0") then is_hexa = false end

	--Double checking not to exclude cases in which the hexa num is > 9
	if (char >= "a" and char <= "f") then is_hexa = true end
	if (char >= "A" and char <= "F") then is_hexa = true end

	if is_hexa == false then break end  
    end

    --For special case where only a negative sign is given or empty string or sequence "0x"
    if num_string == "" then
        if is_neg == true then num_string = "-" end
        if hexa_start == true then num_string = num_string .. "0x" end
	--type = "NONSENSE"
        return num_string,type 
    end

    --Sets what type of number it is
    if is_dec == true then type = "DECIMAL" end
    if is_octal == true then type = "OCTAL" end
    if is_hexa == true then type = "HEXADECIMAL" end

    --Resets the num_string to it's original (if it was altered)
    if hexa_start == true then num_string = "0x" .. num_string end
    if is_neg == true then num_string = "-" .. num_string end

    return num_string,type
end

--Testing
print(scan("0"))
print(scan("1"))
print(scan("72"))
print(scan("-72"))
print(scan("00"))
print(scan("01"))
print(scan("-074"))
--------------------------------------------------------------------

--Problem 8---------------------------------------------------------
function make_account(currency_string)

    local balance = 0

    return function(money_added) --Deposit
        balance = balance + money_added
    end,
    function(money_removed) --Withdraw
        balance = balance - money_removed
    end,
    function() --report
        print(string.format("You have %d %s in your account",balance,currency_string))
    end
end

--Testing
--deposit, withdraw, report = make_account('dollars')
--report()
--deposit(10)
--report()
--withdraw(4)
--report()
--------------------------------------------------------------------