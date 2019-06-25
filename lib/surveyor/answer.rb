module Surveyor
  class Answer
    attr_reader :question, :value

    def initialize(hash)
      value = hash[:value]
      question = hash[:question]
      question_is_valid?(question)
      value_is_valid?(value)
      @value = value
      @question = question
    end

    def question_is_valid?(question)
      raise ArgumentError, 'Invalid Question: Question cannot be empty' if question.nil?
      raise ArgumentError, 'Invalid Question: Question must be a String' unless question.class == String
      raise ArgumentError, 'Invalid Question: Question cannot be empty' if question.empty?
      raise ArgumentError, 'Invalid Question: Question cannot be empty' if question =~ /\A\s*\z/
      raise ArgumentError, 'Invalid Question: Question must be more than three characters long' unless question.length > 3

      true
    end

    def value_is_valid?(value)
      raise ArgumentError, 'Invalid Answer: Answer value cannot be empty' if value.nil?
      raise ArgumentError, 'Invalid Answer: Answer value must be a String' if value.class != String
      raise ArgumentError, 'Invalid Answer: Answer value cannot be empty' if value.empty?
      raise ArgumentError, 'Invalid Answer: Answer value cannot be empty' if value =~ /\A\s*\z/

      true
    end
  end
end
