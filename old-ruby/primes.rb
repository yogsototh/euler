class Primes
    attr_accessor :primes
    def initialize(nb=1)
        puts "Read primes"
        @primes=File.read("firsts_#{nb}MM_primes.txt").split().collect! { |p| p.to_i }
        @is_prime={}
        puts "Init datastructure"
        @primes.each do |p|
            @is_prime[p]=true
        end
    end

    def is_prime(p)
        return @is_prime[p] == true
    end
end
