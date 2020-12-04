class Journey

  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  attr_reader :entry_station, :exit_station, :finished_journey
  attr_accessor :finished_journey

  def initialize
    @entry_station = nil
    @exit_station = nil
  end

  def fare
    complete ? calculate_zones : PENALTY_FARE
  end

  def complete
    entry_station != nil && exit_station != nil ? true : false
  end

  def station_entry(station)
    @entry_station = station
  end

  def station_exit(station)
    @exit_station = station
  end
  

  def full_journey
    {:entry_station => @entry_station, :exit_station => @exit_station}
  end

  def calculate_zones
    @entry_station.zone == @exit_station.zone ? 1 : (@entry_station.zone - @exit_station.zone).abs + 1
  end

end