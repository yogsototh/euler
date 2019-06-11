descr=%{
It was proposed by Christian Goldbach that every odd composite number can be written as the sum of a prime and twice a square.

9 = 7 + 2×1^(2)
15 = 7 + 2×2^(2)
21 = 3 + 2×3^(2)
25 = 7 + 2×3^(2)
27 = 19 + 2×2^(2)
33 = 31 + 2×1^(2)

It turns out that the conjecture was false.

What is the smallest odd composite that cannot be written as the sum of a prime and twice a square?
}

puts "Read primes and init data structure"
primes=File.read("firsts_1MM_primes.txt").split().collect{|x| x.to_i }
is_prime={}
primes.each do |p|
    is_prime[p]=true
end

puts "search"
k=1
while true
    n=2*k+1
    k+=1
    next if is_prime[n]
    puts "* "+n.to_s if k%100 == 0
    found=false
    primes.each do |p|
        break if p>n
        i=0
        while p + 2*(i**2) <= n
            if p + 2*(i**2) == n
                # puts "#{n} = #{p} + 2.#{i}^2"
                found=true
                break
            end
            i+=1
        end
        break if found
    end
    if not found
        puts n 
        exit 0
    end
end
