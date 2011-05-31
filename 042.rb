descr=%{
    The n^(th) term of the sequence of triangle numbers is given by, t_(n) = ½n(n+1); so the first ten triangle numbers are:

    1, 3, 6, 10, 15, 21, 28, 36, 45, 55, ...

    By converting each letter in a word to a number corresponding to its alphabetical position and adding these values we form a word value. For example, the word value for SKY is 19 + 11 + 25 = 55 = t_(10). If the word value is a triangle number then we shall call the word a triangle word.

    Using words.txt (right click and 'Save Link/Target As...'), a 16K text file containing nearly two-thousand common English words, how many are triangle words?
}

def is_triangle_number(k)
    # k = n * (n+1) / 2
    # 2k = n * (n+1)
    # n**2 + n - 2k = 0

    # a=1 b=1 c=-2k

    delta=Math.sqrt(1 + 8*k)
    sol1=(  1 + delta)/2
    sol2=( -1 + delta)/2

    return true if sol1 == sol1.floor && sol1 > 0
    return true if sol2 == sol2.floor && sol2 > 0
    return false
end

def is_triangle_word(w)
    is_triangle_number( w.split('').inject(0) {|sum,c| sum += c[0] +1- "A"[0]} )
end

# test
# (1..55).each { |x| puts x.to_s + ": " + is_triangle_word(x).to_s }

# puts is_triangle_word("SKY")

words=File.read("words.txt").sub(/\n/,'').gsub('"','').split(',')
sum=0
words.each do |w|
    sum += 1 if is_triangle_word(w)
end

puts sum
