require './lib/station'

describe Station do
  let(:station){Station.new("angel", 2)}

  it { expect(station).to be_instance_of(Station) }
end