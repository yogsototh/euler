descr=%{
    The fraction ^(49)/_(98) is a curious fraction, as an inexperienced mathematician in attempting to simplify it may incorrectly believe that ^(49)/_(98) = ^(4)/_(8), which is correct, is obtained by cancelling the 9s.

    We shall consider fractions like, ^(30)/_(50) = ^(3)/_(5), to be trivial examples.

    There are exactly four non-trivial examples of this type of fraction, less than one in value, and containing two digits in the numerator and denominator.

    If the product of these four fractions is given in its lowest common terms, find the value of the denominator.
}

# n/m
res=[]
(10..99).each do |n|
    (n+1..99).each do |m|
        next if n%10 == 0 and m%10 == 0
        next if n%11 == 0 and m%11 == 0
        nb_first=0
        n.to_s.split('').each do |c|
            newn=c.to_i
            nb_first+=1
            nb_second=0
            m.to_s.split('').each do |d|
                nb_second += 1
                next if nb_first == nb_second
                newm=d.to_i
                if newm == 0
                    next
                end
                if n.to_f/m == newn.to_f/newm
                    res <<= [n,m,newn,newm]
                    puts %{#{n}/#{m} = #{newn}/#{newm}}
                end
            end
        end
    end
end
