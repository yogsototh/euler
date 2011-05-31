problem=%{
-- Starting with 1 and spiralling anticlockwise in the following way, a square spiral with side length 7 is formed.
--
-- 37 36 35 34 33 32 31
-- 38 17 16 15 14 13 30
-- 39 18  5  4  3 12 29
-- 40 19  6  1  2 11 28
-- 41 20  7  8  9 10 27
-- 42 21 22 23 24 25 26
-- 43 44 45 46 47 48 49
--
-- It is interesting to note that the odd squares lie along the bottom right diagonal, but what is more interesting is that 8 out of the 13 numbers lying along both diagonals are prime; that is, a ratio of 8/13 ≈ 62%.
--
-- If one complete new layer is wrapped around the spiral above, a square spiral with side length 9 will be formed. If this process is continued, what is the side length of the square spiral for which the ratio of primes along both diagonals first falls below 10%?
--
-- Reflexion:
-- if n is the side length of the square spiral. The numbers at each 'coin' are
--
-- 1 -> 1
-- 2 -> 3 5 7 9
-- 3 -> 13 17 21 25
-- ...
--
-- The rule is
-- (last_max_number + n.(size-1) | n in [1..4])
-- examples:
--      last_max_number=1
--      size = 3
--      1+2 = 3, 1+2*2=5, 1+3*2=7, 1+4*2=9
--
--      last_max_number=9
--      size=5
--      9+4=13, 9+2*4=17, 9+3*4=21, 9+4*4=25
}
require 'primes'
$po = Primes.new(100)

size=1
ratio=1
last_max_number=1
nb_prime=0.0
nb_numbers_on_diag=1

while ratio > 0.1 do
    size +=2
    (1..4).each do |n|
        last_max_number += (size-1)
        puts last_max_number
        nb_prime += 1 if $po.is_prime(last_max_number)
        nb_numbers_on_diag += 1
    end
    ratio= nb_prime / nb_numbers_on_diag
    puts ratio
end

puts "size = #{size}"
