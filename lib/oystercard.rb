require './lib/journey'
require './lib/journey_log'

class Oystercard

  attr_reader :balance, :journeylog

  BALANCE_LIMIT = 90
  MINIMUM_BALANCE = 1

  def initialize
    @balance = 0
    @journeylog = Journeylog.new
  end

  def top_up(amount)
    fail "Can't exceed the limit of £#{BALANCE_LIMIT}" if @balance + amount > BALANCE_LIMIT

    @balance += amount
  end

  def touch_in(station)
    fail "Have insufficient funds" if @balance < MINIMUM_BALANCE
    @journeylog.add_entry(station)
    @journeylog
  end

  def touch_out(station)
    @journeylog.add_exit(station)
    @journeylog.add_journey
    deduct
  end

  def deduct
    @balance -= @journeylog.journey.fare
  end

  private
  def deduct_fare(fare = MINIMUM_FARE)
    @balance -= fare
  end

end

