class RatingsController < ApplicationController
  before_action :skip_if_cached, only: [:index]

  def skip_if_cached
    return render :index if fragment_exist?("ratings-cache")
  end

  def index
    @ratings = Rating.all
    @top_beers = Beer.top 5
    @top_breweries = Brewery.top 5
    @top_styles = Style.top 5
    @top_users = User.top 5
  end

  def new
    @rating = Rating.new
    @beers = Beer.all
  end

  def create
    @rating = Rating.create params.require(:rating).permit(:score, :beer_id)
    
    if current_user.nil?
      redirect_to signin_path, notice:'You need to be signed in'
    elsif @rating.save 
      current_user.ratings << @rating
      redirect_to current_user
    else
      @beers = Beer.all
      render :new
    end
    #session[:last_rating] = "#{rating.beer.name} #{rating.score} points"    
  end

   def destroy
    rating = Rating.find(params[:id])
    rating.delete if current_user == rating.user
    redirect_to :back
  end



end