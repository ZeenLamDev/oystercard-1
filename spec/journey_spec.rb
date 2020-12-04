require './lib/journey'

describe Journey do
  let(:station){double :station}

  describe "#fare" do
    it 'charges penalty fare' do
      expect(subject.fare).to eq Journey::PENALTY_FARE
    end

    it 'charges minimum fare' do
      allow(subject).to receive(:complete) { true }
      expect(subject.fare).to eq Journey::MINIMUM_FARE
    end

    it 'charges penalty fare when user didnt touch in but touched out' do
      subject.station_exit(station)
      expect(subject.fare).to eq Journey::PENALTY_FARE
    end
    
    it 'charges penalty fare when user didnt touch out but touched in' do
      subject.station_entry(station)
      expect(subject.fare).to eq Journey::PENALTY_FARE
    end
  end

end
