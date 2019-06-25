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

    def find_user_response(email)
      @responses.find { |response| response.email =~ /\b#{email}\b/ }
    end

    def user_responded?(email)
      find_user_response(email) != nil
    end
  end
end
