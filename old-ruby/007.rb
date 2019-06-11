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
    
    def findXthPrime(x)
        i=2
        while @t.length<x 
            if is_prime(i)
                @t<<=i 
                puts %{#{i} [#{@t.length}]}
            end
            i+=1
        end
        return @t[-1]
    end
end

prime_finder=NthPrime.new
# puts prime_finder.findXthPrime(6)
puts prime_finder.findXthPrime(10001)
