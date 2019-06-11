descr=%{
    A perfect number is a number for which the sum of its proper divisors is exactly equal to the number. For example, the sum of the proper divisors of 28 would be 1 + 2 + 4 + 7 + 14 = 28, which means that 28 is a perfect number.

    A number n is called deficient if the sum of its proper divisors is less than n and it is called abundant if this sum exceeds n.

    As 12 is the smallest abundant number, 1 + 2 + 3 + 4 + 6 = 16, the smallest number that can be written as the sum of two abundant numbers is 24. By mathematical analysis, it can be shown that all integers greater than 28123 can be written as the sum of two abundant numbers. However, this upper limit cannot be reduced any further by analysis even though it is known that the greatest number that cannot be expressed as the sum of two abundant numbers is less than this limit.

    Find the sum of all the positive integers which cannot be written as the sum of two abundant numbers.
}

def sum_of_divisors(n)
    sum=1
    p=2
    while p**2 <= n and n>1
        if n % p == 0 
            j=p**2
            n = n/p
            while n%p == 0
                j = j*p
                n = n / p
            end
            sum=sum*(j-1)
            sum=sum / (p-1)
        end
        if p == 2
            p=3
        else
            p=p+2
        end
    end
    if n>1
        sum *= n+1
    end
    return sum
end

def sum_of_proper_divisors(n)
    return sum_of_divisors(n) - n
end

abd_numbers=[]
is_abd={}
(1..28123).each do |n|
    d=sum_of_proper_divisors(n)
    if d>n
        abd_numbers <<= n
        is_abd[n]=d
    end
end

sum=0
(1..28123).each do |n|
    skip=false
    abd_numbers.each do |i|
        if i>=n
            break
        end
        if not is_abd[ n-i ].nil?
            skip=true
            next
        end
    end
    if skip
        next
    end
    puts n
    sum += n
end
puts sum
