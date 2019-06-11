descr=%{
    The number, 1406357289, is a 0 to 9 pandigital number because it is made up of each of the digits 0 to 9 in some order, but it also has a rather interesting sub-string divisibility property.

    Let d_(1) be the 1^(st) digit, d_(2) be the 2^(nd) digit, and so on. In this way, we note the following:

        * d_(2)d_(3)d_(4)=406 is divisible by 2
        * d_(3)d_(4)d_(5)=063 is divisible by 3
        * d_(4)d_(5)d_(6)=635 is divisible by 5
        * d_(5)d_(6)d_(7)=357 is divisible by 7
        * d_(6)d_(7)d_(8)=572 is divisible by 11
        * d_(7)d_(8)d_(9)=728 is divisible by 13
        * d_(8)d_(9)d_(10)=289 is divisible by 17

    Find the sum of all 0 to 9 pandigital numbers with this property.
}

def ok(str)
    return false if str[0] == str[1] 
    return false if str[0] == str[2] 
    return false if str[1] == str[2] 
    return true
end

$potential={}

[2,3,5,7,11,13,17].each do |p|
    $potential[p]=[]
    # We first limit d8d9d10
    ((10/p).ceil .. (1000/p).floor).each do |i|
        str_num=(p*i).to_s
        str_num = "0#{str_num}" if p*i<100
        if ok( str_num )
            $potential[p] <<= str_num.split('')
        end
    end
end

[2,3,5,7,11,13,17].each do |p|
    puts "===="
    $potential[p].each do |t|
        print t.join + ", "
    end
end
puts

# now we have limited greatly the search space for pandigital numbers
$list=[]

def pandigit( tab, t, str)
    # p [ tab, t, str ]
    table=tab.clone
    p = table.pop()
    if p.nil?
        # puts "* "+t.join()+str
        $list <<= t.join()+str
        return
    end
    $potential[p].each do |num|
        next if t[0] != num[1] or t[1] != num[2]
        # puts "exists: #{num.join}"
        pandigit( table, num, t[2]+str);
    end
end

$numbers=%q(0123456789).split('').sort 
def is_pandigital(str)
    return str.split('').sort == $numbers
end

# $potential[17]=[ ["7","8","9"], ["4","5","6"] ]
# $potential[13]=[ ["6","7","8"] ]
# $potential[11]=[ ["5","6","7"] ]
# $potential[7] =[ ["4","5","6"] ]
# $potential[5] =[ ["3","4","5"] ]
# $potential[3] =[ ["2","3","4"] ]
# $potential[2] =[ ["1","2","3"] ]

sum=0
$potential[17].each do |t|
    pandigit( [2,3,5,7,11,13], t, "")

    # pandigit( [13], t, "")
end

$list.each do |str|
    (1..9).each do |d|
        number=d.to_s+str
        if is_pandigital( number )
                puts "OK: "+number
                sum += number.to_i
        end
    end
end

puts "Sum: #{sum}"
