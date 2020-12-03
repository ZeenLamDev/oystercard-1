class Journeylog
  attr_reader :history, :journey

  def initialize(journey_class = Journey)
    @history = []
    @journey_class = journey_class
  end

  def add_entry(station)
    @journey = @journey_class.new
    @journey.station_entry(station)
  end
  
  def add_exit(station)
    @journey.station_exit(station)
  end

  def add_journey
    @history << @journey
  end

end
