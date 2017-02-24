require 'rails_helper'

include Helpers

describe "Beers page" do
  let!(:user) { FactoryGirl.create :user }
  let!(:style) { FactoryGirl.create :style }
  
  describe "when logged in" do
    before :each do
      sign_in(username:'Pekka', password:'Foobar1')
      FactoryGirl.create(:brewery)
    end

    it "allows user to add a Beer if name is valid" do
      visit new_beer_path

      fill_in('Name', with:'Kalja')
      select('anonymous', from:'Style')
      select('anonymous', from:'Brewery')

      expect{
        click_button('Create Beer')
      }.to change{Beer.count}.by(1)
    end

    it "shows error entering Beer without a valid name" do
      visit new_beer_path

      fill_in('Name', with:'')
      select('anonymous', from:'Style')
      select('anonymous', from:'Brewery')

      expect{
        click_button('Create Beer')
      }.to change{Beer.count}.by(0)
      expect(page).to have_content "Name can't be blank"
    end
  end
end