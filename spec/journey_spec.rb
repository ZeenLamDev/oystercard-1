require './lib/journey'

describe Journey do
  let(:station_1) { double :station, zone: 1 }
  let(:station_2) { double :station, zone: 2 }
  let(:station_6) { double :station, zone: 6 }

  describe "#fare" do
    it 'charges penalty fare' do
      expect(subject.fare).to eq Journey::PENALTY_FARE
    end

    it 'charges correct fare' do
      subject.station_entry(station_1)
      subject.station_exit(station_1)
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
      subject.station_entry(station_1)
      subject.station_exit(station_1)
      expect(subject.calculate_zones).to eq 1
    end

    it "calculates a fare with a difference of 1 zone" do
      subject.station_entry(station_1)
      subject.station_exit(station_2)
      expect(subject.calculate_zones).to eq 2
    end

    it "calculates a fare with a difference of 4 zones" do
      subject.station_entry(station_6)
      subject.station_exit(station_2)
      expect(subject.calculate_zones).to eq 5
    end

    it "works when going from a lower to a higher zone" do
      subject.station_entry(station_2)
      subject.station_exit(station_6)
      expect(subject.calculate_zones).to eq 5
    end
  end

end
