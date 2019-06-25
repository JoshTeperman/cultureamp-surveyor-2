module Surveyor
  class Answer
    attr_reader :question, :value

    def initialize(answer_hash)
      @question = answer_hash[:question]
      value = answer_hash[:value]
      @question.validate_answer(value)
      @value = value
    end
  end
end
