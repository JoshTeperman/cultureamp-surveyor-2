module Surveyor
  class RatingQuestion < Question
    def valid_answer?(answer)
      answer < 6 && answer.positive?
    end
  end
end