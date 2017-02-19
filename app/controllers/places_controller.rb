require 'beermapping_api'

class PlacesController < ApplicationController
  def index
  end

  def show
    cache = Rails.cache.read(session[:city])
    @place = cache.find{ |place| place.id == params[:id] }
  end

  def search
    @places = BeermappingApi.places_in(params[:city])

    if @places.empty?
      redirect_to places_path, notice: "No locations in #{params[:city]}"
    else
      session[:city] = @places.first.city.downcase
      render :index
    end
  end
end