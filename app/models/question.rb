class Question < ActiveRecord::Base
  validates :text, :poll_id, presence: true

  belongs_to( 
             :poll,
             :foreign_key => :poll_id,
             :primary_key => :id,
             :class_name => 'Poll'
             )

  has_many(
           :answer_choices,
           :foreign_key => :question_id,
           :primary_key => :id,
           :class_name  => 'AnswerChoice'
           )

  def results
    Question.joins(answer_choices: [:responses])
            .where('questions.id = ?', self.id')
            .group('answer_choices.text')
            .count
  end
end
