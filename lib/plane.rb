class Plane


  def initialize
    @flying = true
  end

  def airborne?
    @flying
  end

  def permission_to_takeoff(airport)
    @flying = true if airport.departure(self)
  end

  def permission_to_land(airport)
    @flying = false if airport.arrival(self)
  end

end # of class
