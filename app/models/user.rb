class User < ActiveRecord::Base
  include RatingAverage

  has_secure_password

  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :memberships, dependent: :destroy
  has_many :beer_clubs, through: :memberships 

  validates :username, uniqueness: true,
                       length: { in: 3..30 }
  validates :password, length: { minimum: 4 }
  validates :password, format: { with: /([A-Z].*\d)|(\d.*[A-Z].*)/,
              message: "must include at least one lowercase letter, one uppercase letter, and one digit" }

  def favorite_beer
    return nil if ratings.empty?
    ratings.order(score: :desc).limit(1).first.beer
  end              

  def favorite_style
    return nil if ratings.empty?
    ratings.joins(:beer).order(score: :desc).group(:style).average(:score).first.first
  end

  def favorite_brewery
    return nil if ratings.empty?
    Brewery.find_by(id: ratings.joins(:beer).order(score: :desc).group(:brewery_id).average(:score).first).name
  end
end