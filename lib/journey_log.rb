class Journeylog
  attr_reader :history

  def initialize(journey_class = Journey)
    @history = []
    @journey_class = journey_class

  end

  def add_entry(station)
    p "journey log" + station
    @journey = @journey_class.new
    @journey.station_entry(station)
  end

  def complete
    @entry_station != nil && @exit_station != nil ? @finished_journey = true : false
  end
  
  def add_exit(station)
    @journey.station_exit(station)
  end

  def add_journey
    @history << @journey
  end

end