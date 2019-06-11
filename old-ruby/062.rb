# Algorithm:
#
# key(x) is the numbers ordered by decreasing value
# x=0
# while true; do
#   k = key(x^3)
#   let (n,xs) = hash[k]  
#   hash[k] := (n+1,xs++[x^3])
#   if n>=4
#      break
#   i++;
# done     
# result = head.snd $ hash[k]

def key(x)
    x.to_s.split('').sort {|x,y| y <=> x}.join.to_i
end

x=0

hash=Hash.new
while true do
    k = key(x**3)
    if hash[k].nil?
    then
        hash[k] = [0,x**3]
        next
    end
    v = hash[k]
    n=v[0]
    xs=v[1]
    hash[k]=[n+1,xs]
    if n >= 4
    then
        puts "BREAK"
        puts x
        puts k
        puts x**3
        break
    end
    x+=1
end
puts hash[k][1]
