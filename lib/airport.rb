require 'weather'

class Airport

  include Weather

  def initialize(args = {})
    @capacity = args[:capacity] || 100
    @planes = []
  end

  def plane_count
    @planes.count
  end

  def arrival(plane)
    return if full? || !weather_ok?
    @planes << plane
  end

  def departure(plane)
    return if !weather_ok?
    @planes.delete(plane)
  end

  def full?
    plane_count == @capacity
  end

end # of class
