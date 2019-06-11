descr=%{
    A unit fraction contains 1 in the numerator. The decimal representation of the unit fractions with denominators 2 to 10 are given:

        ^(1)/_(2)   =   0.5
        ^(1)/_(3)   =   0.(3)
        ^(1)/_(4)   =   0.25
        ^(1)/_(5)   =   0.2
        ^(1)/_(6)   =   0.1(6)
        ^(1)/_(7)   =   0.(142857)
        ^(1)/_(8)   =   0.125
        ^(1)/_(9)   =   0.(1)
        ^(1)/_(10)  =   0.1

        Where 0.1(6) means 0.166666..., and has a 1-digit recurring cycle. It can be seen that ^(1)/_(7) has a 6-digit recurring cycle.

        Find the value of d < 1000 for which ^(1)/_(d) contains the longest recurring cycle in its decimal fraction part.
}

reflexion=%{
    simulate the manual division

    10               | 7
     30              |-----------
      20             | 0,142...
       ...
}

def _rec_cycle_frac(n,m,rests,i) 
    return 0 if n==0
    # print "\t_rec_cycle_frac "
    # p [n, m, rests, i]

    if n < m
        rests[n*10]=i
        return _rec_cycle_frac(n*10,m,rests,i+1)
    end
   
    num=(n%m) * 10
    if not rests[num].nil?
        # puts "[RES] not rest[#{num}].nil? => #{rests[num]}; #{i}-#{rests[num]}=#{i- rests[num]}"
        return i - rests[num] 
    end
    rests[num]=i
    return _rec_cycle_frac( num, m, rests, i+1 )
end

def size_of_rec_cycle_of_frac(n,m) 
    return _rec_cycle_frac(n,m,{},0)
end

max=0
best=0
(1..1000).each do |m|
    n=size_of_rec_cycle_of_frac(1,m)
    if n>max
        best=m
        max=n
    end
    puts "1/#{m}: #{n}"
end

puts "#{best} #{max}"
