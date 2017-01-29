class Beer < ActiveRecord::Base
    belongs_to :brewery
    has_many :ratings, dependent: :destroy

    def to_s
      "#{name}, #{brewery.name}" 
    end

    def average_rating
      ratingsmap = ratings.map { |rating| rating.score }
      ratingssum = ratingsmap.reduce(:+)
      ratingssum / ratings.count.to_f
    end
end
