def prime_factor(x)
    i=2
    while i<=Math.sqrt(x)
        if x % i == 0
            return [i] << prime_factor( x / i )
        end
        i += 1
    end
    return [x]
end
 
puts prime_factor(600851475143)
# puts prime_factor(13195)
