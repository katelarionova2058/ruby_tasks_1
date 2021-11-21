class Station

attr_reader :name, :trains_on_station

  def initialize(name)
    @name = name  
    @trains_on_station = [] 
  end

  def add_trains (train)
    @trains_on_station << train
  end

  def del_trains (train)
    trains_on_station.delete(train)
  end

  def show_trains
    @trains_on_station.each { |train| puts train.name }
  end

  def number_pass
    @trains_on_station.each { |train| puts train.type }
  end

  def return_type(type)
    @count_of_type = @trains_on_station.select { |train| train.type == type }
    @count_of_type.count
  end

end



class Train

attr_accessor :num
attr_reader :name, :type, :num , :num_station,  :num

  def initialize(name, type , num_cars)
    @name = name
    @type = type
    @num_cars = num_cars
    @speed = 0
    
  end

  def stop
    @speed = 0
  end


  def set_speed (value)
    @speed += value if value.positive?
  end

  def current_speed
    puts "Current speed: #{@speed}" 
  end

  def number_of_cars
    @num_cars 
  end

  def add_cars
    @num_cars += 1 if @speed.zero?
  end

  def del_cars
    @num_cars -= 1 if @current_speed.zero? && @num_cars.positive?
  end


  def add_route(routes)
    @route = routes #объект класса маршрут
    @current_station = @route.stations.first
    @current_station.add_trains(self)
  end

  def forward(routes)
    @route = routes
    current_index = @route.stations.find_index(@current_station)
    return unless current_index + 1 < @route.stations.count
    @current_station.del_trains(self)
    @current_station = @route.stations[current_index + 1]
    @current_station.add_trains(self)
  end

  def back (routes)
   @route = routes
    current_index = @route.stations.find_index(@current_station)
    return unless current_index - 1 > 0
    @current_station.del_trains(self)
    @current_station = @route.stations[current_index - 1]
    @current_station.add_trains(self)
  end

  def info_of_station (route)
    @route = route
    current_index = @route.stations.find_index(@current_station)
    @current_station.name
    @back_station = @route.stations[current_index - 1] if (current_index - 1) >=0 
    @back_station.name
    @forward_station = @route.stations[current_index + 1] if (current_index + 1) <= @route.stations.count
    @forward_station.name
  end

end 




class Route
attr_accessor :stations  
attr_reader :st_first, :st_last , :stations 

  def initialize (st_first, st_last)
    @stations  = [st_first, st_last]
  end

  def add_station (station)
    @stations.insert(-2, station) unless @stations.include? station
  end

  def show_stations
    @stations.each { |station| puts station.name }
  end

  def del_stations (station)
  return unless (@station.first || @stations.last) != station
  @stations.delete(station)
  end

end

st1 = Station.new "One"
st2 = Station.new "Two"
st3 = Station.new "Three"
st4 = Station.new "Four"

tr1 = Train.new "aaaa" , "pass", 16
tr2 = Train.new "bbbb" , "cargo", 16
tr3 = Train.new "cccc" , "pass", 16
tr4 = Train.new "dddd" , "pass", 16

route = Route.new st1, st4

route.add_station(st2)
route.add_station(st3)
route.show_stations
puts "______"
#route.del_stations(st2)
#route.show_stations.to_a
tr1.add_route(route)
tr2.add_route(route)
tr3.add_route(route)
tr4.add_route(route)

#st1.show_trains
#puts "______"
tr1.forward(route)
#st1.show_trains
#st2.show_trains
#puts "______"
#tr1.forward(route)
#st3.show_trains 
#puts "______"
#tr1.back(route)
#st2.show_trains 
puts st1.return_type("cargo")
tr1.info_of_station (route) 