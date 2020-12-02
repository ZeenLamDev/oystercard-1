require 'journey'
require 'oystercard'


describe Journey do
  describe "#fare" do
    it 'returns penalty fare' do
      subject.complete?
      expect(subject.fare).to eq 6
    end

    it 'returns minimum fare' do
      card = Oystercard.new
      card.top_up(10)
      card.touch_in("water")
      card.touch_out("banana")
      expect(subject.complete?).to eq true
    end
  end

end
