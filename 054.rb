descr=%{
In the card game poker, a hand consists of five cards and are ranked, from lowest to highest, in the following way:

 * High Card: Highest value card.
 * One Pair: Two cards of the same value.
 * Two Pairs: Two different pairs.
 * Three of a Kind: Three cards of the same value.
 * Straight: All cards are consecutive values.
 * Flush: All cards of the same suit.
 * Full House: Three of a kind and a pair.
 * Four of a Kind: Four cards of the same value.
 * Straight Flush: All cards are consecutive values of same suit.
* Royal Flush: Ten, Jack, Queen, King, Ace, in same suit.

The cards are valued in the order:
2, 3, 4, 5, 6, 7, 8, 9, 10, Jack, Queen, King, Ace.

If two players have the same ranked hands then the rank made up of the highest value wins; for example, a pair of eights beats a pair of fives (see example 1 below). But if two ranks tie, for example, both players have a pair of queens, then highest cards in each hand are compared (see example 4 below); if the highest cards tie then the next highest cards are compared, and so on.

Consider the following five hands dealt to two players:
Hand        Player 1        Player 2       Winner
1       5H 5C 6S 7S KD
        Pair of Fives
                        2C 3S 8S 8D TD
                        Pair of Eights
                                            Player 2
2       5D 8C 9S JS AC
        Highest card Ace
                        2C 5C 7D 8S QH
                    Highest card Queen
                                            Player 1
3       2D 9C AS AH AC
           Three Aces
                        3D 6D 7D TD QD
                        Flush with Diamonds
                                           Player 2
4       4D 6S 9H QH QC
        Pair of Queens
        Highest card Nine
                        3D 6D 7H QD QS
                        Pair of Queens
                        Highest card Seven
                                            Player 1
5       2H 2D 4C 4D 4S
        Full House
        With Three Fours
                        3C 3D 3S 9S 9D
                        Full House
                        with Three Threes
                                            Player 1

poker.txt, contains one-thousand random hands dealt to two players. 
Each line of the file contains ten cards (separated by a single space): 
the first five are Player 1's cards and the last five are Player 2's cards. 
You can assume that all hands are valid (no invalid characters or 
repeated cards), each player's hand is in no specific order, 
and in each hand there is a clear winner.

How many hands does Player 1 win?
}

hands=File.read("poker.txt").split("\n").collect { |line| x=line.split; [x[0..4],x[5..9]] }

class Category
    attr_accessor :cat
    attr_accessor :value
    attr_accessor :subvalue
    def to_s
        res=@numbers.join(" ") << " : "
        case @cat
        when 10 then res<<="royal_flush"
        when 9  then res<<="straight_flush"
        when 8  then res<<="four_of_a_kind"
        when 7  then res<<="full_house"
        when 6  then res<<="flush"
        when 5  then res<<="straight"
        when 4  then res<<="three_of_a_kind"
        when 3  then res<<="two_pairs"
        when 2  then res<<="one_pair"
        when 1  then res<<="high_card"
        end
        res <<= " V(#{@value}"
        if @subvalue
            res <<= ":#{@subvalue}"
        end
        res <<= ")"
    end
    def initialize(hand)
        @rawhand=hand
        @hand=hand.map do |str| 
            c = str.split('') 
            case c[0]
            when /[2-9]/ then  { c[0].to_i => c[1] }
            when 'T'     then  { 10 => c[1] }
            when 'J'     then  { 11 => c[1] }
            when 'Q'     then  { 12 => c[1] }
            when 'K'     then  { 13 => c[1] }
            when 'A'     then  { 14 => c[1] }
            else exit 1
            end
        end
        @numbers=@hand.map {|x| x.keys[0]}.sort
        @nb={}
        @numbers.each do |n|
            if @nb[n]
                @nb[n]+=1
            else
                @nb[n]=1
            end
        end
        @nbcolors={}
        @hand.each do |x| 
            if @nbcolors[x.values[0]].nil?
                @nbcolors[x.values[0]]=1
            else
                @nbcolors[x.values[0]]+=1
            end
        end
        # print "@hand: "
        # p @hand
        # print "@nb: "
        # p @nb
        # print "@numbers: "
        # p @numbers
        # print "@nbcolors: "
        # p @nbcolors
        @cat=nil
        @value=nil
        @subvalue=nil
        return if is_royal_flush
        return if is_straight_flush
        return if is_four_of_a_kind
        return if is_full_house
        return if is_flush
        return if is_straight
        return if is_three_of_a_kind
        return if is_two_pairs
        return if is_one_pair
        return is_high_card
    end

    def is_royal_flush
        if is_straight_flush and @value==14
            @cat=10
            return true
        end
        return false
    end
    def is_straight_flush
        if is_flush and is_straight
            @cat=9
            return true
        else
            return false
        end
    end
    def is_four_of_a_kind
        carre = @nb.select{|k,v| v>=4}.map {|x| x[0]}
        if carre.empty?
            return false
        end
        @cat=8
        @value=carre[0]
    end
    def is_full_house
        brelan = @nb.select{|k,v| v==3}.map {|x| x[0]}

        pair = @nb.select{|k,v| v==2}.map {|x| x[0]}


        if brelan.empty? or pair.empty?
            return false
        end

        @cat=7
        @value=brelan[0]
        @subvalue=pair[0]
    end
    def is_flush
        if @nbcolors.size != 1
            return false
        end
        @cat=6
        @value=@numbers[-1]
        @subvalue=@numbers[-2]
    end
    def is_straight
        last=nil
        if @numbers == [2,3,4,5,14]
            @cat=5
            @value=5
            return true
        end
        @numbers.each do |n|
            if last.nil?
                last=n
                next
            end
            if n != last+1
                return false
            end
            last=n
        end
        @cat=5
        @value=@numbers[-1]
        return true
    end
    def is_three_of_a_kind
        brelan = @nb.select{|k,v| v>=3}.map {|x| x[0]}

        if brelan.empty?
            return false
        end
        @cat=4
        @value=brelan[0]
    end
    def is_two_pairs
        pairs = @nb.select{|k,v| v>=2}.map {|x| x[0]}

        if pairs.size < 2
            return false
        end
        @cat=3
        @value = pairs.max
        @subvalue = pairs.min
        return true
    end
    def is_one_pair
        pair = @nb.select{|k,v| v>=2}.map {|x| x[0]}

        if pair.empty?
            return false
        end
        @cat=2
        @value = pair[0]
        return true
    end
    def is_high_card
        @cat=1
        @value=@numbers[-1]
        @subvalue=@numbers[-2]
        return true
    end
end

def tonumber(hand)
    hand.map do |str| 
            c = str.split('') 
            case c[0]
            when /[2-9]/ then  c[0].to_i
            when 'T'     then  10
            when 'J'     then  11
            when 'Q'     then  12
            when 'K'     then  13
            when 'A'     then  14
            end
        end.sort
end

def highest_card(hand1,hand2)
    numbers1=tonumber(hand1).reverse
    numbers2=tonumber(hand2).reverse
    i=0
    numbers1.each do |c|
        if c > numbers2[i]
            return true
        end
        if c < numbers2[i]
            return false
        end
        i+=1
    end
    return true
end

def win(h)
    hand1=h[0]
    hand2=h[1]

    cat1=Category.new(hand1)
    # puts "HAND1: #{cat1.to_s}" 
    cat2=Category.new(hand2)
    # puts "HAND2: #{cat2.to_s}" 

    # Best category win
    if cat1.cat > cat2.cat
        return true
    elsif cat1.cat < cat2.cat
        return false
    end

    # same category? Best value win
    if cat1.value > cat2.value
        return true
    elsif cat1.value < cat2.value
        return false
    end

    # same value? Best subvalue win (if it exists)
    if not cat1.subvalue.nil?
        if cat1.subvalue > cat2.subvalue
            return true
        elsif cat1.subvalue < cat2.subvalue
            return false
        end
    end

    # Nothing less? Highest card are compared
    return highest_card(hand1, hand2)
end

sum=0
hands.each do |h|
    if win(h)
        # puts "PLAYER 1 (WIN)"
        puts "True"
        sum+=1
    else
        puts "False"
        # puts "PLAYER 2 (LOSE)"
    end
end

puts sum
