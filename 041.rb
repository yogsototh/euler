descr=%{
    We shall say that an n-digit number is pandigital if it makes use of all the digits 1 to n exactly once. For example, 2143 is a 4-digit pandigital and is also prime.

    What is the largest n-digit pandigital prime that exists?
}

thoughts=%{
    remark that all 9-digit pandigital number are not prime.

    1 + ... + 9 = 45 which is divisible by 3

    We don't need to search for prime pandigital superior to 10**8
    Also

    1 = 1
    1+2 = 3 => divisible by 3
    1+2+3 = 6 => divisible by 3
    1+2+3+4 = 10
    1+2+3+4+5 = 15 => divisible by 3
    1+ ... +6 = 21 => divisible by 3
    1+ ... +7 = 28
    1+ ... +8 = 36 => divisible by 3
    1+ ... +9 = 45 => divisible by 3

    Therefore at max there exists a 7-digit pandigital prime
    if not only a 4-digit pandigital prime
}

puts "Read primes"
primes=File.read("firsts_10MM_primes.txt").split()

$numbers=%q(1234567).split('').sort 
def is_pandigital(str)
    return str.split('').sort == $numbers
end

puts "Search pandigitals"
primes.each do |str|
    next if str.length != 7
    if is_pandigital(str)    
        puts str
    end
end
