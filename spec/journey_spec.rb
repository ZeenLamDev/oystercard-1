require './lib/journey'

describe Journey do
  let(:station_1) { double :station, zone: 1 }

  describe "#fare" do
    it 'charges penalty fare' do
      expect(subject.fare).to eq Journey::PENALTY_FARE
    end

    it 'charges minimum fare' do
      allow(subject).to receive(:complete) { true }
      expect(subject.fare).to eq Journey::MINIMUM_FARE
    end

    it 'charges penalty fare when user didnt touch in but touched out' do
      subject.station_exit(station_1)
      expect(subject.fare).to eq Journey::PENALTY_FARE
    end
    
    it 'charges penalty fare when user didnt touch out but touched in' do
      subject.station_entry(station_1)
      expect(subject.fare).to eq Journey::PENALTY_FARE
    end
  end

  describe "#calculate_zones" do
    it "calculates a fare within the same zone" do
      expect(subject.calculate_zones(station_1, station_1)).to eq 1
    end
  end

end
