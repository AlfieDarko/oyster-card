class Journey
  attr_accessor :journeys

  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  def initialize
    @journeys = []
  end

  def add_entry(station)
    @journeys << { entry_station: station.name, entry_zone: station.zone }
  end

  def add_exit(station)
    @journeys.last[:exit_station] = station.name
    @journeys.last[:exit_zone] = station.zone
  end

  def fare
    regular_fare + (@journeys.last[:entry_zone] - @journeys.last[:exit_zone]).to_i.abs
  end

  def in_journey?
    @journeys.last[:entry_station] != nil
  end

  private

  def regular_fare
    if @journeys[-1].key?(:entry_station) && @journeys[-1].key?(:exit_station)
      MINIMUM_FARE
    else
      PENALTY_FARE
    end
   end
end
