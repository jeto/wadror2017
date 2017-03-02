class BeerClub < ActiveRecord::Base
  has_many :memberships, -> { where confirmed:true }, dependent: :destroy
  has_many :members, through: :memberships, source: :user

  has_many :applications, -> { where confirmed:[nil, false] }, dependent: :destroy, class_name: "Membership"
end
