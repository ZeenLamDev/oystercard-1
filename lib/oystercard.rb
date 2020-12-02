class Oystercard

  attr_reader :balance, :entry_station, :exit_station, :history

  BALANCE_LIMIT = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @entry_station = entry_station
    @exit_station = exit_station
    @history = []
  end

  def top_up(amount)
    fail "Can't exceed the limit of £#{BALANCE_LIMIT}" if @balance + amount > BALANCE_LIMIT

    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in(station)
    fail "Have insufficient funds" if @balance < MINIMUM_FARE

    @entry_station = station
  end

  def touch_out(station)
    deduct_fare(MINIMUM_FARE)

    @exit_station = station
    add_to_history
    @entry_station = nil
  end

  def in_journey?
    !!entry_station
  end

  def add_to_history
    @history << {entry_station: @entry_station, exit_station: @exit_station}
  end

  private

  def deduct_fare(fare = MINIMUM_FARE)
    @balance -= fare
  end

end
