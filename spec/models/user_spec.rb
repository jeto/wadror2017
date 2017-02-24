require 'rails_helper'

include Helpers

RSpec.describe User, type: :model do
  it "has the username set correctly" do
    user = User.new username:"Pekka"

    expect(user.username).to eq("Pekka")
  end 

  it "is not saved without a password" do
    user = User.create username:"Pekka"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  it "is not saved with improper password" do
    user = User.create username:"Pekka", password:"salasana", password_confirmation:"salasana"
    
    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  describe "with a proper password" do
    let(:user){ FactoryGirl.create(:user) }

    it "is saved" do
      expect(user).to be_valid
      expect(User.count).to eq(1)
    end

    it "and with two ratings, has the corret average rating" do
      user.ratings << FactoryGirl.create(:rating)
      user.ratings << FactoryGirl.create(:rating2)

      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)
    end
  end 

  describe "favorite beer" do
    let(:user){ FactoryGirl.create(:user) }
    let(:style){ FactoryGirl.create(:style) }

    it "has method for determining one" do
      expect(user).to respond_to(:favorite_beer)
    end

    it "without ratings does not have one" do
      expect(user.favorite_beer).to eq(nil)
    end

    it "is the only rated if only one rating" do
      beer = FactoryGirl.create(:beer)
      rating = FactoryGirl.create(:rating, beer:beer, user:user)

      expect(user.favorite_beer).to eq(beer)
    end

    it "is the one with highest rating if several rated" do
      best = create_beer_with_rating(FactoryGirl.create(:brewery), style, user, 25)
      create_beers_with_ratings(FactoryGirl.create(:brewery),  style, user, 10, 20, 15, 7, 9)

      expect(user.favorite_beer).to eq(best)
    end
  end

  describe "favorite style" do
    let(:user){ FactoryGirl.create(:user) }
    let(:style){ FactoryGirl.create(:style) }

    it "has method for determining one" do
      expect(user).to respond_to(:favorite_style)
    end

    it "without ratings does not have one" do
      expect(user.favorite_style).to eq(nil)
    end

    it "is the only style if only one rating" do
      create_beer_with_rating(FactoryGirl.create(:brewery), style, user, 25)

      expect(user.favorite_style).to eq(style)
    end

    it "is the one with highest rating if several rated" do
      create_beers_with_ratings(FactoryGirl.create(:brewery), FactoryGirl.create(:style), user, 10, 7, 9)
      create_beers_with_ratings(FactoryGirl.create(:brewery), style, user, 35, 45)
      create_beers_with_ratings(FactoryGirl.create(:brewery), FactoryGirl.create(:style), user, 50, 10, 15, 20)

      expect(user.favorite_style).to eq(style)
    end
  end

  describe "favorite brewery" do
    let(:user){ FactoryGirl.create(:user) }
    let(:style){ FactoryGirl.create(:style) }

    it "has method for determining one" do
      expect(user).to respond_to(:favorite_brewery)
    end

    it "without ratings does not have one" do
      expect(user.favorite_brewery).to eq(nil)
    end

    it "is the only brewery if only one rating" do
      brewery = FactoryGirl.create(:brewery) 
      beer = create_beer_with_rating(brewery, style, user, 25)

      expect(user.favorite_brewery).to eq(brewery)
    end

    it "is the one with highsest rating if several rated" do
      best = FactoryGirl.create(:brewery) 
      create_beers_with_ratings(FactoryGirl.create(:brewery), style, user, 10, 7, 9)
      create_beers_with_ratings(best, style, user, 35, 45)
      create_beers_with_ratings(FactoryGirl.create(:brewery), style, user, 50, 10, 15, 20)

      expect(user.favorite_brewery).to eq(best)
    end
  end
end
