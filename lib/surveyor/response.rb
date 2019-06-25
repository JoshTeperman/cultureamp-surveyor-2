module Surveyor
  class Response
    attr_reader :email, :answers
    def initialize(response_hash)
      @email = response_hash[:email]
      @answers = []
    end

    def add_answer(answer)
      @answers.push(answer)
    end
  end
end
