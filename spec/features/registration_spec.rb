require 'rails_helper'

RSpec.describe "User Registration" do
  it 'can create a user with a name and unique email' do
    visit register_path

    fill_in :user_name, with: 'User One'
    fill_in :user_email, with:'uSER1@example.com'
    fill_in :user_password, with: 'pizza1258'
    fill_in :user_password_confirmation, with:'pizza1258'
    click_button 'Create New User'

    expect(current_path).to eq(user_path(User.last.id))
    expect(page).to have_content("User One's Dashboard")
  end 

  it 'does not create a user if email isnt unique' do 
    User.create!(name: 'User One', email: 'notunique@example.com', password: 'mikepizza1258', password_confirmation:'mikepizza1258')

    visit register_path
    # require 'pry';binding.pry
    fill_in :user_name, with: 'User Two'
    fill_in :user_email, with:'notunique@example.com'
    fill_in :user_password, with: 'pizza1258'
    fill_in :user_password_confirmation, with:'pizza1258'
    click_button 'Create New User'

    expect(current_path).to eq(register_path)
    expect(page).to have_content("Email has already been taken")
    
  end

  describe 'Authentication Process' do
    describe 'a form to fill in my name, email, password, and password confirmation' do
      before(:each)do
        visit register_path
      end

      it "takes user to their dashboard page '/users/:id' when form is completed" do
        fill_in :user_name, with: 'User One'
        fill_in :user_email, with:'user1@example.com'
        fill_in :user_password, with: 'pizza1258'
        fill_in :user_password_confirmation, with:'pizza1258'
        click_button 'Create New User'

        new_user = User.last
        expect(current_path).to eq("/users/#{new_user.id}")

        expect(page).to have_content("Welcome, #{new_user.name}!")
      end

      describe 'sad path-requires all fields be filled' do
        it "returns user to registration page if user_name field is not complete" do
          # fill_in :user_name, with: 
          fill_in :user_email, with:'user1@example.com'
          fill_in :user_password, with: 'pizza1258'
          fill_in :user_password_confirmation, with:'pizza1258'
          click_button 'Create New User'
          
          expect(current_path).to eq(register_path)
          # save_and_open_page
          expect(page).to have_content("Name can't be blank")
        end

        it "returns user to registration page if password field is not complete" do
          fill_in :user_name, with: 'User One'
          fill_in :user_email, with:'user1@example.com'
    
          fill_in :user_password_confirmation, with:'pizza1258'
          click_button 'Create New User'

          expect(current_path).to eq(register_path)
          expect(page).to have_content("Password digest can't be blank and Password can't be blank")
        end

        it "returns user to registration page if password confirmation field is not complete" do
          fill_in :user_name, with: 'User One'
          fill_in :user_email, with:'user1@example.com'
          fill_in :user_password, with: 'pizza1258bop'
    
          click_button 'Create New User'

          expect(current_path).to eq(register_path)
          expect(page).to have_content("Password confirmation doesn't match Password")
        end
      end
    end
  end
end
