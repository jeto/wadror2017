class Brewery < ActiveRecord::Base
    include RatingAverage
    has_many :beers, dependent: :destroy
    has_many :ratings, through: :beers

    validates :name, presence: true
    validates :year, numericality: { greater_than_or_equal_to: 1042,
                                     less_than_or_equal_to: ->(_brewery){ Date.current.year },
                                     only_integer: true }

    def print_report
      puts name
      puts "established at year #{year}"
      puts "number of beers #{beers.count}"
    end

    def restart
      self.year = 2017
      puts "changed year to #{year}"
    end

    def average_rating
      ratingsmap = ratings.map { |rating| rating.score }
      ratingssum = ratingsmap.reduce(:+)
      ratingssum / ratings.count.to_f
    end

    def to_s
      name
    end
end