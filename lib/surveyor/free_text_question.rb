module Surveyor
  class FreeTextQuestion < Question
    def validate_answer(answer_value)
      raise ArgumentError, 'Invalid Answer: Answer value cannot be empty' if answer_value.nil?
      raise ArgumentError, 'Invalid Answer: Answer value must be a String' if answer_value.class != String
      raise ArgumentError, 'Invalid Answer: Answer value cannot be empty' if answer_value.empty?
      raise ArgumentError, 'Invalid Answer: Answer value cannot be empty' if answer_value =~ /\A\s*\z/
      true
    end
  end
end
