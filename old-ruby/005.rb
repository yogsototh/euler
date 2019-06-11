def check(n)
    (2..20).each do |x|
        return false if n % x != 0
    end
    return true
end

def prime_factor(x)
    i=2
    while i<= Math.sqrt(x)
        if x%i == 0
            if check(x/i)
                return prime_factor(x/i)
            end
        end
        i += 1
    end
    return x
end

n=2*3*4*5*6*7*8*9*10*11*12*13*14*15*16*17*18*19*20
puts n
puts prime_factor(n)
