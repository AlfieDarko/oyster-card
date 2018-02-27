class Journey
  attr_accessor :journeys
  def initialize
    @journeys = []
  end
  def add_entry(station)
    @journeys.push(entry_station: station)
  end
  def add_exit(station)
    @journeys.last[:exit_station] = station
  end
end
