def palindrome
    palin=[]
    x=999
    while x>100
        y=999
        while y>x
            z=x*y
            s=z.to_s
            if s == s.reverse
                palin <<= s
            end
            y -= 1
        end
        x -= 1
    end
    palin.sort
end

puts palindrome
