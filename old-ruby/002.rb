def fib (n)
    return 1 if n < 2
    x=y=i=1
    while i < n 
        z = x+y
        x = y
        y = z
        i+=1
    end
    return z
end

j=1
sum=0
x=fib(1)
while x<4000000
    x = fib(j)
    if x%2 == 0
        sum += x
    end
    j += 1
end

puts sum
