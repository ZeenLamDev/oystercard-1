require './lib/oystercard'

describe Journey do

  describe "#fare" do
    it 'returns penalty fare' do
      card = Oystercard.new
      card.top_up(15)
      subject.complete
      card.touch_out("Waterloo")
      expect(card.journey.fare).to eq Journey::PENALTY_FARE
    end

    it 'returns minimum fare' do
      card = Oystercard.new
      card.top_up(10)
      card.touch_in("x")
      card.touch_out("y")
      card.journey.complete
      expect(card.journey.fare).to eq Journey::MINIMUM_FARE
    end
  end

end
