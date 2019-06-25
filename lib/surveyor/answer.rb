module Surveyor
  class Answer
    attr_reader :question, :value

    def initialize(answer_hash)
      @question = answer_hash[:question]
      value = answer_hash[:value]
      @question.validate_answer(value)
      @value = value
    end

    # def value_is_valid?(value)
    #   raise ArgumentError, 'Invalid Answer: Answer value cannot be empty' if value.nil?
    #   raise ArgumentError, 'Invalid Answer: Answer value must be a String' if value.class != String
    #   raise ArgumentError, 'Invalid Answer: Answer value cannot be empty' if value.empty?
    #   raise ArgumentError, 'Invalid Answer: Answer value cannot be empty' if value =~ /\A\s*\z/

    #   true
    # end
  end
end
