descr=%{
In England the currency is made up of pound, £, and pence, p, and there are eight coins in general circulation:

    1p, 2p, 5p, 10p, 20p, 50p, £1 (100p) and £2 (200p).

It is possible to make £2 in the following way:

    1×£1 + 1×50p + 2×20p + 1×5p + 1×2p + 3×1p

How many different ways can £2 be made using any number of coins?
}

def _nb_case(n,choices) 
    # print "#{n}, "
    # p choices
    if n<0
        return 0
    end
    if n==0
        return 1
    end

    sum=0
    subchoice=choices.clone
    choices.each do |p|
        break if p>n
        sum += _nb_case(n-p, subchoice)
        subchoice.shift
    end
    return sum
end

def nb_case(n)
    return _nb_case(n,[1,2,5,10,20,50,100,200])
end

(200..200).each do |n|
    print "# #{n}: "
    puts nb_case(n)
end
