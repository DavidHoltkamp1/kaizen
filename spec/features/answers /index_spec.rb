require 'rails_helper'

RSpec.describe 'As a Visitor' do 
    describe 'When I visit a questions show page' do 
        before :each do 
            user = create(:user)
            user.confirm
      
            @question_1 = Question.create!({subject: "Ruby methods",
                                            content: "What is attr_reader?",
                                            upvotes: 1,
                                            forum: 0,
                                            user_id: user.id})
            
            @answer_1 = @question_1.answers.create!({content: "The attr_reader lets other read your code.",
                                                     upvotes: 1,
                                                     user_id: user.id

            })

            @answer_2 = @question_1.answers.create!({content: "the attr_reader allows methods in the file to be read by other files.",
                                                     upvotes: 1,
                                                     user_id: user.id

            })

            visit "/technical_forum/#{@question_1.id}"

            expect(current_path).to eq("/technical_forum/#{@question_1.id}")
        end


        it 'I see a list of answers to that quesiton' do 

            expect(page).to have_content(@answer_1.content)
            expect(page).to have_content(@answer_2.content)

        end
    end
end
