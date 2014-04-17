user_names = [ "Zhyliana", 'Anthony', 'Bob', 'Jill' ]

users = user_names.map { |name| User.create!( user_name: name ) }

poll_titles = [ "Kitchen Survey", "Office Survey" ]

polls = poll_titles.map do |title|
  user_id = users.map(&:id).sample
  Poll.create!( title: title, author_id: user_id )
end

kitchen_question_texts = [
  "Who washed the dishes last night?",
  "Who left the milk on the couch?"
]

office_question_texts = [
  "Where's my bike?",
  "Where am I sleeping tonight?"
]


kitchen_questions = kitchen_question_texts.map do |text|
  poll_id = Poll.find_by(title: 'Kitchen Survey').id
  Question.create!( text: text, poll_id: poll_id )
end

office_questions = office_question_texts.map do |text|
    poll_id = Poll.find_by(title: 'Office Survey').id
    Question.create!( text: text, poll_id: poll_id )
end

kitchen_answer_choices = ["No one", "Wasn't me.", "I did!"]
kitchen_answer_choices.map do |text|
  kitchen_questions.map do |question|
    question_id = question.id
    AnswerChoice.create(question_id: question.id, text: text)
  end
end

office_answer_choices = ["Bathroom", "Couches"]
office_answer_choices.map do |text|
  office_questions.map do |question|
    question_id = question.id
    AnswerChoice.create(question_id: question.id, text: text)
  end
end

Response.create!(answer_choice_id: 1, respondent_id: 1 )
Response.create!(answer_choice_id: 2, respondent_id: 2 )

Response.create!(answer_choice_id: 3, respondent_id: 1 )
Response.create!(answer_choice_id: 4, respondent_id: 2 )




