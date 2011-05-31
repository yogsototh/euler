descr=%{
The arithmetic sequence, 1487, 4817, 8147, in which each of the terms increases
by 3330, is unusual in two ways: (i) each of the three terms are prime, and,
(ii) each of the 4-digit numbers are permutations of one another.

There are no arithmetic sequences made up of three 1-, 2-, or 3-digit primes,
exhibiting this property, but there is one other 4-digit increasing sequence.

What 12-digit number do you form by concatenating the three terms in this
    sequence?
}


puts "Read primes"
$primes=File.read("firsts_1MM_primes.txt").split()

fdprimes=[]
$primes.each do |p|
    if p.length == 4
        fdprimes <<= p
    end
end

is_prime={}
fdprimes.each do |p|
    is_prime[p]=true
end

fdprimes.each do |p|
    next if p == "1487"
    puts p
    sigp=p.split('').sort
    fdprimes.each do |q|
        next if q<=p
        sigq=q.split('').sort
        if sigp == sigq
            r = ( 2*q.to_i-p.to_i ).to_s
            sigr=r.split('').sort
            if sigp == sigr and is_prime[r]
                    puts "#{p}#{q}#{r}"
                    exit 0
            end
        end
    end
end
