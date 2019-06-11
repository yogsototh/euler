descr=%{
    Surprisingly there are only three numbers that can be written as the sum of fourth powers of their digits:

        1634 = 1^(4) + 6^(4) + 3^(4) + 4^(4)
        8208 = 8^(4) + 2^(4) + 0^(4) + 8^(4)
        9474 = 9^(4) + 4^(4) + 7^(4) + 4^(4)

    As 1 = 1^(4) is not a sum it is not included.

    The sum of these numbers is 1634 + 8208 + 9474 = 19316.

    Find the sum of all the numbers that can be written as the sum of fifth powers of their digits.
}

thoughts=%{
    First, remark it is not so surprising:

    remark the greatest number done with 5 digits is: 99999 => 9^4 + ... + 9^4 < 33000
    and as number is an exponential function depending on the number of digits and power function is less (in the end) than this function. For each n there is always a maximal value.

    now using the same reasonment for the power 5 we see the maximal value will have at most 6 digits (9^5 * 6 < 999999)
}

pow=5
list=[]
(10..1000000).each do |n|
    sum=0
    n.to_s.each_byte do |b|
        sum+=( b - "0"[0] )**pow
    end
    if n == sum
        puts "#{n}"
        list<<=n
    end
end

puts "Sum=" + list.inject(0) { |sum,x| sum+x }.to_s
