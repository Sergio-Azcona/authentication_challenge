require 'rails_helper'

RSpec.describe 'Landing Page' do
    before(:each) do 
        @user1 = User.create!(name: "User One", email: "user1@test.com", password: 'mikepizza1258', password_confirmation:'mikepizza1258')
        @user2 = User.create!(name: "User Two", email: "user2@test.com", password: 'boppizza1258', password_confirmation:'boppizza1258')
        @user3 = User.create!(name: "User Three", email: "user3@test.com", password: '3userid!', password_confirmation:'3userid!')
        @user4 = User.create!(name: "User Four", email: "user4@test.com", password: '4userid!', password_confirmation:'4userid!')
        visit '/'
    end 

    it 'has a header' do
        expect(page).to have_content('Viewing Party Lite')
    end

    it 'has links/buttons that link to correct pages' do 
        click_link "Create New User"
        
        expect(current_path).to eq(register_path) 
        
        visit login_path

        click_link "Home"
        expect(current_path).to eq(root_path)
    end 

    xit 'lists out existing users' do 
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

    describe 'Authorization Challenge' do 
        describe 'Part 1 -User state determines log in, log out, create options' do
            it 'displays log in and create options if user is not logged in; log out is NOT displayed' do
                # save_and_open_page
                expect(page).to have_link("Log In", href: login_path )
                expect(page).to have_link("Create New User", href: register_path )
                expect(page).to_not have_link("Log Out", href: logout_path )

            end

            it 'display the logout option when user is logged in, the login/create options are NOT displayed' do
                click_link "Log In"
                
                fill_in :email, with:'user1@test.com'
                fill_in :password, with: 'mikepizza1258'
                click_button('Log In')

                expect(current_path).to eq(dashboard_path(@user1))
                expect(page).to_not have_link("Log In", href: login_path )
                expect(page).to_not have_link("Create New User", href: register_path )
                expect(page).to have_link("Log Out", href: logout_path )

            end


        end

        describe 'Part 2' do
            describe  'Task 3: User Story 1 & Task 4: User Story #2' do 
                it 'when NOT logged in - lists out existing users wihtout links' do
                    expect(page).to have_content('Please Register or Sign In')
            
                        expect(page).to_not have_content(@user1.email)
                        expect(page).to_not have_content(@user2.email)
                        expect(page).to_not have_content(@user3.email)
                        expect(page).to_not have_content(@user4.email)
                end

                it 'when logged in - lists out existing users wihtout links' do
                    click_link "Log In"
                    fill_in :email, with: 'user1@test.com'
                    fill_in :password, with: 'mikepizza1258'
                    click_button('Log In')
                    
                    click_link "Home"
                    expect(page).to have_content('Existing Users:')
            
                    within('.existing-users') do 
                        expect(page).to have_content(@user1.email)
                        expect(page).to have_content(@user2.email)
                        expect(page).to have_content(@user3.email)
                        expect(page).to have_content(@user4.email)
                    end  
                end
            end

            describe 'Task 5: User Story #3 - a variation' do
                describe 'displays link to dasboard and home if user is not on that page' do
                    it 'displays a link to user dashboard when they are not on the dashoboad page' do
                        
                        
                        click_link "Log In"
                        fill_in :email, with: 'user1@test.com'
                        fill_in :password, with: 'mikepizza1258'
                        click_button('Log In')
                        
                        expect(page).to_not have_link('Dasboard', href: dashboard_path(@user1))
                        expect(page).to have_link('Home', href: root_path)

                        click_link "Home"
                        expect(page).to_not have_link('Home', href: root_path)
                        expect(page).to have_link('Dasboard', href: dashboard_path(@user1))
                    end
                end
            end
        end
    end
end