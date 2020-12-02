class Journey

  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  attr_accessor :entry_station, :exit_station, :complete

  def initialize
    @entry_station = nil
    @exit_station = nil
    @complete = false
  end

  def fare
    complete? ? MINIMUM_FARE : PENALTY_FARE
  end

  def complete?
    if @entry_station != nil && @exit_station != nil 
     true
    else
      false
    end
  end

  def finish
    @complete = true
  end

  def completed_journey
    {:entry_station => entry_station, :exit_station => exit_station}
  end

end
