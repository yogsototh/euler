descr=%{
    If the numbers 1 to 5 are written out in words: one, two, three, four, five, then there are 3 + 3 + 5 + 4 + 4 = 19 letters used in total.

    If all the numbers from 1 to 1000 (one thousand) inclusive were written out in words, how many letters would be used?

    NOTE: Do not count spaces or hyphens. For example, 342 (three hundred and forty-two) contains 23 letters and 115 (one hundred and fifteen) contains 20 letters. The use of "and" when writing out numbers is in compliance with British usage.
}

reflexion=%{
    let n be the number of letter used to write number from 1 to 99
    then the number of letter used to write 1 to 1000 would be:

    one hundred and * n
    two hundred and * n
    ...
    ninety nine hundred and * n

    that would be 
}

def write_tenth(name,n)
    if n%10 == 0
        return name
    else
        return name + "-" + write_natural(n%10)
    end
end

def write_natural(n) 
    # print "write_natural: #{n}"
    if n<100
        case n
        when 1  then return "one"
        when 2  then return "two"
        when 3  then return "three"
        when 4  then return "four"
        when 5  then return "five"
        when 6  then return "six"
        when 7  then return "seven"
        when 8  then return "eight"
        when 9  then return "nine"
        when 10 then return "ten"
        when 11 then return "eleven"
        when 12 then return "twelve"
        when 13 then return "thirteen"
        when 14 then return "fourteen"
        when 15 then return "fifteen"
        when 16..17 then return write_natural(n-10) + "teen"
        when 18     then return "eighteen"
        when 19     then return "nineteen"
        when 20..29 then return write_tenth("twenty" , n)
        when 30..39 then return write_tenth("thirty" , n)
        when 40..49 then return write_tenth("forty" , n)
        when 50..59 then return write_tenth("fifty"  , n)
        when 60..69 then return write_tenth("sixty"  , n)
        when 70..79 then return write_tenth("seventy", n)
        when 80..89 then return write_tenth("eighty", n)
        when 90..99 then return write_tenth("ninety" , n)
        else return ""
        end
    elsif n<1000
        m=(n/100).floor
        if n%100 == 0
            return write_natural(m) + " hundred"
        else
            return write_natural(m * 100) + " and " + write_natural( n % 100 )
        end
    elsif n == 1000
        m=(n/1000).floor
        if n%1000 == 0
            return write_natural((n/1000).floor) + " thousand "
        else
            return write_natural(m * 1000) + " and " + write_natural( n % 1000 )
        end
    end
end

res=""
(1..1000).each do |i|
    print i.to_s+" "
    puts write_natural(i)
    res<<=write_natural(i)
end

puts res.gsub(/[ -]/,"").length
