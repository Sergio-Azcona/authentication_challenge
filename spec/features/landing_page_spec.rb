require 'rails_helper'

RSpec.describe 'Landing Page' do
    before(:each) do 
        @user1 = User.create!(name: "User One", email: "user1@test.com", password: 'mikepizza1258', password_confirmation:'mikepizza1258')
        @user2 = User.create!(name: "User Two", email: "user2@test.com", password: 'boppizza1258', password_confirmation:'boppizza1258')
        visit '/'
    end 

    it 'has a header' do
        expect(page).to have_content('Viewing Party Lite')
    end

    it 'has links/buttons that link to correct pages' do 
        click_button "Create New User"
        
        expect(current_path).to eq(register_path) 
        
        visit '/'

        click_link "Home"
        expect(current_path).to eq(root_path)
    end 

    it 'lists out existing users' do 
        expect(page).to have_content('Existing Users:')

        within('.existing-users') do 
            expect(page).to have_link(@user1.email, href: user_path(@user1))
            expect(page).to have_link(@user2.email, href: user_path(@user2))
        end     
    end 

    it "has a link for 'Log In'; when click, the user is take to the Login page" do 

        click_link "Log In"
        expect(current_path).to eq(login_path)
    end

end