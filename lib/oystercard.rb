class Oystercard
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
    @journeys.push(entry_station: station)
  end

  def touch_out(station)
    deduct(MINIMUM_FARE)
    @journeys.last[:exit_station] = station
    @entry_station = nil
  end

  def in_journey?
    @entry_station != nil
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
