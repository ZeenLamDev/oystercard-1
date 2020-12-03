class Journey

  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  attr_accessor :entry_station, :exit_station, :finished_journey

  def initialize(entry_station = nil)
    @entry_station = entry_station
    @exit_station = exit_station
    @finished_journey = false
  end

  def fare
    complete ? MINIMUM_FARE : PENALTY_FARE
  end

  def complete
    @entry_station != nil && @exit_station != nil ? @finished_journey = true : false
  end

  def finish?
    @finished_journey
  end

end