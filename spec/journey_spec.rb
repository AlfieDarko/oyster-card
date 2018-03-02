require 'journey'

describe Journey do
  let(:fake_entry_station) { double :fake_entry_station, name: :fake_entry_station, zone: 3 }
  let(:fake_exit_station) { double :fake_exit_station, name: :fake_exit_station, zone: 5 }

  it 'adds station name and zone' do
    subject.add_entry(fake_entry_station)
    expect(subject.journeys).to eq([{ entry_station: :fake_entry_station, entry_zone: 3 }])
  end

  it 'adds exit station name and zone' do
    subject.add_entry(fake_entry_station)
    subject.add_exit(fake_exit_station)
    expect(subject.journeys).to eq([{ entry_station: :fake_entry_station, entry_zone: 3, exit_station: :fake_exit_station, exit_zone: 5 }])
  end

  describe '#fare' do
    it 'calculates the correct fare in the same zone' do
      subject.add_entry(fake_entry_station)
      subject.add_exit(fake_entry_station)
      expect(subject.fare).to eq 1
    end

    it 'calculates the correct fare in different zones' do
      subject.add_entry(fake_entry_station)
      subject.add_exit(fake_exit_station)
      expect(subject.fare).to eq 3
    end
  end
end
