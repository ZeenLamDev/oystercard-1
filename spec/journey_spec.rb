require './lib/journey'

describe Journey do
  let(:station){double :station}

  describe "#fare" do
    it 'charges penalty fare' do
      card = Oystercard.new
      card.top_up(15)
      subject.complete
      card.touch_in("Waterloo")
      expect(card.deduct).to eq Journey::PENALTY_FARE
    end

    it 'charges minimum fare' do
      card = Oystercard.new
      card.top_up(10)
      card.touch_in("Piccadilly")
      card.touch_out("Waterloo")
      expect(card.journey.fare).to eq Journey::MINIMUM_FARE
    end

    it 'charges penalty fare when user didnt touch in but touched out' do
      card = Oystercard.new
      card.top_up(15)
      card.touch_out(station)
      expect(card.journey.fare).to eq Journey::PENALTY_FARE
    end
    
    it 'charges penalty fare when user didnt touch in but touched out' do
      card = Oystercard.new
      card.top_up(15)
      card.touch_in(station)
      expect(card.journey.fare).to eq Journey::PENALTY_FARE
    end
  end

end
