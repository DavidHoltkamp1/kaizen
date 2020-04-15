require 'rails_helper'

RSpec.describe 'As a User' do
  describe 'When I visit my profile page', :vcr do
    before :each do
      @user = create(:user)
      @user.confirm

      visit '/'

      expect(page).to have_content('Sign In')

      click_on 'Sign In'

      expect(current_path).to eq('/users/sign_in')

      fill_in :user_email, with: @user.email
      fill_in :user_password, with: @user.password

      click_on 'Log in'

      expect(current_path).to eq('/')

      click_on 'Profile'

      expect(current_path).to eq(profile_path)
    end

    it 'I can edit my profile', :vcr do
      expect(page).to have_link('Edit')

      click_on 'Edit'

      expect(current_path).to eq('/profile/edit')

      fill_in :last_name, with: 'McFakerson'

      click_on 'Submit'

      expect(current_path).to eq('/profile')

      expect(page).to have_content('McFakerson')
      expect(page).not_to have_content(@user.last_name)
    end

    it 'I can edit my password seperately from editing my profile', :vcr do
      expect(page).to have_link('Change your password')

      click_on 'Change your password'

      expect(current_path).to eq('/users/edit')

      fill_in :user_password, with: 'FakePassword'
      fill_in :user_password_confirmation, with: 'FakePassword'
      fill_in :user_current_password, with: @user.password

      click_on 'Update'

      expect(current_path).to eq('/')
    end
  end
end
