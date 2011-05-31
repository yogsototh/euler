descr=%{
    145 is a curious number, as 1! + 4! + 5! = 1 + 24 + 120 = 145.

    Find the sum of all numbers which are equal to the sum of the factorial of their digits.

    Note: as 1! = 1 and 2! = 2 are not sums they are not included.
}

thoughts=%{
    the difficulty remains in finding a maximum number after which

    n>N =>  n cannot be written as the sum of a factorial of its digits.

    the max is attained by number containing only 9

    limit is obtained when: n*9! > 10^n
}

def fact(n)
    return 1 if n <= 1
    return n*fact(n-1)
end


def sum_of_facts_of_digits(n)
    sum=0
    n.to_s.split('').collect { |i| sum += fact(i.to_i) }
    return sum
end

n=1
while sum_of_facts_of_digits(('9'*n).to_i) > 10**n
    n+=1
end
n-=1

sum=0
(10..10**n).each do |i|
    if sum_of_facts_of_digits(i) == i
        puts i
        sum+=i
    end
end

puts "Solution: #{sum}"
