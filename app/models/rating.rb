class Rating < ActiveRecord::Base
  belongs_to :beer
  belongs_to :user

  validates :score, numericality: { greater_than_or_equal_to: 1,
                                    less_than_or_equal_to: 50,
                                     only_integer: true }

  scope :recent, -> { Rating.order(:updated_at).reverse_order.first(5) }

  def to_s
    "#{beer.name}, #{score}"
  end

end
