require 'rails_helper'

include Helpers

describe "Rating" do
  let!(:brewery) { FactoryGirl.create :brewery, name: "Koff" }
  let!(:style) { FactoryGirl.create :style }
  let!(:beer1) { FactoryGirl.create :beer, name:"iso 3" }
  let!(:beer2) { FactoryGirl.create :beer, name:"Karhu" }
  let!(:user) {FactoryGirl.create :user }

  before :each do
    @user = sign_in(username:'Pekka', password:'Foobar1')
  end

  it "when given, is registered to the beer and user who is signed in" do
    visit new_rating_path
    select('iso 3', from:'rating[beer_id]')
    fill_in('rating[score]', with:'15')

    expect{
      click_button "Create Rating"
    }.to change{Rating.count}.from(0).to(1)

    expect(user.ratings.count).to eq(1)
    expect(beer1.ratings.count).to eq(1)
    expect(beer1.average_rating).to eq(15.0)
  end

  it "shows recent ratings made by users" do
    user2 = FactoryGirl.create(:user, username:"mikko")
    create_beers_with_ratings(brewery, style, user2, 22, 21, 5, 17)
    create_beers_with_ratings(brewery, style, user, 10, 20, 15, 7, 9)

    visit ratings_path

    expect(page).to have_content '10 anonymousPekka'
    expect(page).to have_content '20 anonymousPekka'
  end
end