module Surveyor
  class RatingQuestion < Question
    def validate_answer(answer_value)
      raise(ArgumentError, 'Invalid Answer: Answer value cannot be empty') if answer_value.class == String && answer_value.empty?
      raise(ArgumentError, 'Invalid Answer: Answer value cannot be empty') if answer_value.nil?
      raise ArgumentError, 'Invalid Answer: Answer value cannot be empty' if answer_value =~ /\A\s*\z/
      raise(ArgumentError, 'Invalid Answer: Answer must be a positive whole number') unless answer_value.class == Integer
      raise(ArgumentError, 'Invalid Answer: Outside of Range') if answer_value < 1 || answer_value > 5

      true
    end
  end
end
