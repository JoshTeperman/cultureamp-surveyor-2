module Surveyor
  class Answer
    attr_reader :question
    def initialize(hash)
      question = hash[:question]
      question_is_valid?(question)
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
  end
end
