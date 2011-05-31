descr=%{
    The number, 197, is called a circular prime because all rotations of the digits: 197, 971, and 719, are themselves prime.

    There are thirteen such primes below 100: 2, 3, 5, 7, 11, 13, 17, 31, 37, 71, 73, 79, and 97.

    How many circular primes are there below one million?
}

puts "Read primes"
primes=File.read("firsts_1MM_primes.txt").split().collect! { |p| p.to_i }
is_prime={}

puts "Init datastructure"
primes.each do |p|
    is_prime[p]=true
end

puts "search circulars"
circular=[]
primes.each do |p|
    arr=p.to_s.split('')
    len=arr.length
    number=arr.join('').to_i
    i=0
    # puts "#{len} #{number} #{i}"
    while i<len && is_prime[number]
        x=arr.shift()
        arr.push(x)
        number=arr.join('').to_i
        # puts "> #{number}"
        i+=1
    end
    if i==len
        puts "circular #{p}"
        circular <<= p
    end
end

puts "NB: #{circular.length}"
