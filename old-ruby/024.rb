descr=%{
    A permutation is an ordered arrangement of objects. For example, 3124 is one possible permutation of the digits 1, 2, 3 and 4. If all of the permutations are listed numerically or alphabetically, we call it lexicographic order. The lexicographic permutations of 0, 1 and 2 are:

    012   021   102   120   201   210

    What is the millionth lexicographic permutation of the digits 0, 1, 2, 3, 4, 5, 6, 7, 8 and 9?
}

numbers=[]
(0..9).each do |n|
    numbers <<= n
end

$nb = 0
$target = 1000000

def permute( tab, pref)
    if tab.length == 0 
        $nb += 1
        if $nb % 10000 == 0
            puts %{#{$nb}: #{pref.join(" ")}}
        end
        if $nb == $target
            puts %{RESULT: #{$nb}: #{pref.join(" ")}}
            exit
        end
        return
    end
    tab.each do |e|
        subtab=tab.clone
        subtab.delete(e)
        permute( subtab, pref + [e] )
    end
end

permute( numbers,[] )
