require 'oystercard'
require 'journey'

describe Oystercard do
  let(:journey) { double :journey, fare: 5, complete: true }
  let(:journeylog) { double :journeylog, journey: journey, history: [journey] }
  let(:journeylog_class) { double :journeylog_class, new: journeylog }
  let(:station) {double :station}
  subject {described_class.new(journeylog_class)}

  shared_context 'fully topped up oystercard' do
    before do
      @balance_limit = Oystercard::BALANCE_LIMIT
      subject.top_up(@balance_limit)
    end
  end

  it "Should be an instance of the Oystercard class" do
    expect(subject).to be_instance_of Oystercard
  end

  describe '#balance' do
    it "Checks if the new card has a 0 balance" do
      expect(subject.balance).to eq 0
    end
  end

  describe '#top_up' do
    it 'should add amount to balance' do
      expect{ subject.top_up(5) }.to change{ subject.balance }.by 5
    end
  end

  describe '#top_up with full card' do
    include_context "fully topped up oystercard"

    it 'Throws an exception if balance limit is exceeded' do
      expect{ subject.top_up(1) }.to raise_error "Can't exceed the limit of £#{@balance_limit}"
    end
 end
  
  describe '#touch_in' do
    include_context "fully topped up oystercard"
    it 'can touch in' do
      expect(journeylog).to receive(:add_entry).with(station)
      subject.touch_in(station)
    end

    it "charges a penalty fare if user hasn't touched out from previous trip" do
      allow(journeylog).to receive(:add_entry).with(station)
      allow(journey).to receive(:complete) { false }
      allow(journey).to receive(:fare) { Journey::PENALTY_FARE }
      subject.touch_in(station)
      expect{ subject.touch_in(station) }.to change{ subject.balance }.by(-Journey::PENALTY_FARE)
    end
  end
  
  describe '#touch_in' do
    it 'Cant be used if it doesnt have atleast £1' do
      expect { subject.touch_in(station) }.to raise_error 'Have insufficient funds'
    end
  end
  
  describe '#touch_out' do
    it 'can touch out' do
      expect(journeylog).to receive(:add_exit).with(station)
      subject.touch_out(station)
    end

    it 'deducts fare when touch_out' do
      allow(journeylog).to receive(:add_exit).with(station)
      subject.top_up(10)
      expect{ subject.touch_out(station) }.to change{ subject.balance }.by(-5)
    end
  end
end