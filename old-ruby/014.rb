description=%{
    The following iterative sequence is defined for the set of positive integers:

    n → n/2 (n is even)
    n → 3n + 1 (n is odd)

    Using the rule above and starting with 13, we generate the following sequence:
    13 → 40 → 20 → 10 → 5 → 16 → 8 → 4 → 2 → 1

    It can be seen that this sequence (starting at 13 and finishing at 1) contains 10 terms. Although it has not been proved yet (Collatz Problem), it is thought that all starting numbers finish at 1.

    Which starting number, under one million, produces the longest chain?

    NOTE: Once the chain starts the terms are allowed to go above one million.
}

num=1000000
$seq={}

$seq[1]=1

def u(n)
    # puts %{u(#{n})*}
    if not $seq[n].nil?
        # puts %{n=#{n} len=#{$seq[n]}*}
        return $seq[n]
    end

    if n%2 == 0
        $seq[n]=u(n/2)+1
    else
        $seq[n]=u((3*n) + 1)+ 1
    end
    # puts %{n=#{n} len=#{$seq[n]}}
    return $seq[n]
end

(1..num).each do |n|
    # puts "====== u(#{n}) ========"
    u(n)
end
max=0
number=0
$seq.each do |k,v|
    if k<=1000000 and v>max
        max=v 
        number=k
    end
end

x=number
while number != 1 do
    puts number 
    if number%2 == 0
        number=number/2
    else
        number=(3*number)+1
    end
end

puts "First number = #{x}, length of sequence = #{max}"
