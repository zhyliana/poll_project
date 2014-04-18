class User < ActiveRecord::Base
  validates :user_name, presence: true

  has_many(
           :authored_polls,
           :foreign_key => :author_id,
           :primary_key => :id,
           :class_name => 'Poll'
           )

  has_many(
           :responses,
           :foreign_key => :respondent_id,
           :primary_key => :id,
           :class_name => 'Response'
           )

 has_many(
          :answer_choices,
          :through => :responses,
          :source => :answer_choice,
          :class_name => 'AnswerChoice'
          )

  # has_many(
  #          :questions_answered,
  #          :through => :responses,
  #          :source => :question_answered,
  #          :class_name => 'Question'
  #          )

  # has_many(
  #          :questions_answered,
  #          :through => :answer_choices,
  #          :source => :question
  #          )

  # def completed_polls
  #   # Poll.select.where('self.id = polls.author_id')
  #   User.includes(:responses => :question_answered)
  #       .where('responses.respondent_id = self.id')
  # end

end