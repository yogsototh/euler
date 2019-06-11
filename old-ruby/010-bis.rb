limit=2000000;

crosslimit=Math.sqrt(2000000);
sieve=[0]*limit;

i=0;
while i<limit
    sieve[i]=false
    i+=1
end

i=4
while i<limit
    sieve[i]=1;
    i+=2
end
  
i=3
while i<crosslimit
    if !sieve[i]
        m=i*i
        while m<limit
            sieve[m]=true;
            m+=2*i
        end
    end
    i+=2
end
sum=0;
i=2;

while i<limit
    if not sieve[i]
        sum += i
    end 
    i+=1
end
puts sum
