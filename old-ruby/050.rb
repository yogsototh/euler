descr=%{
    The prime 41, can be written as the sum of six consecutive primes:

    41 = 2 + 3 + 5 + 7 + 11 + 13
    This is the longest sum of consecutive primes that adds to a prime below one-hundred.

    The longest sum of consecutive primes below one-thousand that adds to a prime, contains 21 terms, and is equal to 953.

    Which prime, below one-million, can be written as the sum of the most consecutive primes?
}

require "primes"
po = Primes.new(1)

primes = po.primes

maxnb=0
best=0
min=0
max=0
limit=1000000

initsum=primes.inject(0) {|sum,p| sum+p}
initnb=primes.length
primes.reverse.each do |maxp|
    initsum -= maxp    
    sum=initsum
    initnb -= 1
    nb = initnb
    next if maxp>limit/21
    primes.each do |minp|
        sum -= minp
        nb -= 1
        next if minp>limit/21
        break if maxp <= minp
        next if sum>limit
        if po.is_prime(sum)
            if nb>maxnb
                best=sum
                maxnb=nb
                min=minp
                max=maxp
                puts %{#{best} #{min}->#{max} (#{maxnb})}
            end
        end
    end
end

puts %{BEST: #{best} #{min}->#{max} (#{maxnb})}
