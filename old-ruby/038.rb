descr=%{
Take the number 192 and multiply it by each of 1, 2, and 3:

    192 × 1 = 192
    192 × 2 = 384
    192 × 3 = 576

By concatenating each product we get the 1 to 9 pandigital, 192384576. We will call 192384576 the concatenated product of 192 and (1,2,3)

The same can be achieved by starting with 9 and multiplying by 1, 2, 3, 4, and 5, giving the pandigital, 918273645, which is the concatenated product of 9 and (1,2,3,4,5).

What is the largest 1 to 9 pandigital 9-digit number that can be formed as the concatenated product of an integer with (1,2, ... , n) where n > 1?
}

$numbers=%q(123456789).split('').sort 
def is_pandigital(str)
    return str.split('').sort == $numbers
end

best=(123456789)
(2..10).each do |n|
    concat_prod=""
    base=1
    while concat_prod.length < 10
        concat_prod=""
        (1..n).each do |i|
            concat_prod <<= (base*i).to_s
        end
        if is_pandigital(concat_prod)
            puts %{base=#{base} n=#{n} #{concat_prod}}
            if concat_prod.to_i > best
                best=concat_prod.to_i
                puts %{* base=#{base} n=#{n} #{best}}
            end
        end
        base += 1
    end
end
