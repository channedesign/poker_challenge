class Card
  NUMS = %w(2 3 4 5 6 7 8 9 T J Q K A)
  TYPES = %w(S H C D)

  attr_accessor :num, :type

  def initialize(i)
    self.num = NUMS[i % 13]
    self.type = TYPES[i % 4]
  end
end



class CardDistribution

  attr_accessor :cards

  def initialize
    self.cards = (0..51).to_a.shuffle.map { |i| Card.new(i) }.first(5)
  end
end



class Hand
  attr_accessor :cards

  RANKINGS = { high_card: 1, one_pair: 2, two_pairs: 3, three_of_a_kind: 4, straight: 5,
                flush: 6, full_house: 7, four_of_a_kind: 8, straight_flush: 9, royal_flush: 10 }



  def initialize(cards)
    @cards = cards
  end

  # def initialize(CardDistribution.new.cards.map { |card| "#{card.num}#{card.type}" })
  #   @player1 = player1
  #   @player2 = player2
  # end

  def high_card
    num_value.max
  end

  def one_pair
    num_of_dup == 1 ? RANKINGS[:one_pair] : 0
  end

  def two_pairs
    num_of_dup == 2 ? RANKINGS[:two_pairs] : 0
  end

  def three_of_a_kind 
    three_of_a_kind?.count == 1 ? RANKINGS[:three_of_a_kind] : 0
  end

  def straight 
    straight? ? RANKINGS[:straight] : 0
  end

  def flush
    flush? ? RANKINGS[:flush] : 0
  end

  def full_house
    three_of_a_kind? && num_of_dup == 2 ? RANKINGS[:full_house] : 0
  end

  def four_of_a_kind 
    four_of_a_kind?.count == 1 ? RANKINGS[:four_of_a_kind] : 0
  end

  def straight_flush
    
  end

  def four_of_a_kind?
    num.group_by { |i| i }.select { |k, v| v.size == 4 }
  end

  def flush?
    type.uniq.length == 1
  end

  def straight?
    num_value.sort.each_cons(2).all? { |x,y| y == x + 1 }
  end

  def three_of_a_kind? 
    num.group_by { |i| i }.select { |k, v| v.size == 3 }
  end

  def dup?
    num.group_by { |i| i }.select { |k, v| v.size > 1 }
  end

  def num_of_dup
    dup?.count
  end

  def num 
    array = @cards.map {|i| i.split("") }.flatten
    array.map { |n| array.index(n).even? ? n : nil}.compact
  end

  def type
    array = @cards.map {|i| i.split("") }.flatten
    array.map { |n| array.index(n).odd? ? n : nil}.compact 
  end

  def num_value
    value = {T: 10, J: 11, Q: 12, K: 13, A: 14}
    num.map { |n| value.has_key?(n.to_s.to_sym) ? value[n.to_s.to_sym] : n.to_i }
  end

  def score
    if four_of_a_kind == 8
      8
    elsif full_house == 7
      7
    elsif flush == 6
      6
    elsif straight == 5
      5
    elsif three_of_a_kind == 4
      4
    elsif two_pairs == 3
      3
    elsif one_pair == 2
      2
    # elsif high_card == 1
    #   1
    else
      0
    end
  end
end
# ["2S", "2C", "2D", "8S", "AH"] --- testing three_of_a_kind or you are super lucky
# ["3S", "2D", "6S", "5S", "4C"] --- testing for straight
# %w(5D AD TD 2D 6D) --- testing for flush
# %w(5D 5S 9D 9H 9S) --- testing for full_house
# %w(5S 5D 5C 5H TD) --- testing for four_of_a_kind
p1 = Hand.new(%w(5S 5D 5C 5H TD))


# print p1.cards
# puts
# print p1.score
# puts
# print p2.score






p2 = Hand.new(CardDistribution.new.cards.map { |card| "#{card.num}#{card.type}" })

puts "------------------------------------------"
print "Player One: #{p1.cards}"
puts
print "Player Two: #{p2.cards}"
puts
puts "------------------------------------------"
if p1.score > p2.score
  puts "Player One is the winner"
elsif p1.score < p2.score
  puts "Player Two is the winner"
elsif p1.score == p2.score
  if p1.high_card < p2.high_card
    puts "Player Two is the winner"
  else
    puts "Player One is the winner"
  end
else
  puts "No winner for this round"  # take this off
end
puts
print p1.four_of_a_kind?
puts
print p2.four_of_a_kind?
puts
