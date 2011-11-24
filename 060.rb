#!/usr/bin/env ruby
# -*- encoding: utf-8 -*-
require './primes'
$po = Primes.new(100)

def concat_prime_with_set(n,set)
    set.each do |m|
        $po.is_prime( %{#{n}#{m}} ) and
            $po.is_prime( %{#{m}#{n}} )
    end
end

sets=Array.new

sets[0]=Array.new
$po.primes.each do |p|
    break if p>1500
    sets[0].append( [p] )
end

def create_set(n)
    sets[n]=Array.new
    $po.primes.each do |p|
        break if p>1500
        first_set.each do |qs|
            sets[n].append( qs.append(p) ) if concat_prime_with_set p qs
        end
    end
end

create_set(1)
print sets[1][0]
