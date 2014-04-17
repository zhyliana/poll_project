class Response < ActiveRecord::Base
  validates :answer_choice_id, :respondent_id, presence: true
  validate :respondent_has_not_already_answered_question
  validate :author_is_not_respondent

  belongs_to :question_answered, through: :answer_choice, source: :question, class_name: 'Question'

  belongs_to :answer_choice, foreign_key: :answer_choice_id, primary_key: :id, class_name: 'AnswerChoice'

  belongs_to :respondent, foreign_key: :respondent_id, primary_key: :id, class_name: 'User'


  def respondent_has_not_already_answered_question
    unless existing_responses.empty?
      errors[:base] << "This respondent already answered this question."
    end
  end

  private

  def existing_responses
    Response.find_by_sql([<<-SQL, self.respondent_id, self.answer_choice_id])
    SELECT
      responses.*
    FROM
      responses
    JOIN
      answer_choices
    ON
      answer_choices.id = responses.answer_choice_id
    WHERE
      responses.respondent_id = ? AND
      answer_choices.question_id IN (
        SELECT
          question_id
        FROM
          answer_choices
        WHERE
          id = ?
        )
    SQL

  end

  def author_is_not_respondent
    AnswerChoice.includes(:question => :poll)
                .where('answer_choices.id = ? AND polls.author_id = ?',
                self.answer_choice_id,
                self.respondent_id
                ).empty?
  end
end
