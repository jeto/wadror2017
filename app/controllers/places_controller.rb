require 'beermapping_api'

class PlacesController < ApplicationController
  def index
  end

  def show
    cache = Rails.cache.read(session[:city])
    @place = cache.find{ |place| place.id == params[:id] }
  end

  def search
    city = params[:city]
    @places = BeermappingApi.places_in(city)
    @weather = WeatherService.weather_for(city)

    if @places.empty?
      redirect_to places_path, notice: "No locations in #{city}"
    else
      session[:city] = @places.first.city.downcase
      render :index
    end
  end
end