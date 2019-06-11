descr=%#
    If p is the perimeter of a right angle triangle with integral length sides, {a,b,c}, there are exactly three solutions for p = 120.

    {20,48,52}, {24,45,51}, {30,40,50}

    For which value of p ≤ 1000, is the number of solutions maximised?
#

best=0
maxsol=0
(5..1000).each do |p|
    # find all {a,b,c}
    # such that 
    # a<=b and a^2 + b^2 = c^2
    # and a+b+c = p

    nbsol=0
    # sqrtp=Math.sqrt(p).floor
    (1..p).each do |a|
        # a^2 + b^2 = c^2 => b^2 = c^2 - a^2
        #                 => b = sqrt( c^2 - a^2 )
        #
        # a + b + c = p   => b = p - c - a
        #
        (a..p).each do |b|
            tmp=a**2 + b**2
            c = Math.sqrt(tmp)
            break if a + b + c > p
            next if a + b + c < p
            next if c**2 != tmp
            puts "#{p}: (#{a},#{b},#{c})"
            nbsol += 1
        end
    end

    if nbsol > maxsol
        maxsol=nbsol
        best=p
    end
end

puts "Best p = #{best} => #{maxsol}"
