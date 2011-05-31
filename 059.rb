codes = File.read("cipher1.txt").split(",").map { |x| x.to_i }
# words = File.read("words.txt").split(",").map { |s| s[1..-2] }
# $is_word={}
# $potential_codes=[]
# words.each do |w|
#     $is_word[w]=true
# end

def to_ascii (l)
    res=""
    l.each do |c|
        res <<= c.chr
    end
    res
end

# (0..255).each do |x|
#     puts "#{x}:\n"
#     (0..255).each do |y|
#         (0..255).each do |z|
#             to_ascii(codes,[x,y,z])
#         end
#     end
# end

puts to_ascii(codes)

