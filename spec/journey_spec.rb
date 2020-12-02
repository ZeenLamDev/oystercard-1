require 'journey'
require 'oystercard'


describe Journey do
  subject(:oystercard) { Oystercard.new }
  let(:station){double :station}
  shared_context 'fully topped up oystercard' do
    before do
      @balance_limit = Oystercard::BALANCE_LIMIT
      subject.top_up(@balance_limit)
    end

    describe '#in_journey?' do
      it 'is initially not in a journey' do
        expect(subject).not_to be_in_journey
      end
    end

    describe '#touch_in' do
      include_context "fully topped up oystercard"
      it 'can touch in' do
        subject.touch_in(station)
        expect(subject).to be_in_journey
      end
    end

    describe '#touch_in' do
      it 'Cant be used if it doesnt have atleast £1' do
        expect { subject.touch_in(station) }.to raise_error 'Have insufficient funds'
      end

      it 'Should allow to touch in' do
        subject.top_up(5)
        subject.touch_in(station)
        expect(subject).to be_in_journey
      end
    end

    describe '#touch_out' do
      it 'can touch out' do
        subject.top_up(50)
        subject.touch_in(station)
        subject.touch_out(station)
        expect(subject).not_to be_in_journey
      end

      it 'deducts fare when touch_out' do
        minimum_fare = Oystercard::MINIMUM_FARE
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
        expect(subject.entry_station).to eq station
      end
    end

    describe '#exit_station' do

      it 'stores the exit station' do
        subject.top_up(10)
        subject.touch_in(station)
        subject.touch_out(station)
        expect(subject.exit_station).to eq station
      end
    end

end
