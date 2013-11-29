require 'plane'

# When we create a new plane, it should have a "flying" status, thus planes can not be created in the airport.
#
# When we land a plane at the airport, the plane in question should have its status changed to "landed"
#
# When the plane takes of from the airport, the plane's status should become "flying"
describe Plane do
  let(:plane) { Plane.new }

  it 'should know when it is airborne' do
    expect(plane.airborne?.class).to eq(TrueClass || FalseClass)
  end

  it 'has a flying status when created' do
    expect(plane).to be_airborne
  end

  it 'is airborne after taking off' do
    airport = double(:airport, {departure: plane})
    plane.permission_to_takeoff(airport)
    expect(plane).to be_airborne
  end

  it 'is not airborne after landing' do
    airport = double(:airport, {arrival: plane})
    plane.permission_to_land(airport)
    expect(plane).not_to be_airborne
  end

end # of describe
