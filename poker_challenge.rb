

Card = Struct.new :num, :type

class Hand
  attr_accessor :cards

  RANKINGS = { high_card: 1, one_pair: 200, two_pairs: 300, three_of_a_kind: 400, straight: 500,
                flush: 600, full_house: 700, four_of_a_kind: 800, straight_flush: 900, royal_flush: 1000 }



  def initialize(cards)
    @cards = cards
  end

  def high_card
    num_value.inject(:+)
  end

  def one_pair
    num_of_dup == 1
  end

  def two_pairs
    num_of_dup == 2
  end

  def three_of_a_kind 
    three_of_a_kind?.count == 1
  end

  def straight 
    straight?
  end

  def flush
    flush?
  end

  def full_house
    three_of_a_kind? && num_of_dup == 2
  end

  def four_of_a_kind 
    num_value.group_by { |i| i }.select { |k, v| v.size == 4 }.count == 1
  end

  def straight_flush
    straight? && flush?
  end

  def royal_flush
    num_value.inject(:+) == 60 && flush?
  end

  def flush?
    type.uniq.length == 1
  end

  def straight?
    num_value.sort.each_cons(2).all? { |x,y| y == x + 1 }
  end

  def three_of_a_kind? 
    num_value.group_by { |i| i }.select { |k, v| v.size == 3 }
  end

  def dup?
    num_value.group_by { |i| i }.select { |k, v| v.size > 1 }
  end

  def num_of_dup
    dup?.count
  end

  def num 
    array.map { |n| array.index(n).even? ? n : nil}.compact
  end

  def type
    array.map { |n| array.index(n).odd? ? n : nil}.compact 
  end

  def array 
    @cards.map {|i| i.split("") }.flatten
  end

  def num_value
    value = {T: 10, J: 11, Q: 12, K: 13, A: 14}
    num.map { |n| value.has_key?(n.to_s.to_sym) ? value[n.to_s.to_sym] : n.to_i }
  end

  def score
    if royal_flush
      RANKINGS[:royal_flush] + high_card
    elsif straight_flush
      RANKINGS[:straight_flush] + high_card
    elsif four_of_a_kind
      RANKINGS[:four_of_a_kind] + high_card
    elsif full_house
      RANKINGS[:full_house] + high_card
    elsif flush
      RANKINGS[:flush] + high_card
    elsif straight
      RANKINGS[:straight] + high_card
    elsif three_of_a_kind
      RANKINGS[:three_of_a_kind] + high_card
    elsif two_pairs
      RANKINGS[:two_pairs] + high_card
    elsif one_pair
      RANKINGS[:one_pair] + high_card
    else
      high_card
    end
  end
end
p1_win = 0

###############################
# disabeling File for testing #
###############################

File.open("./poker.txt").map { |line|
  a = line.split(/\W/)
  p1 = Hand.new(a[0..4])
  p2 = Hand.new(a[5..9]) 
  if p1.score > p2.score
    p1_win += 1
  elsif p1.score < p2.score
    p2_win += 1
  elsif p1.score == p2.score
    no_win += 1
  end
}
puts p1_win




