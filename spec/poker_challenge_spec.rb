require './poker_challenge'

describe 'Hand' do

	describe '#high_card' do
		it 'shows the high card total value' do
			hand = Hand.new(%w(2S 4D 6H AD 9C))
			expect(hand.high_card).to eq(35)
		end

	end

	describe '#one_pair and two_pairs' do
		it 'detects one pair' do
			hand = Hand.new(%w(2C 4H 4C AC 5D))
			expect(hand.one_pair).to be_truthy
		end

		it 'detects two_pairs' do
			hand = Hand.new(%w(2C 4H 4C AC AD))
			expect(hand.two_pairs).to be_truthy
		end
	end

	describe '#Three_of_a_kind' do
		it 'detects 3 same cards' do
			hand = Hand.new(%w(2C 4H 4C AC 4D))
			expect(hand.three_of_a_kind).to be_truthy
		end
	end

	describe '#straight' do
		it 'detects 5 consecutives number' do
			hand = Hand.new(%w(2C 3H 6C 5C 4D))
			expect(hand.straight).to be_truthy
		end
	end

	describe '#flush' do
		it 'has 5 same type/suite cards' do
			hand = Hand.new(%w(2C JC 9C 5C AC))
			expect(hand.flush).to be_truthy
		end
	end

	describe '#full_house' do
		it 'has 3 of a kind and a pair' do
			hand = Hand.new(%w(2C 2D 9C 9D 9S))
			expect(hand.full_house).to be_truthy
		end
	end

	describe '#four_of_a_kind' do
		it 'has 4 identical numbuers' do
			hand = Hand.new(%w(2C 2D 2S 2H 9S))
			expect(hand.four_of_a_kind).to be_truthy
		end
	end

	describe '#straight_flush' do
		it 'has 5 consecutive numbers with all the same type' do
			hand = Hand.new(%w(2C 3C 6C 5C 4C))
			expect(hand.straight_flush).to be_truthy
		end
	end

	describe '#royal_flush' do
		it 'has 5 consecutive numbers with all the same type' do
			hand = Hand.new(%w(KC AC QC TC JC))
			expect(hand.royal_flush).to be_truthy
		end
	end

	describe 'comparing 2 hands' do 
		context 'just high_cards' do	
			it 'wins with high_card' do
				p1 = Hand.new(%w(2S 4D 6H AD 9C))
				p2 = Hand.new(%w(2S 4D 6H kD 9C))

				expect(p1.score).to be > p2.score
			end

			it 'wins with second high_card' do
				p1 = Hand.new(%w(2S 4D 6H AD TC))
				p2 = Hand.new(%w(2S 4D 6H AD 9C))

				expect(p1.score).to be > p2.score
			end

			it 'wins with third high_card' do
				p1 = Hand.new(%w(2S 4D 7H AD 9C))
				p2 = Hand.new(%w(2S 4D 6H AD 9C))

				expect(p1.score).to be > p2.score
			end

			it 'wins with fourth high_card' do
				p1 = Hand.new(%w(2S 5D 6H AD 9C))
				p2 = Hand.new(%w(2S 4D 6H AD 9C))

				expect(p1.score).to be > p2.score
			end

			it 'wins with fifth high_card' do
				p1 = Hand.new(%w(3S 4D 6H AD 9C))
				p2 = Hand.new(%w(2S 4D 6H AD 9C))

				expect(p1.score).to be > p2.score
			end
		end

		context 'with pairs' do
			it 'wins with a pair' do
				p1 = Hand.new(%w(3S 4D AH AD 9C))
				p2 = Hand.new(%w(2S 4D 6H AD 9C))

				expect(p1.score).to be > p2.score
			end 

			it 'wins with a same pair and third high_card' do
				p1 = Hand.new(%w(3S 4D AH AD TC))
				p2 = Hand.new(%w(2S 4D AH AD 9C))

				expect(p1.score).to be > p2.score
			end 

			it 'wins with 2 pairs' do
				p1 = Hand.new(%w(3S 3D AH AD TC))
				p2 = Hand.new(%w(2S 4D AH AD 9C))

				expect(p1.score).to be > p2.score
			end 

			it 'wins with 2 pairs and fifth high_card' do
				p1 = Hand.new(%w(3S 3D AH AD TC))
				p2 = Hand.new(%w(3S 3D AH AD 9C))
	
				expect(p1.score).to be > p2.score
			end 
		end

		context 'with three_of_a_kind' do
			it 'wins with three_of_a_kind over pairs' do
				p1 = Hand.new(%w(3S AS AH AD TC))
				p2 = Hand.new(%w(3S 3D AH AD 9C))

				expect(p1.score).to be > p2.score
			end
		end

		context 'with straight' do
			it 'wins with a straight over three_of_a_kind' do
				p1 = Hand.new(%w(3S 4S 7H 6D 5C))
				p2 = Hand.new(%w(3S AS AH AD TC))

				expect(p1.score).to be > p2.score
			end

			it 'wins with two straight but high_card' do
				p1 = Hand.new(%w(3S 4S 7H 6D 5C))
				p2 = Hand.new(%w(2S 3D 6H 4D 5C))

				expect(p1.score).to be > p2.score
			end
		end

		context 'with flush' do
			it 'wins with a flush over straight' do
				p1 = Hand.new(%w(3S TS 7S AS 5S))
				p2 = Hand.new(%w(3S 4S 7H 6D 5C))

				expect(p1.score).to be > p2.score
			end

			it 'wins with 2 flush but high_card' do
				p1 = Hand.new(%w(3S TS 7S AS 5S))
				p2 = Hand.new(%w(3C 4C TC 6C 5C))

				expect(p1.score).to be > p2.score
			end

			it 'wins with 2 flush and 2 high_card but second high_card' do
				p1 = Hand.new(%w(3S TS 7S AS 5S))
				p2 = Hand.new(%w(3C 4C AC 6C 5C))

				expect(p1.score).to be > p2.score
			end
		end

		context 'with full_house' do
			it 'wins with full_house over flush' do
				p1 = Hand.new(%w(5C TS TS 5S 5H))
				p2 = Hand.new(%w(3C 4C AC 6C 5C))

				expect(p1.score).to be > p2.score
			end

			it 'wins with full_house over lower three_of_a_kind' do
				p1 = Hand.new(%w(6C TS TS 6S 6H))
				p2 = Hand.new(%w(5C TS TS 5S 5H))

				expect(p1.score).to be > p2.score
			end

			it 'wins with full_house over lower pair' do
				p1 = Hand.new(%w(5C JS JS 5S 5H))
				p2 = Hand.new(%w(5C TS TS 5S 5H))

				expect(p1.score).to be > p2.score
			end
		end

		context 'with four_of_a_kind' do
			it 'wins with four_of_a_kind over full_house' do
				p1 = Hand.new(%w(5C 5D JS 5S 5H))
				p2 = Hand.new(%w(5C TS TS 5S 5H))

				expect(p1.score).to be > p2.score
			end

			it 'wins with 2 four_of_a_kind but high_card' do
				p1 = Hand.new(%w(5C 5D JS 5S 5H))
				p2 = Hand.new(%w(4C 4D AS 4S 4H))

				expect(p1.score).to be > p2.score
			end
		end

		context 'with straight_flush' do
			it 'wins with straight_flush over four_of_a_kind' do
				p1 = Hand.new(%w(5C 7C 6C 8C 4C))
				p2 = Hand.new(%w(5C 5D JS 5S 5H))

				expect(p1.score).to be > p2.score
			end

			it 'wins with 2 straight_flush but high_card' do
				p1 = Hand.new(%w(5C 7C 6C 8C 4C))
				p2 = Hand.new(%w(5C 7C 6C 3C 4C))

				expect(p1.score).to be > p2.score
			end
		end

		context 'with royal_flush' do
			it 'wins with royal_flush over straight_flush' do
				p1 = Hand.new(%w(TC QC KC AC JC))
				p2 = Hand.new(%w(5C 7C 6C 8C 4C))

				expect(p1.score).to be > p2.score
			end
		end
	end

end