codes = File.read("cipher1.txt").split(",").map { |x| x.to_i }
def to_ascii (l)
    res=""
    l.each do |c|
        res <<= c.chr
    end
    res
end

(0..255).each do |x|
    (0..255).each do |y|
        (0..255).each do |z|
            res=to_ascii(codes,[x,y,z])
            res.each do |c|
                case c.ord
            end
        end
    end
end
