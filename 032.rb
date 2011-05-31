descr=%{
    We shall say that an n-digit number is pandigital if it makes use of all the digits 1 to n exactly once; for example, the 5-digit number, 15234, is 1 through 5 pandigital.

    The product 7254 is unusual, as the identity, 39 × 186 = 7254, containing multiplicand, multiplier, and product is 1 through 9 pandigital.

    Find the sum of all products whose multiplicand/multiplier/product identity can be written as a 1 through 9 pandigital.
    HINT: Some products can be obtained in more than one way so be sure to only include it once in your sum.
}

pand={}

$numbers=%q(123456789).split('').sort 

def is_pandigital(str)
    return str.split('').sort == $numbers
end

(1..10000).each do |n|
    (n..10000).each do |m|
        str=n.to_s+m.to_s+(n*m).to_s
        # puts "#{n} x #{m} = #{n*m}"
        # puts str
        if str.length > 9 
            break
        end
        if str.length == 9
            if is_pandigital(str)
                puts "# #{n*m}"
                pand[n*m]=true
            end
        end
    end
end

sum=0
puts "solution"
pand.each do |p,v|
    puts p
    sum+=p
end

puts "Sum: " + sum.to_s
