require 'airport'
require 'plane'

# grand final
# Given 6 planes, each plane must land. When the airport is full, every plane must take off again.
# Be careful of the weather, it could be stormy!
# Check when all the planes have landed that they have the right status "landed"
# Once all the planes are in the air again, check that they have the status of flying!

describe Airport do

  let(:airport) { Airport.new(capacity: 6) }
  let(:p1) { Plane.new }
  let(:p2) { Plane.new }
  let(:p3) { Plane.new }
  let(:p4) { Plane.new }
  let(:p5) { Plane.new }
  let(:p6) { Plane.new }
  let(:planes) {[p1,p2,p3,p4,p5,p6]}

  def land_all_planes
    loop do
      planes.each do |plane|
        plane.permission_to_land(airport)
      end
      break if airport.plane_count == 6
    end
  end

  context "integration test" do
    it 'can land all planes' do
      land_all_planes
      planes.each { |plane| expect(plane).not_to be_airborne }
    end

    it 'can have all planes take off once airport is full' do
      land_all_planes
      take_off_all_planes
      planes.each { |plane| expect(plane).to be_airborne }
    end


    def land_all_planes
      loop do
        planes.each do |plane|
          plane.permission_to_land(airport)
        end
        break if airport.plane_count == 6
      end
    end

    def take_off_all_planes
      loop do
        planes.each do |plane|
          plane.permission_to_takeoff(airport)
        end
        break if airport.plane_count == 0
      end
    end

  end # of context

end # of describe
