def sum_of_square(n)
    sum=0
    (1..n).each do |x|
        sum+=x**2
    end
    sum
end

def square_of_sum(n)
    sum=0
    (1..n).each do |x|
        sum+=x
    end
    sum**2
end

puts square_of_sum(100) - sum_of_square(100)
