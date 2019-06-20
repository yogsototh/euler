descr=%{
    Pentagonal numbers are generated by the formula, P_(n)=n(3n−1)/2. The first ten pentagonal numbers are:

    1, 5, 12, 22, 35, 51, 70, 92, 117, 145, ...

    It can be seen that P_(4) + P_(7) = 22 + 70 = 92 = P_(8). However, their difference, 70 − 22 = 48, is not pentagonal.

    Find the pair of pentagonal numbers, P_(j) and P_(k), for which their sum and difference is pentagonal and D = |P_(k) − P_(j)| is minimised; what is the value of D?
}

thoughts=%{
    We can make a fast test to know whether a number is pentagonal.

    We can also remark that this function is strictly growing.
    If P(k+1) - P(k) > P(j) then we should no more try to use the index j. 
}

def P(n)
    return n*(3*n - 1)/2
end

def is_pentagonal(k)
    # k = n(3n - 1)/2
    # 2k = n(3n - 1)
    # 3n^2 - n - 2k = 0
    #
    a=3.0; b=-1; c=-2.0*k
    # delta = sqrt( b^2 - 4ac )
    delta=Math.sqrt( b**2 - 4*a*c )
    sol1=( -b + delta )/(2*a)
    sol2=( -b - delta )/(2*a)

    # renvoie vrai s'il existe une solution entiere positive
    return true if sol1 == sol1.floor && sol1 > 0
    return true if sol2 == sol2.floor && sol2 > 0
    return false
end

# (1..117).each do |x|
#     puts x if is_pentagonal(x)
# end
j=1
k=2
while true
    pk=P(k)
    pj=P(j)
    diff=pk-pj
    sum=pk+pj
    # puts %{P(#{k})=#{pk}, P(#{j})=#{pj}, Pk-Pj=#{diff}#{"*" if is_pentagonal(diff)}, Pk+Pj=#{sum}#{"*" if is_pentagonal(sum)}}
    if is_pentagonal( sum ) && is_pentagonal( diff )
        puts %{P(#{k})=#{pk}, P(#{j})=#{pj}, Pk-Pj=#{diff}#{"*" if is_pentagonal(diff)}, Pk+Pj=#{sum}#{"*" if is_pentagonal(sum)}}
        puts diff
        break
    end
    if P(k+1) - pk > pj
        k += 1
        j = k-1
    else
        j -= 1
    end
end