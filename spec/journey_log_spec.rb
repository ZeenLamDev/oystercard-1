require './lib/journey_log'

describe Journeylog do
  let(:journey){ double :journey }
  let(:journey_class) { double :journey_class, new: journey }
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

  describe '#add_exit' do
    it "adds an exit station to a journey" do
      expect(journey_class).to receive(:new)
      expect(journey).to receive(:station_entry).with(station_1)
      expect(journey).to receive(:station_exit).with(station_2)
      allow(journey).to receive(:full_journey)
      subject.add_entry(station_1)
      subject.add_exit(station_2)
    end
  end

  describe "#add_journey" do
    it "adds a journey to the history" do
      expect(journey_class).to receive(:new)
      expect(journey).to receive(:station_entry).with(station_1)
      allow(journey).to receive(:full_journey) { journey }
      subject.add_entry(station_1)
      subject.add_journey
      expect(subject.history).to include(journey)
    end
  end

end
