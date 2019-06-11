descr=%{
    The first two consecutive numbers to have two distinct prime factors are:

    14 = 2 × 7
    15 = 3 × 5

    The first three consecutive numbers to have three distinct prime factors are:

    644 = 2² × 7 × 23
    645 = 3 × 5 × 43
    646 = 2 × 17 × 19.

    Find the first four consecutive integers to have four distinct primes factors.
    What is the first of these numbers?
}

thoughts=%{
    Loop for each number and find it's prime number decomposition (there is no shortcut doing this)
}


puts "Read primes"
$primes=File.read("firsts_1MM_primes.txt").split().collect! { |p| p.to_i }

# the uniq is to transform [2,2,3] into [2,3]
def prime_decomposition(n)
    if n <= 1
        return []
    end
    $primes.each do |p|
        if n % p == 0
            return ( prime_decomposition(n/p) << p ).uniq
        end
    end
end

size=4
buff=[]
(2..size).each do |n| 
    buff <<= prime_decomposition(n).length 
end
n=size+1
while true
    buff <<= prime_decomposition(n).length

    found=true
    buff.each do |l|
        if l != size 
            found=false
            break
        end
    end

    if n%1000 == 0
        print "** #{n}: "
        p buff
    end

    break if found
    buff.shift
    n+=1
end
puts "Solution = #{n+1-size}"
