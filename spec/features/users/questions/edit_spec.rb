require 'rails_helper'

RSpec.describe 'As a user' do
  describe 'I can update a professional or technical question' do
    before :each do
      @user = create(:user)
      @user.confirm

      visit '/'

      expect(page).to have_content("Sign In")

      click_on "Sign In"

      expect(current_path).to eq('/users/sign_in')

      fill_in :user_email, with: @user.email
      fill_in :user_password, with: @user.password

      click_on "Log in"

      expect(current_path).to eq("/")

      @question_1 = Question.create!({subject: "Ruby methods",
                                      content: "What is attr_reader?",
                                      upvotes: 1,
                                      forum: 0,
                                      user_id: @user.id})

      @question_2 = Question.create!({subject: "Jobs",
                                      content: "Why can't I get a job?",
                                      upvotes: 1,
                                      forum: 1,
                                      user_id: @user.id})

      @question_3 = Question.create!({subject: "Ruby methods",
                                      content: "What is attr_accessor?",
                                      upvotes: 1,
                                      forum: 0,
                                      user_id: @user.id})

      @question_4 = Question.create!({subject: "Interviews",
                                      content: "Best interview practices",
                                      upvotes: 1,
                                      forum: 1,
                                      user_id: @user.id})
    end

  end

  it "I can update a question" do
    visit '/profile'

    within "#question-#{@question_1}" do
      click_on @question_1.subject
    end

    expect(current_path).to eq("/questions/#{@question_1.id}")
  end
end