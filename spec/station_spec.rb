require 'station'

describe Station do
  it 'checks whether Station name has been set on init' do
    station1 = Station.new('Aldgate', 3)
    expect(station1.name).to eq 'Aldgate'
  end

  it 'checks whether Station zone has been set on init' do
    station2 = Station.new('Aldgate', 3)
    expect(station2.zone).to eq 3
  end
end
