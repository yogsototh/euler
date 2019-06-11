descr=%{
    An irrational decimal fraction is created by concatenating the positive integers:

    0.123456789101112131415161718192021...

    It can be seen that the 12^(th) digit of the fractional part is 1.

    If d_(n) represents the n^(th) digit of the fractional part, find the value of the following expression.

    d_(1) × d_(10) × d_(100) × d_(1000) × d_(10000) × d_(100000) × d_(1000000)
}

str=""
(1..(1000000)).each do |i|
    str.concat(i.to_s)
end

prod=1
(0..6).each do |p|
    digit=str[10**p - 1]-"0"[0]
    puts digit
    prod *= digit
end

puts "Product = #{prod}"
