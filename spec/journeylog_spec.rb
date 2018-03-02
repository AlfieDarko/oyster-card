require './lib/journeylog.rb'

describe JourneyLog do
  let(:fake_entry_station) { double }
  let(:fake_exit_station) { double }

  describe '#start' do
    it 'should start a journey with an entry station' do
      subject.start(:fake_entry_station)
      expect(subject.journey_class.journeys).to eq([{ entry_station: :fake_entry_station }])
    end
  end

  describe '#finish' do
    it 'should end a journey with an exit station' do
      subject.start(:fake_entry_station)
      subject.finish(:fake_exit_station)
      expect(subject.journey_class.journeys).to eq([{ entry_station: :fake_entry_station, exit_station: :fake_exit_station }])
    end
  end

  describe '#journeys' do
    it 'should return the journeys' do
      expect(subject.journeys).to eq []
    end
  end
end
