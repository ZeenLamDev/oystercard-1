require './lib/journey_log'

describe Journeylog do
  let(:journey){double}
  describe '#add journey' do
    it 'adds journey to history' do
      journey_log = Journeylog.new(journey)
      journey_log.add_journey
      expect(journey_log.history).to include(journey)
    end 
  end
end