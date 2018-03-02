require './lib/journey.rb'

class Oystercard
  attr_accessor :balance, :journeys, :entry_station, :exit_station
  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1
  PENALTY_FARE = 6
  def initialize(journey = Journey.new)
    @exit_station = nil
    @journey = journey
    @journeys = @journey.journeys
    @entry_station = nil
    @balance = 0
  end

  def top_up(amount)
    raise " Maximum balance of #{MAXIMUM_BALANCE} exceeded " if @balance + amount > MAXIMUM_BALANCE
    @balance += amount
  end

  def touch_in(station)
    raise 'you dont have enough credit' if @balance < MINIMUM_FARE
    @entry_station = station
    @journey.add_entry(station)
  end

  def touch_out(station)
    @journey.add_exit(station)
    deduct
    @entry_station = nil
  end

  private

  def deduct
    @balance -= @journey.fare
  end
end
