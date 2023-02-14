require 'rails_helper'

RSpec.describe 'Login Page' do

  describe 'log in credentials required in Log In Page form' do
    before(:each) do
      @user1= User.create!(name: 'User One', email: 'user1email@example.com', password: '1userpassword!', password_confirmation:'1userpassword!')
      @user2= User.create!(name: 'User two', email: 'user2email@example.com', password: '2userpassword', password_confirmation:'2userpassword')
      visit(login_path)
    end
    
    describe "When I enter my unique email and correct password" do
        it "I'm taken to my dashboard page" do
          fill_in :email, with:'user1email@example.com'
          fill_in :password, with: '1userpassword!'
          click_button('Log In')
          
          expect(current_path).to eq(user_path(@user1))
          expect(page).to have_content("Welcome, #{@user1.name}!")
        end

        it "upcased email address input - I'm taken to my dashboard page" do
          fill_in :email, with:'USER1emAIl@example.com'
          fill_in :password, with: '1userpassword!'
          click_button('Log In')
          
          expect(current_path).to eq(user_path(@user1))
          expect(page).to have_content("Welcome, #{@user1.name}!")
        end

        describe 'sad path-failure to provide correct credentials' do
          it 'returns user to the Log In page to complete form and display a flash message' do
            fill_in :email, with:'user2email@example.com'
            fill_in :password, with: 'bananas_is_not_even_in_the_database!'
            click_button('Log In')
            
            expect(current_path).to eq(login_path)
            expect(page).to have_content("Sorry, your credentials are bad.")

            fill_in :email, with:'user2email@example.com'
            fill_in :password, with: '1userpassword!'
            click_button('Log In')

            expect(current_path).to eq(login_path)
            expect(page).to have_content("Sorry, your credentials are bad.")

            fill_in :email, with:'user2email@example.com'
            fill_in :password, with: '2userpassword'
            click_button('Log In')

            expect(current_path).to eq(user_path(@user2))
            expect(page).to have_content("Welcome, #{@user2.name}!")
          end
        end
    end
  end


end