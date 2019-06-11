descr=%{
You are given the following information, 
but you may prefer to do some research for yourself.

    * 1 Jan 1900 was a Monday.
    * Thirty days has September,
      April, June and November.
      All the rest have thirty-one,
      Saving February alone,
      Which has twenty-eight, rain or shine.
      And on leap years, twenty-nine.
    * A leap year occurs on any year evenly divisible by 4, 
      but not on a century unless it is divisible by 400.

How many Sundays fell on the first of the month during the 
twentieth century (1 Jan 1901 to 31 Dec 2000)?
}

nbdaysbymonth=[31,28,31,30,31,30,31,31,30,31,30,31]

# 0 Monday, ... , 6 Sunday
day_of_month=0
nb_sunday=0
(1900..2000).each do |year|
    is_leap = ( year % 4 == 0 ) 
    if ( year % 100 == 0 ) && ( year % 400 != 0 )
        is_leap = false
    end
    if is_leap
        nbdaysbymonth[1]=29
    else
        nbdaysbymonth[1]=28
    end
    (0..11).each do |month|
        # puts "1st #{month+1}/#{year} = #{day_of_month}"
        if day_of_month == 6 && year >= 1901
            puts "* #{month+1}/#{year}"
            nb_sunday += 1
        end
        day_of_month = ( day_of_month + nbdaysbymonth[month] ) % 7
    end
end

puts nb_sunday
