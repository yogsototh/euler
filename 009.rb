def check (a,b,c)
    puts %{#{a} #{b} #{c} = #{a**2 + b**2 + c**2}}
    return ( a**2 + b**2 == c**2 )
end

# a < b < c
a=1000
b=0
c=0
while not check(c,b,a) 
    if c<b-1
        b -= 1
        c += 1
    elsif b<a-1
        a -= 1
        b += c
        c =  1
    else
        exit 1
    end
    if a+b+c != 1000
        puts "ERROR"
        exit 1
    end
end

puts %{a=#{c} b=#{b} c=#{a}}
