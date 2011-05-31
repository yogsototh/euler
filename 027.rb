descr=%{
    Euler published the remarkable quadratic formula:

    n² + n + 41

    It turns out that the formula will produce 40 primes for the consecutive values n = 0 to 39. However, when n = 40, 40^(2) + 40 + 41 = 40(40 + 1) + 41 is divisible by 41, and certainly when n = 41, 41² + 41 + 41 is clearly divisible by 41.

    Using computers, the incredible formula  n² − 79n + 1601 was discovered, which produces 80 primes for the consecutive values n = 0 to 79. The product of the coefficients, −79 and 1601, is −126479.

    Considering quadratics of the form:

        n² + an + b, where |a| < 1000 and |b| < 1000

    where |n| is the modulus/absolute value of n
    e.g. |11| = 11 and |−4| = 4

    Find the product of the coefficients, a and b, for the quadratic expression that produces the maximum number of primes for consecutive values of n, starting with n = 0.
}

thoughts=%{
    compute a huge number of prime and test using it
}

puts "read prime numbers"
prime=File.read('firsts_10MM_primes.txt').split.collect! { |i| i.to_i }
is_prime={}
prime.each do |p|
    is_prime[p]=true
end

puts "begin computation"

max=0
besta=0
bestb=0

def is_prime_number(num,is_prime)
    if num>10000000
        puts "may an error for #{num}"
    end
    return is_prime[num]
end

(-1000..1000).each do |a|
    (-1000..1000).each do |b|
        n=0
        while is_prime_number( n**2 + a*n + b , is_prime)
            n+=1
        end
        if n>max
            max=n
            besta=a
            bestb=b
            puts "#{besta} #{bestb} => #{max}"
        end
    end
end

puts "#{besta} #{bestb} => #{max}"
puts "product= #{besta * bestb}"
