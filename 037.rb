descr=%{
    The number 3797 has an interesting property. Being prime itself, it is possible to continuously remove digits from left to right, and remain prime at each stage: 3797, 797, 97, and 7. Similarly we can work from right to left: 3797, 379, 37, and 3.

    Find the sum of the only eleven primes that are both truncatable from left to right and right to left.

    NOTE: 2, 3, 5, and 7 are not considered to be truncatable primes.
}


puts "Read primes"
primes=File.read("firsts_1MM_primes.txt").split().collect! { |p| p.to_i }
is_prime={}

puts "Init datastructure"
primes.each do |p|
    is_prime[p]=true
end

puts "search truncatable left to right and right to left"
truncatable=[]
primes.each do |p|
    # verify if it is truncatable
    next if p<10
    # puts p
    not_truncatable=false
    str=p.to_s.split('')
    while str.length > 1
        str.pop
        num=str.join('').to_i
        # puts "> #{num}"
        if not is_prime[num]
            not_truncatable=true
            break
        end
    end
    next if not_truncatable
    str=p.to_s.split('')
    while str.length > 1
        str.shift()
        num=str.join('').to_i
        # puts "> #{num}"
        if not is_prime[num]
            not_truncatable=true
            break
        end
    end
    next if not_truncatable
    puts "Trunkatable: #{p}"
    truncatable<<=p
    if truncatable.length == 11
        break
    end
end

puts "NB: #{truncatable.inject(0){|sum,n| sum+n}}"
