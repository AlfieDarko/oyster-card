require './lib/journey.rb'

class JourneyLog
  attr_reader :journey_class

  def initialize(journey_class = Journey.new)
    @journey_class = journey_class
  end

  def start(station)
    @journey_class.add_entry(station)
  end

  def finish(station)
    @journey_class.add_exit(station)
  end

  def journeys
    @journey_class.journeys
  end
end
