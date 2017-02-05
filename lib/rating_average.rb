module RatingAverage
  extend ActiveSupport::Concern
  def average_rating
    ratingsmap = ratings.map { |rating| rating.score }
    ratingssum = ratingsmap.reduce(:+)
    ratingssum / ratings.count.to_f
  end
end