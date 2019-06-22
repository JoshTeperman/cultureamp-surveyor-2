module Surveyor
  class Survey
    attr_reader :name, :questions, :responses

    def initialize(hash)
      @name = hash[:name]
      @questions = []
      @responses = []
    end

    def add_question(question)
      @questions.push(question)
    end

    def add_response(response)
      @responses.push(response)
    end
  end
end
