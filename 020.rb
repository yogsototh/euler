def fact(x)
    return 1 if x<=1
    return x*fact(x-1)
end
puts fact(100).to_s.split("").collect! { |x| x.to_i }.inject(0) {|sum,v| sum+v}

