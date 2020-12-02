
class Journey

  attr_reader :entry_station, :exit_station

  def initialize
    @entry_station = entry_station
    @exit_station = exit_station
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
