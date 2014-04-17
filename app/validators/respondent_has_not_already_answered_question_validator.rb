class RespondentHasNotAlreadyAnsweredQuestionValidator < ActiveModel::EachValidator
  def validate_each( record, attribute, value )
    record.errors[attribute] << "Must enter user_name" if value.nil?
  end
end