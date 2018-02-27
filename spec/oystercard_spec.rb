require 'oystercard'
require 'journey'

describe Oystercard do
  maximum_balance = Oystercard::MAXIMUM_BALANCE
  minimum_fare = Oystercard::MINIMUM_FARE
  let(:fake_entry_station) { double }
  let(:fake_exit_station) { double }

  it 'has a balance of zero' do
    expect(subject.balance).to eq(0)
  end

  describe '#top_up' do
    it 'responds to top_up method' do
      expect(subject).to respond_to(:top_up).with(1).argument
    end
  end

  it 'top up the balance' do
    expect { subject.top_up(1) }.to change { subject.balance }.by(1)
  end
  it 'raise an error when try to top_up more then balance limit' do
    subject.top_up(maximum_balance)
    expect { subject.top_up 1 }.to raise_error " Maximum balance of #{maximum_balance} exceeded "
  end

  describe '#touch_in' do
    it 'responds to touch_in' do
      expect(subject).to respond_to(:touch_in)
    end
    it 'shows the status when you touch in' do
      subject.top_up(minimum_fare)
      subject.touch_in(fake_entry_station)
      expect(subject).to be_in_journey
    end
    it 'checking minimum balance on touch in' do
      expect { subject.touch_in(fake_entry_station) }.to raise_error 'you dont have enough credit'
    end

    it 'saves entry station to a variable' do
      subject.top_up(50)
      subject.touch_in(fake_entry_station)
      expect(subject.entry_station).to eq(fake_entry_station)
    end
  end

  describe '#touch_out' do
    it 'responds to touch_out' do
      expect(subject).to respond_to(:touch_out)
    end
    it 'shows the status when you touch_out' do
      subject.top_up(minimum_fare)
      subject.touch_in(fake_entry_station)
      subject.touch_out(fake_exit_station)
      expect(subject).not_to be_in_journey
    end
    it 'charging for the journey' do
      subject.top_up(50)
      subject.touch_in(fake_entry_station)
      expect { subject.touch_out(fake_exit_station) }.to change { subject.balance }.by(-minimum_fare)
    end

    it 'makes entry_station eq to nil' do
      subject.top_up(50)
      subject.touch_in(fake_entry_station)
      subject.touch_out(fake_exit_station)
      expect(subject.entry_station).to eq(nil)
    end
  end

  describe '#in_journey?' do
    it 'responds to in_journey?' do
      expect(subject).to respond_to(:in_journey?)
    end
    it 'shows the status when you are in journey' do
      subject.top_up(minimum_fare)
      subject.touch_in(fake_entry_station)
      expect(subject.in_journey?).to eq(true)
    end
    it 'shows the status when you are not in journey' do
      subject.top_up(50)
      subject.touch_in(fake_entry_station)
      subject.touch_out(fake_exit_station)
      expect(subject.in_journey?).to eq(false)
    end
  end

  describe '#journeys' do
    it "checks if journeys is empty at the start" do
      expect(subject.journeys).to eq([])
    end

    it "records journeys inside a hash" do
      subject.top_up(50)
      subject.touch_in(fake_entry_station)
      subject.touch_out(fake_exit_station)
      expect(subject.journeys).to eq( [ { entry_station: fake_entry_station, exit_station: fake_exit_station } ] )
    end
  end
end
