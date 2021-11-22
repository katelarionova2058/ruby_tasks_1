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

  def return_type(type)
    count_of_type = @trains_on_station.select { |train| train.type == type }
    count_of_type.count
  end

end



class Train

attr_reader :name, :type, :num , :num_station

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
    @speed 
  end

  def number_of_cars
    @num_cars 
  end

  def add_cars
    @num_cars += 1 if @speed.zero?
  end

  def del_cars
    @num_cars -= 1 if @speed.zero? && @num_cars.positive?
  end


  def add_route(routes)
    @route = routes #объект класса маршрут
    @current_station = @route.stations.first
    @current_station.add_trains(self)
  end

def info_of_station_current 
    @current_station
  end

  def info_of_station_back
    current_index = @route.stations.find_index(@current_station)
    @back_station = @route.stations[current_index -1] if (current_index - 1) >= 0
    @back_station
  end

  def info_of_station_next
    current_index = @route.stations.find_index(@current_station)
    @next_station = @route.stations[current_index +1] if (current_index +1) <= @route.stations.count
    @next_station
  end

 def next
    self.info_of_station_next
    @current_station.del_trains(self)
    @next_station.add_trains(self)
    @current_station = @next_station
  end

  def back 
    self.info_of_station_back
    @current_station.del_trains(self)
    @back_station.add_trains(self)
    @current_station = @back_station
  end
end 

class Route
attr_accessor :stations  
attr_reader :stations 

  def initialize (st_first, st_last)
    @stations  = [st_first, st_last]
  end

  def add_station (station)
    @stations.insert(-2, station) unless @stations.include? station
  end

  def del_stations (station)
  return unless (@stations.first || @stations.last) != station
  @stations.delete(station)
  end

end
