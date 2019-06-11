# The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.
# 
# Find the sum of all the primes below two million.
class NthPrime
    def initialize
        @t=[]
    end
    def is_prime(n)
        @t.each do |x|
            return false if n % x == 0
        end
        return true
    end
    
    def genPrimeUpTo(x)
        i=2
        while i<x
            if is_prime(i)
                @t<<=i 
                # puts %{#{i} [#{@t.length}]}
            end
            i+=1
        end
        return @t
    end

    def sumOfPrimeUpTo(x)
        @t=[];
        genPrimeUpTo(x)
        sum=0
        @t.each do |n|
            sum+=n
        end
        return sum
    end
end

prime_finder=NthPrime.new
puts prime_finder.sumOfPrimeUpTo(2000000)
