require 'rails_helper'

describe "User" do
  let!(:user) { FactoryGirl.create :user }

  describe "who has signed up" do
    it "can signin with right credentials" do
      sign_in(username:'Pekka', password:'Foobar1')

      expect(page).to have_content 'Welcome back Pekka!'
      expect(page).to have_content 'Pekka'
    end

    it "is redirected back to signin form if wrong credentials given" do
      sign_in(username:'Pekka', password:'wrong')

      expect(current_path).to eq(signin_path)
      expect(page).to have_content 'Username and/or password mismatch'
    end

    it "when signed up with good credentials, is added to the system" do
      visit signup_path
      fill_in('user_username', with:'Brian')
      fill_in('user_password', with:'Secret55')
      fill_in('user_password_confirmation', with:'Secret55')

      expect{
        click_button('Create User')
      }.to change{User.count}.by(1)
    end

    describe "when have given ratings" do
      before :each do
        create_beers_with_ratings(FactoryGirl.create(:brewery), FactoryGirl.create(:style), user, 10, 20, 15, 7)
      end

      it "shows ratings made by the user on their page" do
        sign_in(username:'Pekka', password:'Foobar1')
        user2 = FactoryGirl.create(:user, username:"mikko")
        create_beers_with_ratings(FactoryGirl.create(:brewery), FactoryGirl.create(:style), user2, 22, 21, 5, 17)
        visit user_path user

        expect(page).to have_content 'has made 4 ratings'
        expect(page).to have_content '10 anonymous'
        expect(page).to have_content '20 anonymous'
        expect(page).to have_content '15 anonymous'
        expect(page).to have_content '7 anonymous'
      end

      it "rating is deleted from db when deleting" do
        sign_in(username:'Pekka', password:'Foobar1')
        create_beer_with_rating(FactoryGirl.create(:brewery), FactoryGirl.create(:style), user, 10)

        visit user_path user
        
        expect{
          first(:link, 'delete').click
        }.to change{user.ratings.count}.by(-1)
      end

      it "shows favorite beer" do
        visit user_path user

        expect(page).to have_content 'Favorite'
        expect(page).to have_content 'Beer: anonymous'
      end

      it "shows favorite style" do
        visit user_path user

        expect(page).to have_content 'Favorite'
        expect(page).to have_content 'Style: anonymous'
      end

      it "shows favorite brewery" do
        visit user_path user

        expect(page).to have_content 'Favorite'
        expect(page).to have_content 'Brewery: anonymous'
      end
    end
  end
end