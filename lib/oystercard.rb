class Oyestercard
  attr_accessor :balance, :journeys, :entry_station, :exit_station
  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1

  def initialize
    @exit_station = nil
    @journeys = []
    @entry_station = nil
    @balance = 0
  end

  def top_up(amount)
    raise " Maximum balance of #{MAXIMUM_BALANCE} exceeded " if @balance + amount > MAXIMUM_BALANCE
    @balance += amount
  end

  def touch_in(station)
    @entry_station = station
    raise 'you dont have enough credit' if @balance < MINIMUM_FARE
  end

  def touch_out(station)
    @exit_station = station
    @journeys.push(entry_station: @entry_station, exit_station: @exit_station)
    @exit_station, @entry_station = nil
    deduct(MINIMUM_FARE)
  end

  def in_journey?
    @entry_station != nil
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
