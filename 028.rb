descr=%{
    Starting with the number 1 and moving to the right in a clockwise direction a 5 by 5 spiral is formed as follows:

    21 22 23 24 25
    20  7  8  9 10
    19  6  1  2 11
    18  5  4  3 12
    17 16 15 14 13

    It can be verified that the sum of the numbers on the diagonals is 101.

    What is the sum of the numbers on the diagonals in a 1001 by 1001 spiral formed in the same way?
}

reflexion=%{
    We can remark:

    1 + 

    (1+2) + (1+2*2) + (1+3*2) + (1+4*2) +
    // let x be the last calulcated number (1+4*2)
    (x+4) + (x+2*4) + (x+3*4) + (x+4*4) +
    // let y be the last calulcated number (x+4*4)
    (y+6) + (y+2*6) + (y+3*6) + (y+4*6) +
    ...
}

size=1001
max=size**2
n=1
sum=0
step=2
while n<max
    (1..4).each do |s|
        n+=step
        # puts n
        sum+=n
    end
    step+=2
end
puts sum+1
