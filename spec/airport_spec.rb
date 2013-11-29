require 'airport'

# A plane currently in the airport can be requested to take off.
#
# No more planes can be added to the airport, if it's full.
# It is up to you how many planes can land in the airport and how that is impermented.
#
# If the airport is full then no planes can land
describe Airport do

  let(:airport) { Airport.new }
  let(:single_capacity_airport) { Airport.new(capacity: 1) }
  let(:plane) { double(:plane) }

  context 'traffic control' do
    it 'should know how many planes it has' do
      expect(airport.plane_count).to eq(0)
    end

    it 'should have one more plane after a plane has landed' do
      airport.stub(:weather_ok?) {true}
      planes_before = airport.plane_count
      plane = double(:plane)
      airport.arrival(plane)
      expect(airport.plane_count - planes_before).to eq(1)
    end

    it 'should have one less plane after a plane has taken off' do
      airport.stub(:weather_ok?) {true}
      plane = double(:plane)
      airport.arrival(plane)
      planes_before = airport.plane_count
      airport.departure(plane)
      expect(planes_before - airport.plane_count).to eq(1)
    end

    it 'cannot land a plane if it is full' do
      airport.stub(:weather_ok?) {true}
      single_capacity_airport.arrival(plane)
      planes_before = single_capacity_airport.plane_count
      single_capacity_airport.arrival(plane)
      expect(single_capacity_airport.plane_count).to eq(planes_before)
    end

  end # of context


  # Include a weather condition using a module.
  # The weather must be random and only have two states "sunny" or "stormy".
  # Try and take off a plane, but if the weather is stormy, the plane can not take off and must remain in the airport.
  #
  # This will require stubbing to stop the random return of the weather.
  # If the airport has a weather condition of stormy,
  # the plane can not land, and must not be in the airport
  context 'weather:' do
    it 'should know whether the weather is ok or not' do
      expect(airport.weather_ok?.class).to eq(TrueClass || FalseClass)
    end

    it 'cannot have a plane takeoff in a storm' do
      airport.arrival(plane)
      planes_before = airport.plane_count
      airport.stub(:weather_ok?) {false}
      airport.departure(plane)
      expect(airport.plane_count).to eq(planes_before)
    end

    it 'cannot land a plane in a storm' do
      planes_before = airport.plane_count
      plane = double(:plane)
      airport.stub(:weather_ok?) {false}
      airport.arrival(plane)
      expect(airport.plane_count).to eq(planes_before)
    end
  end # of context

end # of describe

# grand final
# Given 6 planes, each plane must land. When the airport is full, every plane must take off again.
# Be careful of the weather, it could be stormy!
# Check when all the planes have landed that they have the right status "landed"
# Once all the planes are in the air again, check that they have the status of flying!


# describe "The gand finale (last spec)" do
#   it 'all planes can land and all planes can take off' do
#   end
# end
