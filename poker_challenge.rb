class Hand
  attr_accessor :cards

  RANKINGS = { high_card: 1, one_pair: 2, two_pairs: 3, three_of_a_kind: 4, straight: 5,
                flush: 6, full_house: 7, four_of_a_kind: 8, straight_flush: 9, royal_flush: 10 }



  def initialize(cards)
    @cards = cards
  end

  def high_card
    if dup?.empty?
      num_value.max
    else
      dup?.keys.max
    end
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
    straight? && flush? ? RANKINGS[:straight_flush] : 0
  end

  def royal_flush
    num_value.inject(:+) == 60 && flush? ? RANKINGS[:royal_flush] : 0
  end

  def four_of_a_kind?
    num_value.group_by { |i| i }.select { |k, v| v.size == 4 }
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
    cards.map {|i| i.split("") }.flatten
  end

  def num_value
    value = {T: 10, J: 11, Q: 12, K: 13, A: 14}
    num.map { |n| value.has_key?(n.to_s.to_sym) ? value[n.to_s.to_sym] : n.to_i }
  end

  def score
    if royal_flush == 10
      10
    elsif straight_flush == 9
      9
    elsif four_of_a_kind == 8
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
    else
      0
    end
  end
end
p1_win = 0
p2_win = 0
no_win = 0

###############################
# disabeling File for testing #
###############################

# File.open("./poker.txt").map { |line|
#   a = line.split(/\W/)
#   p1 = Hand.new(a[0..4])
#   p2 = Hand.new(a[5..9])
  
#   # puts "------------------------------------------"
#   # print "Player One: #{p1.cards}"
#   # puts
#   # print "Player Two: #{p2.cards}"
#   # puts
#   # puts "------------------------------------------"
  
#   if p1.score > p2.score
#     p1_win += 1
#   elsif p1.score < p2.score
#     p2_win += 1
#   elsif p1.score == p2.score
#     if p1.high_card < p2.high_card
#       p2_win += 1
#     elsif p1.high_card > p2.high_card
#       p1_win += 1
#     else
#       no_win += 1
#     end
#   end

# }
# puts p1_win
# puts p2_win
# puts no_win

