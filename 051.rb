descr=%{
    By replacing the 1st digit of *3, it turns out that six of the nine possible values: 13, 23, 43, 53, 73, and 83, are all prime.

    By replacing the 3rd and 4th digits of 56**3 with the same digit, this 5-digit number is the first example having seven primes among the ten generated numbers, yielding the family: 56003, 56113, 56333, 56443, 56663, 56773, and 56993. Consequently 56003, being the first member of this family, is the smallest prime with this property.

    Find the smallest prime which, by replacing part of the number (not necessarily adjacent digits) with the same digit, is part of an eight prime value family.
}

require 'primes'

$po = Primes.new
$curnumber
$dynamic = {}

def rec_test_all_cases(tab,min,n)
    # puts "#{tab.join} min: #{min} n: #{n}"
    if n==0
        if $dynamic[tab.join()]
            return
        end
        nb=0
        (0..9).each do |k|
            tmp=tab.map do |x| 
                x=='X'?k:x
            end
            if tmp[0] == 0
                next
            end
            if $po.is_prime( tmp.join().to_i )
                # puts tmp.join()
                nb += 1
            end
        end
        if nb == 8
            (0..9).each do |k|
                tmp=tab.map do |x| 
                    x=='X'?k:x
                end
                if tmp[0] == 0
                    next
                end
                if $po.is_prime( tmp.join().to_i )
                    puts tmp.join()
                    nb += 1
                end
            end
            puts "FOUND! #{$curnumber} #{tab.join()}"
            exit
        else
            $dynamic[ tab.join() ]=nb
            puts "##{nb} => #{$curnumber} #{tab.join()}"
        end
        return
    end
    (min..tab.length-1).each do |i|
        tmp=tab.clone
        tmp[i]='X'
        # puts "tmp: #{tmp.join}"
        rec_test_all_cases(tmp, i,0)
        if n-1>0
            rec_test_all_cases(tmp, i+1, n-1)
        end
    end
end

def test_all_cases_for(p)
    tab=p.to_s.split('')
    rec_test_all_cases(tab, 0, tab.length - 1)
end

$po.primes.each do |p|
    next if p<10
    $curnumber=p
    test_all_cases_for(p) 
end
