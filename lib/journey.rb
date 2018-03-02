class Journey
  attr_accessor :journeys

  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  def initialize
    @journeys = []
  end

  def add_entry(station)
    @journeys.push(entry_station: station)
  end

  def add_exit(station)
    @journeys.last[:exit_station] = station
  end

  def fare
    if @journeys[-1].key?(:entry_station) && @journeys[-1].key?(:exit_station)
      MINIMUM_FARE
    else
      PENALTY_FARE
    end
  end

  def in_journey?
    @journeys.last[:entry_station] != nil
  end
end
