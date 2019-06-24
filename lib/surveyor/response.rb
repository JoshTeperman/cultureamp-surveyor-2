module Surveyor
  class Response
    attr_reader :email, :answers
    def initialize(hash)
      @email = hash[:email]
      @answers = []
    end

    # def add_answer(answer)
    #   @answers.push(answer)
    # end
  end
end
