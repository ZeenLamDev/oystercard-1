require 'oystercard'
require 'journey'

describe Oystercard do
  let(:station){double :station}
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

  describe '#deduct' do
    it 'should deduct amount from balance' do
      subject.top_up(20)
      expect{ subject.deduct(5) }.to change{ subject.balance}.by (-5)
    end
  end
  
  describe '#touch_in' do
    include_context "fully topped up oystercard"
    it 'can touch in' do
      subject.touch_in(station)
      expect(subject.journey.complete).to eq false
    end
  end
  
  describe '#touch_in' do
    it 'Cant be used if it doesnt have atleast £1' do
      expect { subject.touch_in(station) }.to raise_error 'Have insufficient funds'
    end
  end
  
  describe '#touch_out' do
    it 'can touch out' do
      subject.top_up(50)
      subject.touch_in(station)
      subject.touch_out(station)
      expect(subject.journey.complete).to eq true
    end

    it 'deducts fare when touch_out' do
      minimum_fare = Journey::MINIMUM_FARE
      subject.top_up(10)
      subject.touch_in(station)
      subject.touch_out(station)
      expect{ subject.touch_out(station) }.to change{ subject.balance }.by(-minimum_fare)
    end
  end

  describe '#entry_station' do
  
    it 'stores the entry station' do
      subject.top_up(10)
      subject.touch_in(station)
      expect(subject.journey.entry_station).to eq station
    end
  end
  
  describe '#exit_station' do
  
    it 'stores the exit station' do
      subject.top_up(10)
      subject.touch_in(station)
      subject.touch_out(station)
      expect(subject.journey.exit_station).to eq station
    end
  end

  describe "#history" do

    it 'adds entry_station and exit_station to history' do
      subject.top_up(10)
      subject.touch_in("Piccadilly")
      subject.touch_out("Waterloo")
      subject.add_to_history
      expect(subject.history).to include({entry_station: "Piccadilly",  exit_station: "Waterloo"})
    end

    it 'returns an empty array on initialize' do
      expect(subject.history).to eq []
    end
  end

end