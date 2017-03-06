class User < ActiveRecord::Base
  include RatingAverage

  has_secure_password validations: false
  validates_presence_of :password, on: :create, unless: :oauth?

  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :memberships, -> { where confirmed:true }, dependent: :destroy
  has_many :beer_clubs, through: :memberships 
  has_many :applications, -> { where confirmed:[nil, false] }, class_name: 'Membership', dependent: :destroy
  has_many :applied_beer_clubs, through: :memberships, source: :beer_club

  validates :username, uniqueness: true,
                       length: { in: 3..30 }, unless: :oauth?
  validates :password, length: { minimum: 4 }, unless: :oauth?
  validates :password, format: { with: /([A-Z].*\d)|(\d.*[A-Z].*)/,
              message: "must include at least one lowercase letter, one uppercase letter, and one digit" }, unless: :oauth?

  def favorite_beer
    return nil if ratings.empty?
    ratings.order(score: :desc).limit(1).first.beer
  end              

  def favorite_brewery
    return nil if ratings.empty? 
    
    ratings_of_breweries = ratings.group_by { |r| r.beer.brewery }
    averages_of_breweries = []
    ratings_of_breweries.each do |brewery, ratings|
      averages_of_breweries << {
        brewery: brewery,
        rating: ratings.map(&:score).sum / ratings.count.to_f
      }
    end  
    averages_of_breweries.sort_by{ |b| -b[:rating] }.first[:brewery]
  end  

  def favorite_style
    return nil if ratings.empty? 
    
    ratings_of_styles = ratings.group_by { |r| r.beer.style }
    averages_of_styles = []
    ratings_of_styles.each do |style, ratings|
      averages_of_styles << {
        style: style,
        rating: ratings.map(&:score).sum / ratings.count.to_f
      }
    end  
    averages_of_styles.sort_by{ |b| -b[:rating] }.first[:style]
  end 

  def self.top(n)
    sorted_by_ratings_in_desc_order = User.all.sort_by{ |u| -(u.ratings.count||0)}
    sorted_by_ratings_in_desc_order.first(n)
  end

end