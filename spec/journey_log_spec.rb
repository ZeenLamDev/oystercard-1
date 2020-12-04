require './lib/journey_log'

describe Journeylog do
  let(:journey){ double :journey }
  let(:journey_class) { double :journey_class, new: journey } # evaluates to a hash for some reason?
  let(:station_1) { double :station_1 }
  let(:station_2) { double :station_2 }
  subject {described_class.new(journey_class)}

  describe '#add_entry' do
    it "starts a journey" do
      expect(journey_class).to receive(:new)
      expect(journey).to receive(:station_entry).with(station_1)
      subject.add_entry(station_1)
    end
  end

end
