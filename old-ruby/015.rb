descr=%{
    Starting in the top left corner of a 2×2 grid, there are 6 routes (without backtracking) to the bottom right corner.

    1) 00 01 02 12 22
    2) 00 01 11 12 22
    3) 00 01 11 21 22
    4) 00 10 11 12 22
    5) 00 10 11 21 22
    6) 00 10 20 21 22

    How many routes are there through a 20×20 grid?
}

reflexion=%#
    coordinates at time t are (x_t,y_t)
    We have: 
        0 <= x_t <= n
        0 <= y_t <= n
        x_{t+1} + y_{t+1} =  x_t + y_t + 1
        x_{t+1} >= x_t
        y_{t+1} >=  y_t

    In order to have a computable recursive content, we need to extend
    this reasonment to rectangles nxm.

    nb(0,n)=1
    nb(n,0)=1
    nb( 1,1 ) = nb(0,1) + nb(1,0)

    nb(n,m)=nb(m,n)
#

number=20
$mem=[]
(0..number).each do |i| 
    $mem <<= [] 
    (0..number).each do |j|
        $mem[i] <<= 0
    end
end 

def nb(n,m) 
    if (m>n)
        tmp=n
        n=m
        m=tmp
    end
    if $mem[n][m] != 0
        return $mem[n][m]
    end
    if n==0 or m==0
        $mem[n][m]=1
        return 1
    end
    $mem[n][m] = nb(n-1,m) + nb(n,m-1)
    return $mem[n][m]
end

puts nb(number,number)
p $mem
