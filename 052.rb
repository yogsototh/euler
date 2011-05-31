descr=%{
It can be seen that the number, 125874, and its double, 251748, contain exactly the same digits, but in a different order.

Find the smallest positive integer, x, such that 2x, 3x, 4x, 5x, and 6x, contain the same digits.
}

n=1
while true
    l=n.to_s.split('').sort
    find=true
    (2..6).each do |m|
        v=(n*m).to_s.split('').sort
        if v != l
            find=false
            break
        end
    end
    if find
        puts "FOUND: #{n}"
        exit 0
    end
    n+=1
end
