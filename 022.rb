%{
    Using names.txt (right click and 'Save Link/Target As...'), a 46K text file containing over five-thousand first names, begin by sorting it into alphabetical order. Then working out the alphabetical value for each name, multiply this value by its alphabetical position in the list to obtain a name score.

    For example, when the list is sorted into alphabetical order, COLIN, which is worth 3 + 15 + 12 + 9 + 14 = 53, is the 938th name in the list. So, COLIN would obtain a score of 938 × 53 = 49714.

    What is the total of all the name scores in the file?
}

v=File.read("names.txt")
list=v.sub(/\n/,'').gsub('"','').split(',').sort

i=0
sum=0
list.each do |name|
    i+=1
    val=0
    name.each_byte do |letter|
        val += letter + 1 - 'A'[0]
    end
    score = val * i
    sum+=score
    puts "#{name} (#{i}) * #{val} = #{score}"
end

puts sum

