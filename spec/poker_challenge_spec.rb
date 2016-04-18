require './poker_challenge'

describe 'Hand' do

	describe '#high_card' do
		it 'shows the highest card' do
			hand = Hand.new(%w(2S 4D 6H AD 9C))
			expect(hand.high_card).to eq(14)
		end

		it 'shows the highest pairs' do
			hand = Hand.new(%w(2S 9D 2H AD 9C))
			expect(hand.high_card).to eq(9)
			expect(hand.high_card).not_to eq(2)
		end
	end

	describe '#one_pair and two_pairs' do
		it 'detects one pair' do
			hand = Hand.new(%w(2C 4H 4C AC 5D))
			expect(hand.one_pair).to eq(2)
		end

		it 'detects two_pairs' do
			hand = Hand.new(%w(2C 4H 4C AC AD))
			expect(hand.two_pairs).to eq(3)
		end
	end

	describe '#Three_of_a_kind' do
		it 'detects 3 same cards' do
			hand = Hand.new(%w(2C 4H 4C AC 4D))
			expect(hand.three_of_a_kind).to eq(4)
		end
	end

	describe '#straight' do
		it 'detects 5 consecutives number' do
			hand = Hand.new(%w(2C 3H 6C 5C 4D))
			expect(hand.straight).to eq(5)
		end
	end

	describe '#flush' do
		it 'has 5 same type/suite cards' do
			hand = Hand.new(%w(2C JC 9C 5C AC))
			expect(hand.flush).to eq(6)
		end
	end

end