descr=%{
    There are exactly ten ways of selecting three from five, 12345:

    123, 124, 125, 134, 135, 145, 234, 235, 245, and 345

    In combinatorics, we use the notation, 5C3 = 10.

    In general,
    nCr =   
    n!
    r!(n−r)!
        ,where r ≤ n, n! = n×(n−1)×...×3×2×1, and 0! = 1.

        It is not until n = 23, that a value exceeds one-million: 23C10 = 1144066.

        How many, not necessarily distinct, values of  nCr, for 1 ≤ n ≤ 100, are greater than one-million?
}

remarks=%{
    C(n,r) == C(n,n-r)
    C(n,r) > X => forall m>n C(m,r)>X 
    suppose r <= n-r

    5 x 4 x 3 x 2 x 1           5x4
    ----------------------- = ------- = 10
    ( 3 x 2 x 1 ) ( 2 x 1 )     2x1

    C(n,r) = n x (n-1) x ... x (n-(n-r)+1) / r x (r-1) x ... x 1
           = n x (n-1) x ... x (r+1) / r x (r-1) x ... x 1
}

def C(n,r)
    if (r > n-r)
        r = n-r
    end
    top=1
    (n-r+1..n).each do |x|
        top *= x
    end
    down=1
    (2..r).each do |x|
        down *= x
    end
    return top/down
end

sum=0
(1..100).each do |n|
    (1..n).each do |r|
        if C(n,r)>10**6
            sum+=1
        end
    end
end
puts sum
