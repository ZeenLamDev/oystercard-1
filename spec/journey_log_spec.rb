require './lib/journey_log'

describe Journeylog do
<<<<<<< HEAD
  let(:journey){ double :journey }
  let(:journey_class) { double :journey_class, new: journey } # evaluates to a hash for some reason?
  let(:station_1) { double :station_1 }
  let(:station_2) { double :station_2 }
  subject {described_class.new(journey_class)}
=======
  let(:journey){ double }
  let(:journey_class) { double :journey_class, new: journey } # evaluates to a hash for some reason?
  let(:station_1) { double }
  let(:station_2) { double }
  subject {described_class.new(journey_class: journey_class)}

  # describe '#add journey' do
  #   it 'adds journey to history' do
  #     journey_log = Journeylog.new(journey)
  #     journey_log.add_journey
  #     expect(journey_log.history).to include(journey)
  #   end 
  # end
>>>>>>> 60e4f8fdbef029de2a7aa41342294c01cce09383

  describe '#add_entry' do
    it "starts a journey" do
      expect(journey_class).to receive(:new)
<<<<<<< HEAD
      expect(journey).to receive(:station_entry).with(station_1)
=======
>>>>>>> 60e4f8fdbef029de2a7aa41342294c01cce09383
      subject.add_entry(station_1)
    end
  end

end